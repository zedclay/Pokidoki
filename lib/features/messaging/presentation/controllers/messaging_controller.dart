import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/network/auth_session_manager.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/models/conversation.dart';
import '../../../../data/models/message.dart';
import '../../../../data/models/shared_media_item.dart';
import '../../../../data/repositories/conversations_repository.dart';
import '../../data/api/messaging_api_mapper.dart';
import '../../data/api/messaging_api_models.dart';
import '../../data/messaging_failure.dart';
import '../../data/messaging_providers.dart';
import '../../data/messaging_stream_providers.dart';
import '../../data/realtime/messaging_socket_coordinator.dart';
import '../../data/realtime/messaging_socket_models.dart';
import '../../data/realtime/messaging_socket_service.dart';
import '../../domain/disappearing_duration_mapper.dart';
import '../../../settings/presentation/controllers/settings_controller.dart';
import '../../../social/presentation/controllers/social_graph_controller.dart';

class MessagingState {
  const MessagingState({
    required this.messagesByConversation,
    this.replyTo,
    this.isLoadingHistory = false,
    this.historyErrorKey,
    this.isPeerTyping = false,
    this.openConversationId,
    this.isLoadingOlder = false,
    this.hasMoreHistory = true,
  });

  final Map<String, List<ChatMessage>> messagesByConversation;
  final ChatMessage? replyTo;
  final bool isLoadingHistory;
  final String? historyErrorKey;
  final bool isPeerTyping;
  final String? openConversationId;
  final bool isLoadingOlder;
  final bool hasMoreHistory;

  List<ChatMessage> messagesFor(String conversationId) =>
      messagesByConversation[conversationId] ?? const [];

  MessagingState copyWith({
    Map<String, List<ChatMessage>>? messagesByConversation,
    ChatMessage? replyTo,
    bool clearReply = false,
    bool? isLoadingHistory,
    String? historyErrorKey,
    bool clearHistoryError = false,
    bool? isPeerTyping,
    String? openConversationId,
    bool clearOpenConversation = false,
    bool? isLoadingOlder,
    bool? hasMoreHistory,
  }) {
    return MessagingState(
      messagesByConversation:
          messagesByConversation ?? this.messagesByConversation,
      replyTo: clearReply ? null : (replyTo ?? this.replyTo),
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      historyErrorKey: clearHistoryError
          ? null
          : (historyErrorKey ?? this.historyErrorKey),
      isPeerTyping: isPeerTyping ?? this.isPeerTyping,
      openConversationId: clearOpenConversation
          ? null
          : (openConversationId ?? this.openConversationId),
      isLoadingOlder: isLoadingOlder ?? this.isLoadingOlder,
      hasMoreHistory: hasMoreHistory ?? this.hasMoreHistory,
    );
  }
}

class MessagingController extends StateNotifier<MessagingState> {
  MessagingController({
    required Ref ref,
    required ConversationsRepository repository,
    required MessagingSocketService socketService,
    required MessagingSocketCoordinator socketCoordinator,
    required AuthSessionManager sessionManager,
  }) : _ref = ref,
       _repository = repository,
       _socketService = socketService,
       _socketCoordinator = socketCoordinator,
       _sessionManager = sessionManager,
       super(_initialState()) {
    if (_offlineMode) {
      _subscribeTypingEvents();
    } else {
      _subscribeSocketEvents();
    }
    if (_sessionManager.hasAccessToken) {
      unawaited(_socketCoordinator.connectIfAuthenticated());
    }
    _sessionManager.addAccessTokenListener(_onAccessTokenChanged);
  }

  bool get _offlineMode => !Platform.environment.containsKey('FLUTTER_TEST');

