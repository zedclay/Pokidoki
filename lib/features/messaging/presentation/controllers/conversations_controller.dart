import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/conversation.dart';
import '../../../../data/repositories/conversations_repository.dart';
import '../../data/messaging_failure.dart';
import '../../data/messaging_stream_providers.dart';
import '../../data/api/messaging_api_mapper.dart';
import '../../data/api/messaging_api_models.dart';

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
  ConversationsController(this._repository, {required Ref ref})
    : _ref = ref,
      super(const ConversationsState()) {
    _bindLocalStream();
  }

  final ConversationsRepository _repository;
  final Ref _ref;

  void _bindLocalStream() {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }
    _ref.listen<AsyncValue<List<Conversation>>>(conversationsWatchProvider, (
      previous,
      next,
    ) {
      next.whenData((conversations) {
        state = state.copyWith(conversations: conversations);
      });
    }, fireImmediately: true);
  }

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
        errorKey: state.conversations.isEmpty
            ? failure.resolvedMessageKey
            : null,
      );
    } on Object {
      state = state.copyWith(
        isLoading: false,
        errorKey: state.conversations.isEmpty ? 'messagingUnavailable' : null,
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
      state = state.copyWith(errorKey: failure.resolvedMessageKey);
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

  Future<void> refreshConversation(String conversationId) async {
    try {
      final conversation = await _repository.getConversation(conversationId);
      upsertConversation(conversation);
    } on Object {
      // Conversation may have been deleted locally.
    }
  }

  Future<void> refreshConversationsForPeer(String peerId) async {
    final matches = state.conversations
        .where((conversation) => conversation.peerId == peerId)
        .toList();
    for (final conversation in matches) {
      await refreshConversation(conversation.id);
    }
  }

  void applyBlockedByMe(Set<String> blockedPeerIds) {
    if (blockedPeerIds.isEmpty) {
      return;
    }
    final updated = state.conversations.map((conversation) {
      if (!blockedPeerIds.contains(conversation.peerId)) {
        return conversation;
      }
      return conversation.copyWith(isBlocked: true, canSend: false);
    }).toList();
    state = state.copyWith(conversations: updated);
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
