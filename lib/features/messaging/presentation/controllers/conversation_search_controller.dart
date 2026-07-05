import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/message.dart';
import '../../../../data/repositories/conversations_repository.dart';
import '../../data/messaging_failure.dart';
import '../../data/messaging_providers.dart';

class ConversationSearchState {
  const ConversationSearchState({
    this.results = const [],
    this.isLoading = false,
    this.errorKey,
    this.nextCursor,
    this.hasMore = false,
    this.query = '',
  });

  final List<ChatMessage> results;
  final bool isLoading;
  final String? errorKey;
  final String? nextCursor;
  final bool hasMore;
  final String query;

  ConversationSearchState copyWith({
    List<ChatMessage>? results,
    bool? isLoading,
    String? errorKey,
    bool clearError = false,
    String? nextCursor,
    bool? hasMore,
    String? query,
  }) {
    return ConversationSearchState(
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
    );
  }
}

class ConversationSearchController
    extends StateNotifier<ConversationSearchState> {
  ConversationSearchController(this._repository)
    : super(const ConversationSearchState());

  final ConversationsRepository _repository;

  static const int _minQueryLength = 2;

  Future<void> search({
    required String conversationId,
    required String query,
    bool loadMore = false,
  }) async {
    final trimmed = query.trim();
    if (trimmed.length < _minQueryLength) {
      state = ConversationSearchState(query: trimmed);
      return;
    }

    if (!loadMore) {
      state = state.copyWith(
        query: trimmed,
        isLoading: true,
        clearError: true,
        results: const [],
        nextCursor: null,
        hasMore: false,
      );
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    try {
      final page = await _repository.searchMessages(
        conversationId: conversationId,
        query: trimmed,
        cursor: loadMore ? state.nextCursor : null,
      );
      final merged = loadMore ? [...state.results, ...page.items] : page.items;
      state = state.copyWith(
        results: merged,
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

  void clear() {
    state = const ConversationSearchState();
  }
}

final conversationSearchProvider = StateNotifierProvider.autoDispose
    .family<ConversationSearchController, ConversationSearchState, String>((
      ref,
      conversationId,
    ) {
      return ConversationSearchController(
        ref.watch(conversationsRepositoryProvider),
      );
    });