  static MessagingState _initialState() {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return MessagingState(
        messagesByConversation: {
          for (final entry in MockSampleData.messages.entries)
            entry.key: List<ChatMessage>.of(entry.value),
        },
      );
    }
    return const MessagingState(messagesByConversation: {});
  }

  final Ref _ref;
  final ConversationsRepository _repository;
  final MessagingSocketService _socketService;
  final MessagingSocketCoordinator _socketCoordinator;
  final AuthSessionManager _sessionManager;
  final _uuid = const Uuid();

  final Set<String> _deliveredMarked = {};
  final Set<String> _seenMessageIds = {};
  final Set<String> _seenClientIds = {};
  final Map<String, String?> _historyCursors = {};
  Timer? _typingDebounce;
  Timer? _typingStopTimer;
  Timer? _typingIndicatorTimeout;
  StreamSubscription<dynamic>? _messageCreatedSub;
  StreamSubscription<dynamic>? _messageDeliveredSub;
  StreamSubscription<dynamic>? _messageReadSub;
  StreamSubscription<dynamic>? _conversationUpdatedSub;
  StreamSubscription<dynamic>? _conversationSettingsUpdatedSub;
  StreamSubscription<dynamic>? _messageDeletedSub;
  StreamSubscription<dynamic>? _typingStartedSub;
  StreamSubscription<dynamic>? _typingStoppedSub;
  ProviderSubscription<AsyncValue<List<ChatMessage>>>? _messagesWatchSub;
  String? _watchedConversationId;

  String? get _currentUserId => _sessionManager.currentUser?.id;

  Conversation? conversation(String conversationId) {
    return _ref
        .read(conversationsProvider.notifier)
        .conversationById(conversationId);
  }

  Future<void> openConversation(String conversationId) async {
    state = state.copyWith(
      openConversationId: conversationId,
      isPeerTyping: false,
    );
    if (conversation(conversationId) == null) {
      try {
        final conv = await _repository.getConversation(conversationId);
        _ref.read(conversationsProvider.notifier).upsertConversation(conv);
      } on Object {
        // Conversation may appear after list sync.
      }
    } else {
      await _ref
          .read(conversationsProvider.notifier)
          .refreshConversation(conversationId);
    }
    await _socketCoordinator.setActiveConversation(conversationId);
    if (_offlineMode) {
      _bindMessagesStream(conversationId);
    }
    await loadMessages(conversationId);
  }

  void _bindMessagesStream(String conversationId) {
    if (_watchedConversationId == conversationId) {
      return;
    }
    _unbindMessagesStream();
    _watchedConversationId = conversationId;
    _messagesWatchSub = _ref.listen<AsyncValue<List<ChatMessage>>>(
      messagesWatchProvider(conversationId),
      (previous, next) {
        next.whenData((messages) {
          if (!mounted) {
            return;
          }
          final map = Map<String, List<ChatMessage>>.of(
            state.messagesByConversation,
          );
          map[conversationId] = messages;
          state = state.copyWith(messagesByConversation: map);
          _maybeMarkIncomingRead(conversationId, messages);
        });
      },
      fireImmediately: true,
    );
  }

  void _unbindMessagesStream() {
    _messagesWatchSub?.close();
    _messagesWatchSub = null;
    _watchedConversationId = null;
  }

  void _maybeMarkIncomingRead(
    String conversationId,
    List<ChatMessage> messages,
  ) {
    if (state.openConversationId != conversationId) {
      return;
    }
    ChatMessage? lastIncoming;
    for (final message in messages.reversed) {
      if (!message.isOutgoing) {
        lastIncoming = message;
        break;
      }
    }
    if (lastIncoming != null) {
      unawaited(_markReadThrough(conversationId, lastIncoming.id));
    }
  }

  Future<void> closeConversation(String conversationId) async {
    if (!mounted) {
      return;
    }
    _stopTyping(conversationId);
    if (!mounted) {
      return;
    }
    state = state.copyWith(clearOpenConversation: true, isPeerTyping: false);
    _unbindMessagesStream();
    unawaited(_socketCoordinator.setActiveConversation(null));
  }

  Future<void> loadMessages(String conversationId, {String? before}) async {
    state = state.copyWith(isLoadingHistory: true, clearHistoryError: true);
    try {
      final page = await _repository.getMessages(
        conversationId: conversationId,
        before: before,
      );
      if (before == null) {
        _historyCursors[conversationId] = page.nextCursor;
      }
      final existing = state.messagesFor(conversationId);
      final merged = before == null ? page.items : [...page.items, ...existing];
      final map = Map<String, List<ChatMessage>>.of(
        state.messagesByConversation,
      );
      map[conversationId] = _dedupeMessages(_filterExpired(merged));
      state = state.copyWith(
        messagesByConversation: map,
        isLoadingHistory: false,
        isLoadingOlder: false,
        hasMoreHistory: page.hasMore,
      );
    } on MessagingFailure catch (failure) {
      state = state.copyWith(
        isLoadingHistory: false,
        historyErrorKey: failure.messageKey ?? 'messagingUnavailable',
      );
    } on Object {
      state = state.copyWith(
        isLoadingHistory: false,
        historyErrorKey: 'messagingUnavailable',
      );
    }
  }

  Future<void> loadOlderMessages(String conversationId) async {
    if (state.isLoadingOlder || !state.hasMoreHistory) {
      return;
    }
    final cursor = _historyCursors[conversationId];
    if (cursor == null) {
      return;
    }
    state = state.copyWith(isLoadingOlder: true);
    try {
      final page = await _repository.getMessages(
        conversationId: conversationId,
        before: cursor,
      );
      _historyCursors[conversationId] = page.nextCursor;
      final existing = state.messagesFor(conversationId);
      final merged = [...page.items, ...existing];
      final map = Map<String, List<ChatMessage>>.of(
        state.messagesByConversation,
      );
      map[conversationId] = _dedupeMessages(merged);
      state = state.copyWith(
        messagesByConversation: map,
        isLoadingOlder: false,
        hasMoreHistory: page.hasMore,
      );
    } on Object {
      state = state.copyWith(isLoadingOlder: false);
    }
  }

  void setReplyTo(ChatMessage? message) {
    state = state.copyWith(replyTo: message, clearReply: message == null);
  }

  Future<void> sendTextMessage(String conversationId, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }

    var conv = conversation(conversationId);
    if (conv == null) {
      try {
        conv = await _repository.getConversation(conversationId);
        _ref.read(conversationsProvider.notifier).upsertConversation(conv);
      } on Object {
        // Continue if conversation metadata is unavailable locally.
      }
    }
    if (!(conv?.canSend ?? true)) {
      return;
    }

    final clientMessageId = _uuid.v4();
    final reply = state.replyTo;

    if (_offlineMode) {
      try {
        await _repository.sendMessage(
          conversationId: conversationId,
          clientMessageId: clientMessageId,
          text: trimmed,
        );
        state = state.copyWith(clearReply: true);
      } on MessagingFailure {
        // Drift stream reflects failedPermanent status from the queue processor.
        state = state.copyWith(clearReply: true);
      } on Object {
        state = state.copyWith(clearReply: true);
      }
      return;
    }

    final sentAt = DateTime.now().toUtc();
    final optimistic = ChatMessage(
      id: 'local-$clientMessageId',
      conversationId: conversationId,
      clientMessageId: clientMessageId,
      senderId: _currentUserId ?? '',
      body: trimmed,
      sentAt: sentAt,
      isOutgoing: true,
      deliveryStatus: MessageDeliveryStatus.sending,
      replyToMessageId: reply?.id,
      replyPreview: reply?.body,
      expiresAt: DisappearingDurationMapper.expiresAtForSend(
        conv?.disappearingDurationHours,
        sentAt,
      ),
    );

    _appendMessage(conversationId, optimistic);
    _updateConversationPreview(
      conversationId,
      preview: trimmed,
      outgoing: true,
    );
    state = state.copyWith(clearReply: true);

    try {
      ChatMessage? serverMessage;
      if (_socketService.status == MessagingSocketStatus.connected) {
        final ack = await _socketService.sendMessage(
          conversationId: conversationId,
          clientMessageId: clientMessageId,
          text: trimmed,
        );
        if (ack.ok && ack.rawMessage != null) {
          serverMessage = mapMessageDto(
            MessageDto.fromJson(ack.rawMessage!),
            currentUserId: _currentUserId,
          );
        } else if (ack.code != null) {
          throw MessagingFailure(code: ack.code!);
        }
      }

      serverMessage ??= await _repository.sendMessage(
        conversationId: conversationId,
        clientMessageId: clientMessageId,
        text: trimmed,
      );

      _reconcileOptimistic(conversationId, clientMessageId, serverMessage);
    } on Object {
      _replaceMessage(
        conversationId,
        optimistic.copyWith(deliveryStatus: MessageDeliveryStatus.failed),
      );
    }
  }

  Future<void> retrySend(
    String conversationId,
    ChatMessage failedMessage,
  ) async {
    final clientMessageId = failedMessage.clientMessageId;
    if (clientMessageId == null) {
      return;
    }
    final conv = conversation(conversationId);
    if (!(conv?.canSend ?? true)) {
      return;
    }

    if (_offlineMode) {
      try {
        final offline = await _ref.read(
          offlineConversationsRepositoryProvider.future,
        );
        await offline.retrySend(
          conversationId: conversationId,
          clientMessageId: clientMessageId,
        );
      } on Object {
        _replaceMessage(
          conversationId,
          failedMessage.copyWith(deliveryStatus: MessageDeliveryStatus.failed),
        );
      }
      return;
    }

    _replaceMessage(
      conversationId,
      failedMessage.copyWith(deliveryStatus: MessageDeliveryStatus.sending),
    );

    try {
      ChatMessage? serverMessage;
      if (_socketService.status == MessagingSocketStatus.connected) {
        final ack = await _socketService.sendMessage(
          conversationId: conversationId,
          clientMessageId: clientMessageId,
          text: failedMessage.body,
        );
        if (ack.ok && ack.rawMessage != null) {
          serverMessage = mapMessageDto(
            MessageDto.fromJson(ack.rawMessage!),
            currentUserId: _currentUserId,
          );
        } else if (ack.code != null) {
          throw MessagingFailure(code: ack.code!);
        }
      }

      serverMessage ??= await _repository.sendMessage(
        conversationId: conversationId,
        clientMessageId: clientMessageId,
        text: failedMessage.body,
      );

      _reconcileOptimistic(conversationId, clientMessageId, serverMessage);
    } on Object {
      _replaceMessage(
        conversationId,
        failedMessage.copyWith(deliveryStatus: MessageDeliveryStatus.failed),
      );
    }
  }

  Future<void> searchViaApi({
    required String conversationId,
    required String query,
    String? cursor,
  }) {
    return _repository.searchMessages(
      conversationId: conversationId,
      query: query,
      cursor: cursor,
    );
  }

  void deleteMessage(String conversationId, String messageId) {
    final current = state
        .messagesFor(conversationId)
        .where((item) => item.id != messageId)
        .toList();
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = current;
    state = state.copyWith(messagesByConversation: map);
    if (current.isNotEmpty) {
      final last = current.last;
      _updateConversationPreview(
        conversationId,
        preview: last.body,
        outgoing: last.isOutgoing,
      );
    }
  }

  List<ChatMessage> searchMessages(String conversationId, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return const [];
    }
    return state
        .messagesFor(conversationId)
        .where(
          (message) =>
              message.type != MessageContentType.system &&
              (message.body.toLowerCase().contains(q) ||
                  (message.attachmentName?.toLowerCase().contains(q) ?? false)),
        )
        .toList();
  }

  List<SharedMediaItem> sharedMedia(String conversationId) => const [];

  List<Map<String, String>> sharedLinks(String conversationId) => const [];

  Future<void> setMuted(String conversationId, bool muted) async {
    final updated = await _repository.updateMute(
      conversationId: conversationId,
      mutedUntil: muted
          ? DateTime.now().toUtc().add(const Duration(days: 365))
          : null,
    );
    _ref.read(conversationsProvider.notifier).upsertConversation(updated);
  }

  Future<void> setBlocked(String conversationId, bool blocked) async {
    final conversation = this.conversation(conversationId);
    if (conversation == null) {
      return;
    }
    final graph = _ref.read(socialGraphProvider.notifier);
    try {
      if (blocked) {
        await graph.blockUser(
          userId: conversation.peerId,
          displayName: conversation.peerDisplayName,
          username: conversation.peerUsername,
          pokidokiId: _peerPokidokiId(conversation.peerId),
        );
        _ref
            .read(conversationsProvider.notifier)
            .upsertConversation(
              conversation.copyWith(isBlocked: true, canSend: false),
            );
      } else {
        await graph.unblockUser(conversation.peerId);
      }
      await _ref
          .read(conversationsProvider.notifier)
          .refreshConversation(conversationId);
    } on Object {
      rethrow;
    }
  }

  Future<void> setDisappearingHours(String conversationId, int? hours) async {
    final seconds = DisappearingDurationMapper.hoursToSeconds(hours) ?? 0;
    final updated = await _repository.updateDisappearingMessages(
      conversationId: conversationId,
      durationSeconds: seconds,
    );
    _ref.read(conversationsProvider.notifier).upsertConversation(updated);
    await loadMessages(conversationId);
  }

  void _removeMessage(String conversationId, String messageId) {
    final current = List<ChatMessage>.of(state.messagesFor(conversationId));
    final filtered = current.where((m) => m.id != messageId).toList();
    if (filtered.length == current.length) {
      return;
    }
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = filtered;
    state = state.copyWith(messagesByConversation: map);
    _seenMessageIds.remove(messageId);
  }

  void deleteConversation(String conversationId) {
    _ref
        .read(conversationsProvider.notifier)
        .removeConversation(conversationId);
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map.remove(conversationId);
    state = state.copyWith(messagesByConversation: map);
  }

  void onComposerChanged(String conversationId, String value) {
    if (!(conversation(conversationId)?.canSend ?? true)) {
      return;
    }
    if (!_ref.read(settingsProvider).typingIndicatorsEnabled) {
      return;
    }
    if (_socketService.status != MessagingSocketStatus.connected) {
      return;
    }
    _typingDebounce?.cancel();
    if (value.trim().isEmpty) {
      _stopTyping(conversationId);
      return;
    }
    _typingDebounce = Timer(const Duration(milliseconds: 300), () {
      unawaited(_socketService.emitTypingStart(conversationId));
      _typingStopTimer?.cancel();
      _typingStopTimer = Timer(const Duration(seconds: 3), () {
        _stopTyping(conversationId);
      });
    });
  }

  void clearAll() {
    _deliveredMarked.clear();
    _seenMessageIds.clear();
    _seenClientIds.clear();
    state = const MessagingState(messagesByConversation: {});
    _ref.read(conversationsProvider.notifier).clear();
  }

  @override
  void dispose() {
    _messagesWatchSub?.close();
    _messageCreatedSub?.cancel();
    _messageDeliveredSub?.cancel();
    _messageReadSub?.cancel();
    _conversationUpdatedSub?.cancel();
    _conversationSettingsUpdatedSub?.cancel();
    _messageDeletedSub?.cancel();
    _typingStartedSub?.cancel();
    _typingStoppedSub?.cancel();
    _typingDebounce?.cancel();
    _typingStopTimer?.cancel();
    _typingIndicatorTimeout?.cancel();
    _sessionManager.removeAccessTokenListener(_onAccessTokenChanged);
    super.dispose();
  }

  void _onAccessTokenChanged(String? token) {
    if (token == null || token.isEmpty) {
      clearAll();
      unawaited(_socketCoordinator.disconnect());
    }
  }

  void _subscribeSocketEvents() {
    _subscribeTypingEvents();

    _messageCreatedSub = _socketService.messageCreatedStream.listen((event) {
      final message = mapMessageDto(
        MessageDto.fromJson(event.rawMessage),
        currentUserId: _currentUserId,
      );
      _handleIncomingMessage(message);
    });

    _messageDeliveredSub = _socketService.messageDeliveredStream.listen((
      event,
    ) {
      _applyReceiptStatus(
        event.conversationId,
        event.messageId,
        MessageDeliveryStatus.delivered,
      );
    });

    _messageReadSub = _socketService.messageReadStream.listen((event) {
      _applyReceiptStatus(
        event.conversationId,
        event.messageId,
        MessageDeliveryStatus.read,
      );
    });

    _conversationUpdatedSub = _socketService.conversationUpdatedStream.listen((
      event,
    ) {
      _ref
          .read(conversationsProvider.notifier)
          .applyConversationUpdated(
            event.rawConversation,
            currentUserId: _currentUserId,
          );
    });

    _conversationSettingsUpdatedSub = _socketService
        .conversationSettingsUpdatedStream
        .listen((event) {
          _applyConversationSettingsUpdated(event);
        });

    _messageDeletedSub = _socketService.messageDeletedStream.listen((event) {
      _removeMessage(event.conversationId, event.messageId);
    });
  }

  void _subscribeTypingEvents() {
    _typingStartedSub = _socketService.typingStartedStream.listen((event) {
      if (!_ref.read(settingsProvider).typingIndicatorsEnabled) {
        return;
      }
      if (state.openConversationId == event.conversationId &&
          event.userId != _currentUserId) {
        state = state.copyWith(isPeerTyping: true);
        _typingIndicatorTimeout?.cancel();
        _typingIndicatorTimeout = Timer(const Duration(seconds: 5), () {
          state = state.copyWith(isPeerTyping: false);
        });
      }
    });

    _typingStoppedSub = _socketService.typingStoppedStream.listen((event) {
      if (state.openConversationId == event.conversationId) {
        state = state.copyWith(isPeerTyping: false);
      }
    });
  }

  Future<void> _handleIncomingMessage(ChatMessage message) async {
    if (_seenMessageIds.contains(message.id)) {
      return;
    }
    if (message.clientMessageId != null &&
        _seenClientIds.contains(message.clientMessageId)) {
      return;
    }

    _seenMessageIds.add(message.id);
    if (message.clientMessageId != null) {
      _seenClientIds.add(message.clientMessageId!);
    }

    if (message.isOutgoing) {
      _reconcileOptimistic(
        message.conversationId,
        message.clientMessageId ?? message.id,
        message,
      );
      return;
    }

    _appendMessage(message.conversationId, message);
    await _ensureConversationInList(message.conversationId);
    _updateConversationPreview(
      message.conversationId,
      preview: message.body,
      outgoing: false,
      incrementUnread: state.openConversationId != message.conversationId,
    );

    if (!_deliveredMarked.contains(message.id)) {
      _deliveredMarked.add(message.id);
      if (_socketService.status == MessagingSocketStatus.connected) {
        unawaited(_socketService.markDelivered(message.id));
      } else {
        unawaited(_repository.markDelivered(message.id));
      }
    }

    if (state.openConversationId == message.conversationId) {
      unawaited(_markReadThrough(message.conversationId, message.id));
    }
  }

  Future<void> _markReadThrough(
    String conversationId,
    String throughMessageId,
  ) async {
    if (_socketService.status == MessagingSocketStatus.connected) {
      await _socketService.markConversationRead(
        conversationId: conversationId,
        throughMessageId: throughMessageId,
      );
    } else {
      await _repository.markConversationRead(
        conversationId: conversationId,
        throughMessageId: throughMessageId,
      );
    }
    final conv = conversation(conversationId);
    if (conv != null) {
      _ref
          .read(conversationsProvider.notifier)
          .upsertConversation(conv.copyWith(unreadCount: 0));
    }
  }

  void _reconcileOptimistic(
    String conversationId,
    String clientMessageId,
    ChatMessage serverMessage,
  ) {
    final current = List<ChatMessage>.of(state.messagesFor(conversationId));
    final index = current.indexWhere(
      (m) =>
          m.clientMessageId == clientMessageId ||
          m.id == 'local-$clientMessageId',
    );
    if (index >= 0) {
      current[index] = serverMessage;
    } else {
      current.add(serverMessage);
    }
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = _dedupeMessages(current);
    state = state.copyWith(messagesByConversation: map);
    _seenMessageIds.add(serverMessage.id);
    if (serverMessage.clientMessageId != null) {
      _seenClientIds.add(serverMessage.clientMessageId!);
    }
  }

  void _applyReceiptStatus(
    String conversationId,
    String messageId,
    MessageDeliveryStatus status,
  ) {
    final current = List<ChatMessage>.of(state.messagesFor(conversationId));
    final index = current.indexWhere((m) => m.id == messageId);
    if (index < 0) {
      return;
    }
    final existing = current[index];
    if (existing.deliveryStatus == MessageDeliveryStatus.read) {
      return;
    }
    if (status == MessageDeliveryStatus.delivered &&
        existing.deliveryStatus == MessageDeliveryStatus.read) {
      return;
    }
    current[index] = existing.copyWith(deliveryStatus: status);
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = current;
    state = state.copyWith(messagesByConversation: map);
  }

  void _appendMessage(String conversationId, ChatMessage message) {
    final current = List<ChatMessage>.of(state.messagesFor(conversationId))
      ..add(message);
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = _dedupeMessages(current);
    state = state.copyWith(messagesByConversation: map);
  }

  void _replaceMessage(String conversationId, ChatMessage message) {
    final current = List<ChatMessage>.of(state.messagesFor(conversationId));
    final index = current.indexWhere((m) => m.id == message.id);
    if (index < 0) {
      return;
    }
    current[index] = message;
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = current;
    state = state.copyWith(messagesByConversation: map);
  }

  List<ChatMessage> _dedupeMessages(List<ChatMessage> messages) {
    final byKey = <String, ChatMessage>{};
    for (final message in messages) {
      final key = message.clientMessageId ?? message.id;
      byKey[key] = message;
    }
    final list = byKey.values.toList()
      ..sort((a, b) => a.sentAt.compareTo(b.sentAt));
    return list;
  }

  List<ChatMessage> _filterExpired(List<ChatMessage> messages) {
    final now = DateTime.now().toUtc();
    return messages.where((message) {
      final expiresAt = message.expiresAt;
      return expiresAt == null || expiresAt.isAfter(now);
    }).toList();
  }

  void _applyConversationSettingsUpdated(
    SocketConversationSettingsUpdatedEvent event,
  ) {
    final conv = conversation(event.conversationId);
    if (conv != null) {
      final hours = DisappearingDurationMapper.secondsToHours(
        event.disappearingSeconds,
      );
      _ref
          .read(conversationsProvider.notifier)
          .upsertConversation(
            conv.copyWith(
              disappearingDurationHours: hours,
              disappearingMessagesEnabled: hours != null,
              clearDisappearing: hours == null,
            ),
          );
    }

    final rawSystemMessage = event.rawSystemMessage;
    if (rawSystemMessage != null) {
      final message = mapMessageDto(
        MessageDto.fromJson(rawSystemMessage),
        currentUserId: _currentUserId,
      );
      unawaited(_handleIncomingMessage(message));
    }
  }

  void _stopTyping(String conversationId) {
    _typingStopTimer?.cancel();
    if (_socketService.status == MessagingSocketStatus.connected) {
      unawaited(_socketService.emitTypingStop(conversationId));
    }
  }

  void _updateConversationPreview(
    String conversationId, {
    required String preview,
    required bool outgoing,
    bool incrementUnread = false,
  }) {
    final conv = conversation(conversationId);
    if (conv == null) {
      unawaited(_ensureConversationInList(conversationId));
      return;
    }
    _ref
        .read(conversationsProvider.notifier)
        .upsertConversation(
          conv.copyWith(
            lastMessagePreview: preview,
            isOutgoingPreview: outgoing,
            unreadCount: incrementUnread
                ? conv.unreadCount + 1
                : conv.unreadCount,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  String? _peerPokidokiId(String peerId) {
    final contacts = _ref.read(socialGraphProvider).contacts;
    for (final contact in contacts) {
      if (contact.id == peerId) {
        return contact.pokidokiId;
      }
    }
    return null;
  }

  Future<void> _ensureConversationInList(String conversationId) async {
    if (conversation(conversationId) != null) {
      return;
    }
    try {
      final conv = await _repository.getConversation(conversationId);
      _ref.read(conversationsProvider.notifier).upsertConversation(conv);
    } on Object {
      // List sync will retry on next refresh.
    }
  }
}
