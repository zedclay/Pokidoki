import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/models/conversation.dart';
import '../../../../data/models/message.dart';
import '../../../../data/models/shared_media_item.dart';
import '../../../social/presentation/controllers/social_graph_controller.dart';

class MessagingState {
  const MessagingState({required this.messagesByConversation, this.replyTo});

  final Map<String, List<ChatMessage>> messagesByConversation;
  final ChatMessage? replyTo;

  List<ChatMessage> messagesFor(String conversationId) =>
      messagesByConversation[conversationId] ?? const [];

  MessagingState copyWith({
    Map<String, List<ChatMessage>>? messagesByConversation,
    ChatMessage? replyTo,
    bool clearReply = false,
  }) {
    return MessagingState(
      messagesByConversation:
          messagesByConversation ?? this.messagesByConversation,
      replyTo: clearReply ? null : (replyTo ?? this.replyTo),
    );
  }
}

class MessagingController extends StateNotifier<MessagingState> {
  MessagingController(this._ref)
    : super(
        MessagingState(
          messagesByConversation: {
            for (final entry in MockSampleData.messages.entries)
              entry.key: List<ChatMessage>.of(entry.value),
          },
        ),
      );

  final Ref _ref;
  int _idCounter = 100;

  Conversation? conversation(String conversationId) {
    final conversations = _ref.read(socialGraphProvider).conversations;
    for (final item in conversations) {
      if (item.id == conversationId) {
        return item;
      }
    }
    return null;
  }

  String conversationIdForPeer(String peerId) {
    final conversations = _ref.read(socialGraphProvider).conversations;
    for (final item in conversations) {
      if (item.peerId == peerId) {
        return item.id;
      }
    }
    return 'conv-$peerId';
  }

  void setReplyTo(ChatMessage? message) {
    state = state.copyWith(replyTo: message, clearReply: message == null);
  }

  Future<void> sendTextMessage(String conversationId, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }
    final reply = state.replyTo;
    final id = 'm-local-${_idCounter++}';
    final message = ChatMessage(
      id: id,
      conversationId: conversationId,
      senderId: 'user-self',
      body: trimmed,
      sentAt: DateTime.now().toUtc(),
      isOutgoing: true,
      deliveryStatus: MessageDeliveryStatus.sending,
      replyToMessageId: reply?.id,
      replyPreview: reply?.body,
    );

    final current = List<ChatMessage>.of(state.messagesFor(conversationId))
      ..add(message);
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = current;
    state = state.copyWith(messagesByConversation: map, clearReply: true);

    _updateConversationPreview(
      conversationId,
      preview: trimmed,
      outgoing: true,
    );

    // Deterministic delivery progression without long timers.
    final sent = message.copyWith(deliveryStatus: MessageDeliveryStatus.sent);
    _replaceMessage(conversationId, sent);
    final delivered = sent.copyWith(
      deliveryStatus: MessageDeliveryStatus.delivered,
    );
    _replaceMessage(conversationId, delivered);
    final read = delivered.copyWith(deliveryStatus: MessageDeliveryStatus.read);
    _replaceMessage(conversationId, read);
  }

  void _replaceMessage(String conversationId, ChatMessage message) {
    final current = List<ChatMessage>.of(state.messagesFor(conversationId));
    final index = current.indexWhere((item) => item.id == message.id);
    if (index < 0) {
      return;
    }
    current[index] = message;
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = current;
    state = state.copyWith(messagesByConversation: map);
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

  List<SharedMediaItem> sharedMedia(String conversationId) {
    return MockSampleData.sharedMedia[conversationId] ?? const [];
  }

  List<Map<String, String>> sharedLinks(String conversationId) {
    return MockSampleData.sharedLinks[conversationId] ?? const [];
  }

  void setMuted(String conversationId, bool muted) {
    _updateConversation(conversationId, (conversation) {
      return conversation.copyWith(isMuted: muted);
    });
  }

  void setBlocked(String conversationId, bool blocked) {
    final conversation = this.conversation(conversationId);
    if (conversation == null) {
      return;
    }
    final graph = _ref.read(socialGraphProvider.notifier);
    if (blocked) {
      graph.blockUser(
        userId: conversation.peerId,
        displayName: conversation.peerDisplayName,
        username: conversation.peerUsername,
        pokidokiId: _peerPokidokiId(conversation.peerId),
      );
    } else {
      graph.unblockUser(conversation.peerId);
    }
  }

  String? _peerPokidokiId(String peerId) {
    final contacts = _ref.read(socialGraphProvider).contacts;
    for (final contact in contacts) {
      if (contact.id == peerId) {
        return contact.pokidokiId;
      }
    }
    final profile = _ref.read(socialGraphProvider).profiles[peerId];
    return profile?.pokidokiId;
  }

  void setDisappearingHours(String conversationId, int? hours) {
    _updateConversation(conversationId, (conversation) {
      return conversation.copyWith(
        disappearingDurationHours: hours,
        disappearingMessagesEnabled: hours != null,
        clearDisappearing: hours == null,
      );
    });

    final body = hours == null
        ? 'You turned off disappearing messages.'
        : hours == 24
        ? 'You set disappearing messages to 1 day.'
        : hours == 1
        ? 'You set disappearing messages to 1 hour.'
        : hours == 168
        ? 'You set disappearing messages to 1 week.'
        : 'You set disappearing messages to $hours hours.';

    final system = ChatMessage(
      id: 'm-system-${_idCounter++}',
      conversationId: conversationId,
      senderId: 'system',
      body: body,
      sentAt: DateTime.now().toUtc(),
      isOutgoing: false,
      type: MessageContentType.system,
    );
    final current = List<ChatMessage>.of(state.messagesFor(conversationId))
      ..add(system);
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map[conversationId] = current;
    state = state.copyWith(messagesByConversation: map);
  }

  void deleteConversation(String conversationId) {
    _ref.read(socialGraphProvider.notifier).removeConversation(conversationId);
    final map = Map<String, List<ChatMessage>>.of(state.messagesByConversation);
    map.remove(conversationId);
    state = state.copyWith(messagesByConversation: map);
  }

  void _updateConversationPreview(
    String conversationId, {
    required String preview,
    required bool outgoing,
  }) {
    _ref.read(socialGraphProvider.notifier).updateConversation(conversationId, (
      conversation,
    ) {
      return conversation.copyWith(
        lastMessagePreview: preview,
        isOutgoingPreview: outgoing,
        unreadCount: 0,
        updatedAt: DateTime.now().toUtc(),
      );
    });
  }

  void _updateConversation(
    String conversationId,
    Conversation Function(Conversation conversation) transform,
  ) {
    _ref
        .read(socialGraphProvider.notifier)
        .updateConversation(conversationId, transform);
  }
}

final messagingProvider =
    StateNotifierProvider<MessagingController, MessagingState>((ref) {
      return MessagingController(ref);
    });
