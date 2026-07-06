import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../data/mock/mock_conversations_repository.dart';
import '../../../data/models/conversation.dart';
import '../../../data/models/conversation_page.dart';
import '../../../data/models/message.dart';
import '../../../data/models/message_page.dart';
import '../../../data/models/message_search_page.dart';
import '../../../data/models/shared_media_item.dart';
import '../../../data/repositories/conversations_repository.dart';
import '../../authentication/data/auth_providers.dart';
import 'api/api_conversations_repository.dart';
import 'api/messaging_api.dart';
import 'local/database/messaging_database_lifecycle.dart';
import 'offline/messaging_offline_coordinator.dart';
import 'realtime/messaging_socket_coordinator.dart';
import 'realtime/messaging_socket_service.dart';
import 'repository/offline_first_conversations_repository.dart';
import '../presentation/controllers/conversations_controller.dart';
import '../presentation/controllers/messaging_controller.dart';

final messagingApiProvider = Provider<MessagingApi>((ref) {
  return MessagingApi(ref.watch(apiClientProvider).dio);
});

final apiConversationsRepositoryProvider = Provider<ApiConversationsRepository>(
  (ref) {
    return ApiConversationsRepository(
      messagingApi: ref.watch(messagingApiProvider),
      errorMapper: ref.watch(apiErrorMapperProvider),
      sessionManager: ref.watch(authSessionManagerProvider),
    );
  },
);

final messagingDatabaseLifecycleProvider = Provider<MessagingDatabaseLifecycle>(
  (ref) {
    ref.keepAlive();
    final lifecycle = MessagingDatabaseLifecycle();
    ref.onDispose(() {
      lifecycle.close();
    });
    return lifecycle;
  },
);

final messagingOfflineCoordinatorProvider =
    Provider<MessagingOfflineCoordinator>((ref) {
      final coordinator = MessagingOfflineCoordinator(
        lifecycle: ref.watch(messagingDatabaseLifecycleProvider),
        sessionManager: ref.watch(authSessionManagerProvider),
        socketService: ref.watch(messagingSocketServiceProvider),
        socketCoordinator: ref.watch(messagingSocketCoordinatorProvider),
        remote: ref.watch(apiConversationsRepositoryProvider),
        connectivity: Connectivity(),
      );
      ref.onDispose(() {
        coordinator.dispose();
      });
      return coordinator;
    });

final offlineConversationsRepositoryProvider =
    FutureProvider<OfflineFirstConversationsRepository>((ref) async {
      ref.keepAlive();
      final coordinator = ref.watch(messagingOfflineCoordinatorProvider);
      return coordinator.ensureReady();
    });

final conversationsRepositoryProvider = Provider<ConversationsRepository>((
  ref,
) {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return const MockConversationsRepository();
  }

  final offline = ref.watch(offlineConversationsRepositoryProvider);
  return offline.maybeWhen(
    data: (repository) => repository,
    orElse: () => _DeferredOfflineRepository(ref),
  );
});

/// Bridges startup until encrypted database is ready.
class _DeferredOfflineRepository implements ConversationsRepository {
  _DeferredOfflineRepository(this._ref);

  final Ref _ref;

  ApiConversationsRepository get _remote =>
      _ref.read(apiConversationsRepositoryProvider);

  Future<OfflineFirstConversationsRepository> get _repo async {
    return _ref.read(offlineConversationsRepositoryProvider.future);
  }

  Future<T> _withOfflineFallback<T>(
    Future<T> Function(OfflineFirstConversationsRepository repo) run,
    Future<T> Function() remoteFallback,
  ) async {
    try {
      return await run(await _repo);
    } on Object {
      return remoteFallback();
    }
  }

  Future<ConversationPage> _emptyConversationsPage() async {
    return const ConversationPage(items: [], nextCursor: null, hasMore: false);
  }

  @override
  Future<Conversation> createOrGetConversation(String userId) =>
      _withOfflineFallback(
        (repo) => repo.createOrGetConversation(userId),
        () => _remote.createOrGetConversation(userId),
      );

  @override
  Future<ConversationPage> getConversations({String? cursor, int limit = 20}) =>
      _withOfflineFallback(
        (repo) => repo.getConversations(cursor: cursor, limit: limit),
        _emptyConversationsPage,
      );

