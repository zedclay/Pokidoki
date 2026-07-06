import 'dart:async';
import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../core/network/auth_session_manager.dart';
import '../api/api_conversations_repository.dart';
import '../local/database/messaging_database.dart';
import '../local/database/messaging_database_lifecycle.dart';
import '../realtime/messaging_socket_coordinator.dart';
import '../realtime/messaging_socket_models.dart';
import '../realtime/messaging_socket_service.dart';
import '../repository/offline_first_conversations_repository.dart';
import '../sync/messaging_sync_engine.dart';
import '../sync/outbound_message_queue_processor.dart';

/// Wires encrypted database, sync engine, socket events, and queue processing.
class MessagingOfflineCoordinator {
  MessagingOfflineCoordinator({
    required MessagingDatabaseLifecycle lifecycle,
    required AuthSessionManager sessionManager,
    required MessagingSocketService socketService,
    required MessagingSocketCoordinator socketCoordinator,
    required ApiConversationsRepository remote,
    required Connectivity connectivity,
  }) : _lifecycle = lifecycle,
       _sessionManager = sessionManager,
       _socket = socketService,
       _socketCoordinator = socketCoordinator,
       _remote = remote,
       _connectivity = connectivity;

  final MessagingDatabaseLifecycle _lifecycle;
  final AuthSessionManager _sessionManager;
  final MessagingSocketService _socket;
  final MessagingSocketCoordinator _socketCoordinator;
  final ApiConversationsRepository _remote;
  final Connectivity _connectivity;

  MessagingDatabase? _database;
  OfflineFirstConversationsRepository? _repository;
  MessagingSyncEngine? _syncEngine;
  OutboundMessageQueueProcessor? _queueProcessor;

  final List<StreamSubscription<dynamic>> _subscriptions = [];
  Future<OfflineFirstConversationsRepository>? _ensureReadyFuture;

  bool get _testMode => Platform.environment.containsKey('FLUTTER_TEST');

  OfflineFirstConversationsRepository? get repository => _repository;

  Future<OfflineFirstConversationsRepository> ensureReady() async {
    final existing = _repository;
    if (existing != null) {
      return existing;
    }
    try {
      _ensureReadyFuture ??= _ensureReadyOnce();
      return await _ensureReadyFuture!;
    } on Object {
      _ensureReadyFuture = null;
      rethrow;
    }
  }

  Future<OfflineFirstConversationsRepository> _ensureReadyOnce() async {
    _database = await _lifecycle.open();
    _syncEngine = MessagingSyncEngine(
      database: _database!,
      remote: _remote,
      currentUserId: () => _sessionManager.currentUser?.id,
    );
    _queueProcessor = OutboundMessageQueueProcessor(
      database: _database!,
      remote: _remote,
      socketService: _socket,
      syncEngine: _syncEngine!,
      currentUserId: () => _sessionManager.currentUser?.id,
    );
    _lifecycle.attachQueueProcessor(_queueProcessor!);
    _repository = OfflineFirstConversationsRepository(
      database: _database!,
      remote: _remote,
      syncEngine: _syncEngine!,
      queueProcessor: _queueProcessor!,
      currentUserId: () => _sessionManager.currentUser?.id,
    );
    await _queueProcessor!.recoverStaleJobs();
    _bindSocketEvents();
    _bindReconnectAndDrain();
    _bindConnectivity();
    unawaited(_queueProcessor!.requestDrain());
    return _repository!;
  }

  void _bindSocketEvents() {
    final sync = _syncEngine;
    if (sync == null) {
      return;
    }
    _subscriptions.add(
      _socket.messageCreatedStream.listen((event) {
        unawaited(sync.handleMessageCreated(event.rawMessage));
      }),
    );
    _subscriptions.add(
      _socket.messageDeliveredStream.listen((event) {
        unawaited(sync.handleMessageDelivered(messageId: event.messageId));
      }),
    );
    _subscriptions.add(
      _socket.messageReadStream.listen((event) {
        unawaited(sync.handleMessageRead(messageId: event.messageId));
      }),
    );
    _subscriptions.add(
      _socket.conversationUpdatedStream.listen((event) {
        unawaited(sync.handleConversationUpdated(event.rawConversation));
      }),
    );
    _subscriptions.add(
      _socket.conversationSettingsUpdatedStream.listen((event) {
        unawaited(
          sync.handleConversationSettingsUpdated(
            conversationId: event.conversationId,
            disappearingSeconds: event.disappearingSeconds,
            rawSystemMessage: event.rawSystemMessage,
          ),
        );
      }),
    );
    _subscriptions.add(
      _socket.messageDeletedStream.listen((event) {
        unawaited(sync.handleMessageDeleted(messageId: event.messageId));
      }),
    );
  }

  void _bindReconnectAndDrain() {
    _subscriptions.add(
      _socket.statusStream.listen((status) {
        if (status == MessagingSocketStatus.reconnecting) {
          _socketCoordinator.scheduleReconnect();
        }
        if (status == MessagingSocketStatus.connected) {
          unawaited(_onTransportRestored());
        }
      }),
    );
  }

  Future<void> _onTransportRestored() async {
    final processor = _queueProcessor;
    if (processor == null) {
      return;
    }
    await processor.releaseWaitingRetries();
    await processor.requestDrain();
    await _syncEngine?.refreshConversations();
  }

  void _bindConnectivity() {
    _subscriptions.add(
      _connectivity.onConnectivityChanged.listen((results) {
        final offline = results.every(
          (result) => result == ConnectivityResult.none,
        );
        if (!offline) {
          unawaited(_onTransportRestored());
        }
      }),
    );
  }

  Future<void> onAuthenticatedBootstrap() async {
    if (_testMode) {
      return;
    }
    await ensureReady();
    await _syncEngine?.refreshConversations();
    await _syncEngine?.purgeExpiredMessages();
    await _socketCoordinator.connectIfAuthenticated();
    await _queueProcessor?.requestDrain();
  }

  Future<void> onForeground() async {
    await _queueProcessor?.recoverStaleJobs();
    await _queueProcessor?.releaseWaitingRetries();
    await _syncEngine?.refreshConversations();
    await _syncEngine?.purgeExpiredMessages();
    await _socketCoordinator.connectIfAuthenticated();
    await _queueProcessor?.requestDrain();
  }

  Future<void> wipeOnLogout() async {
    if (_testMode) {
      return;
    }
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    _subscriptions.clear();
    _repository = null;
    _syncEngine = null;
    _queueProcessor = null;
    _database = null;
    _ensureReadyFuture = null;
    await _lifecycle.closeAndWipe();
  }

  Future<void> dispose() async {
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    _subscriptions.clear();
    await _lifecycle.close();
  }
}
