import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/conversation.dart';
import '../../../../data/repositories/conversations_repository.dart';
import '../../data/api/messaging_api_mapper.dart';
import '../../data/api/messaging_api_models.dart';
import '../../data/messaging_failure.dart';

class ConversationsState {
  const ConversationsState({
    this.conversations = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorKey,
    this.nextCursor,
    this.hasMore = false,
  });

  final List<Conversation> conversations;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorKey;
  final String? nextCursor;
  final bool hasMore;

  ConversationsState copyWith({
    List<Conversation>? conversations,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorKey,
    bool clearError = false,
    String? nextCursor,
    bool? hasMore,
  }) {
    return ConversationsState(
      conversations: conversations ?? this.conversations,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class ConversationsController extends StateNotifier<ConversationsState> {
  ConversationsController(this._repository) : super(const ConversationsState());

  final ConversationsRepository _repository;

  Future<void> loadInitial({String? currentUserId}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final page = await _repository.getConversations();
      state = state.copyWith(
        conversations: page.items,
        isLoading: false,
        nextCursor: page.nextCursor,
        hasMore: page.hasMore,
      );
    } on MessagingFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorKey: failure.messageKey ?? 'messagingUnavailable',
      );
    } on Object {
      state = state.copyWith(
        isLoading: false,
        errorKey: 'messagingUnavailable',
      );
    }
  }

  Future<void> refresh() => loadInitial();

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.nextCursor == null) {
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final page = await _repository.getConversations(cursor: state.nextCursor);
      final merged = _mergeConversations(state.conversations, page.items);
      state = state.copyWith(
        conversations: merged,
        isLoadingMore: false,
        nextCursor: page.nextCursor,
        hasMore: page.hasMore,
      );
    } on Object {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<Conversation?> createOrGet(String userId) async {
    try {
      final conversation = await _repository.createOrGetConversation(userId);
      upsertConversation(conversation);
      return conversation;
    } on MessagingFailure catch (failure) {
      state = state.copyWith(errorKey: failure.messageKey);
      rethrow;
    }
  }

  Conversation? conversationById(String id) {
    for (final item in state.conversations) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  void upsertConversation(Conversation conversation) {
    final items = List<Conversation>.of(state.conversations);
    final index = items.indexWhere((c) => c.id == conversation.id);
    if (index >= 0) {
      items[index] = conversation;
    } else {
      items.insert(0, conversation);
    }
    items.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    state = state.copyWith(conversations: items);
  }

  void applyConversationUpdated(
    Map<String, dynamic> raw, {
    required String? currentUserId,
  }) {
    final dto = ConversationDto.fromJson(raw);
    upsertConversation(mapConversationDto(dto, currentUserId: currentUserId));
  }

  void removeConversation(String conversationId) {
    state = state.copyWith(
      conversations: state.conversations
          .where((c) => c.id != conversationId)
          .toList(),
    );
  }

  void clear() {
    state = const ConversationsState();
  }

  List<Conversation> filter(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return state.conversations;
    }
    return state.conversations
        .where(
          (c) =>
              c.peerDisplayName.toLowerCase().contains(q) ||
              c.peerUsername.toLowerCase().contains(q) ||
              (c.lastMessagePreview?.toLowerCase().contains(q) ?? false),
        )
        .toList();
  }

  List<Conversation> _mergeConversations(
    List<Conversation> existing,
    List<Conversation> incoming,
  ) {
    final byId = {for (final c in existing) c.id: c};
    for (final c in incoming) {
      byId[c.id] = c;
    }
    final merged = byId.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return merged;
  }
}