  @override
  Future<Conversation> getConversation(String conversationId) =>
      _withOfflineFallback(
        (repo) => repo.getConversation(conversationId),
        () => _remote.getConversation(conversationId),
      );

  @override
  Future<MessagePage> getMessages({
    required String conversationId,
    String? before,
    int limit = 50,
  }) => _withOfflineFallback(
    (repo) => repo.getMessages(
      conversationId: conversationId,
      before: before,
      limit: limit,
    ),
    () => _remote.getMessages(
      conversationId: conversationId,
      before: before,
      limit: limit,
    ),
  );

  @override
  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) => _withOfflineFallback(
    (repo) => repo.sendMessage(
      conversationId: conversationId,
      clientMessageId: clientMessageId,
      text: text,
    ),
    () => _remote.sendMessage(
      conversationId: conversationId,
      clientMessageId: clientMessageId,
      text: text,
    ),
  );

  @override
  Future<void> markDelivered(String messageId) => _withOfflineFallback(
    (repo) => repo.markDelivered(messageId),
    () => _remote.markDelivered(messageId),
  );

  @override
  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  }) => _withOfflineFallback(
    (repo) => repo.markConversationRead(
      conversationId: conversationId,
      throughMessageId: throughMessageId,
    ),
    () => _remote.markConversationRead(
      conversationId: conversationId,
      throughMessageId: throughMessageId,
    ),
  );

  @override
  Future<Conversation> updateMute({
    required String conversationId,
    DateTime? mutedUntil,
  }) => _withOfflineFallback(
    (repo) =>
        repo.updateMute(conversationId: conversationId, mutedUntil: mutedUntil),
    () => _remote.updateMute(
      conversationId: conversationId,
      mutedUntil: mutedUntil,
    ),
  );

  @override
  Future<Conversation> updateDisappearingMessages({
    required String conversationId,
    required int durationSeconds,
  }) => _withOfflineFallback(
    (repo) => repo.updateDisappearingMessages(
      conversationId: conversationId,
      durationSeconds: durationSeconds,
    ),
    () => _remote.updateDisappearingMessages(
      conversationId: conversationId,
      durationSeconds: durationSeconds,
    ),
  );

  @override
  Future<MessageSearchPage> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) => _withOfflineFallback(
    (repo) => repo.searchMessages(
      conversationId: conversationId,
      query: query,
      cursor: cursor,
      limit: limit,
    ),
    () => _remote.searchMessages(
      conversationId: conversationId,
      query: query,
      cursor: cursor,
      limit: limit,
    ),
  );

  @override
  Future<List<SharedMediaItem>> getSharedMedia(String conversationId) =>
      _withOfflineFallback(
        (repo) => repo.getSharedMedia(conversationId),
        () => _remote.getSharedMedia(conversationId),
      );
}

final messagingSocketServiceProvider = Provider<MessagingSocketService>((ref) {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return FakeMessagingSocketService();
  }
  return SocketIoMessagingSocketService();
});

final messagingSocketCoordinatorProvider = Provider<MessagingSocketCoordinator>(
  (ref) {
    final coordinator = MessagingSocketCoordinator(
      socketService: ref.watch(messagingSocketServiceProvider),
      sessionManager: ref.watch(authSessionManagerProvider),
      apiBaseUrl: () => AppConfig.fromEnvironment().apiBaseUrl,
    );
    ref.onDispose(coordinator.dispose);
    return coordinator;
  },
);

final conversationsProvider =
    StateNotifierProvider<ConversationsController, ConversationsState>((ref) {
      return ConversationsController(
        ref.watch(conversationsRepositoryProvider),
        ref: ref,
      );
    });

final messagingProvider =
    StateNotifierProvider<MessagingController, MessagingState>((ref) {
      return MessagingController(
        ref: ref,
        repository: ref.watch(conversationsRepositoryProvider),
        socketService: ref.watch(messagingSocketServiceProvider),
        socketCoordinator: ref.watch(messagingSocketCoordinatorProvider),
        sessionManager: ref.watch(authSessionManagerProvider),
      );
    });
