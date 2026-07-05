import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/app_providers.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/models/blocked_user.dart';
import '../../../../data/models/contact.dart';
import '../../../../data/models/contact_request.dart';
import '../../../../data/models/conversation.dart';
import '../../../../data/models/user_profile_preview.dart';
import '../../../../data/models/user_search_result.dart';
import '../../../../data/models/contact_page.dart';
import '../../../../data/repositories/contacts_repository.dart';
import '../../../contacts/data/contacts_failure.dart';

class SocialGraphState {
  const SocialGraphState({
    required this.conversations,
    required this.contacts,
    required this.requests,
    required this.profiles,
    required this.blockedUsers,
    this.isLoading = false,
    this.isLoadingBlocked = false,
    this.blockedError = false,
    this.errorKey,
    this.searchResults = const [],
    this.isSearching = false,
    this.searchQuery = '',
  });

  final List<Conversation> conversations;
  final List<Contact> contacts;
  final List<ContactRequest> requests;
  final Map<String, UserProfilePreview> profiles;
  final List<BlockedUser> blockedUsers;
  final bool isLoading;
  final bool isLoadingBlocked;
  final bool blockedError;
  final String? errorKey;
  final List<UserSearchResult> searchResults;
  final bool isSearching;
  final String searchQuery;

  List<ContactRequest> get receivedRequests => requests
      .where((r) => r.direction == ContactRequestDirection.incoming)
      .toList();

  List<ContactRequest> get sentRequests => requests
      .where((r) => r.direction == ContactRequestDirection.outgoing)
      .toList();

  List<Contact> get verifiedContacts =>
      contacts.where((c) => c.isVerified).toList();

  List<Conversation> get pinnedConversations =>
      conversations.where((c) => c.isPinned).toList();

  List<Conversation> get recentConversations =>
      conversations.where((c) => !c.isPinned).toList();

  SocialGraphState copyWith({
    List<Conversation>? conversations,
    List<Contact>? contacts,
    List<ContactRequest>? requests,
    Map<String, UserProfilePreview>? profiles,
    List<BlockedUser>? blockedUsers,
    bool? isLoading,
    bool? isLoadingBlocked,
    bool? blockedError,
    String? errorKey,
    bool clearError = false,
    List<UserSearchResult>? searchResults,
    bool? isSearching,
    String? searchQuery,
  }) {
    return SocialGraphState(
      conversations: conversations ?? this.conversations,
      contacts: contacts ?? this.contacts,
      requests: requests ?? this.requests,
      profiles: profiles ?? this.profiles,
      blockedUsers: blockedUsers ?? this.blockedUsers,
      isLoading: isLoading ?? this.isLoading,
      isLoadingBlocked: isLoadingBlocked ?? this.isLoadingBlocked,
      blockedError: blockedError ?? this.blockedError,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class SocialGraphController extends StateNotifier<SocialGraphState> {
  SocialGraphController(this._repository)
    : super(
        SocialGraphState(
          conversations: List.of(MockSampleData.conversations),
          contacts: List.of(MockSampleData.contacts),
          requests: List.of(MockSampleData.contactRequests),
          profiles: Map.of(MockSampleData.profiles),
          blockedUsers: List.of(MockSampleData.blockedUsers),
        ),
      );

  final ContactsRepository _repository;

  ContactsRepository get repository => _repository;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final results = await Future.wait([
        _repository.getContacts(),
        _repository.getIncomingRequests(),
        _repository.getOutgoingRequests(),
        _repository.getBlockedUsers(),
      ]);
      final contactsPage = results[0] as ContactPage;
      final incomingPage = results[1] as ContactRequestPage;
      final outgoingPage = results[2] as ContactRequestPage;
      final blockedPage = results[3] as BlockedUserPage;
      state = state.copyWith(
        contacts: contactsPage.items,
        requests: [...incomingPage.items, ...outgoingPage.items],
        blockedUsers: blockedPage.items,
        isLoading: false,
      );
      _syncConversationBlockedState();
    } on ContactsFailure catch (error) {
      state = state.copyWith(isLoading: false, errorKey: error.messageKey);
    } on Object {
      state = state.copyWith(isLoading: false, errorKey: 'stateError');
    }
  }

  void updateConversation(
    String conversationId,
    Conversation Function(Conversation conversation) transform,
  ) {
    final conversations = state.conversations.map((item) {
      if (item.id != conversationId) {
        return item;
      }
      return transform(item);
    }).toList();
    state = state.copyWith(conversations: conversations);
  }

  void removeConversation(String conversationId) {
    state = state.copyWith(
      conversations: state.conversations
          .where((item) => item.id != conversationId)
          .toList(),
    );
  }

  List<Conversation> filterConversations(String query) {
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

  List<Contact> filterContacts(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return state.contacts;
    }
    return state.contacts
        .where(
          (c) =>
              c.displayName.toLowerCase().contains(q) ||
              c.username.toLowerCase().contains(q) ||
              c.pokidokiId.toLowerCase().contains(q),
        )
        .toList();
  }

  Future<void> searchUsers(String query) async {
    final q = query.trim();
    state = state.copyWith(
      searchQuery: query,
      isSearching: true,
      clearError: true,
    );
    if (q.isEmpty) {
      state = state.copyWith(searchResults: const [], isSearching: false);
      return;
    }
    try {
      final results = await _repository.searchUsers(q);
      state = state.copyWith(searchResults: results, isSearching: false);
    } on ContactsFailure catch (error) {
      state = state.copyWith(
        searchResults: const [],
        isSearching: false,
        errorKey: error.messageKey,
      );
    } on Object {
      state = state.copyWith(
        searchResults: const [],
        isSearching: false,
        errorKey: 'stateError',
      );
    }
  }

  UserProfilePreview? profileFor(String userId) {
    return state.profiles[userId];
  }

  Future<UserProfilePreview?> loadProfilePreview(String userId) async {
    try {
      final profile = await _repository.getProfilePreview(userId);
      final profiles = Map<String, UserProfilePreview>.of(state.profiles);
      profiles[userId] = profile;
      state = state.copyWith(profiles: profiles, clearError: true);
      return profile;
    } on ContactsFailure catch (error) {
      state = state.copyWith(errorKey: error.messageKey);
      return null;
    } on Object {
      state = state.copyWith(errorKey: 'stateError');
      return null;
    }
  }

  Future<void> acceptRequest(String requestId) async {
    try {
      await _repository.acceptRequest(requestId);
      await refresh();
    } on ContactsFailure catch (error) {
      state = state.copyWith(errorKey: error.messageKey);
    }
  }

  Future<void> declineRequest(String requestId) async {
    try {
      await _repository.declineRequest(requestId);
      state = state.copyWith(
        requests: state.requests.where((r) => r.id != requestId).toList(),
      );
    } on ContactsFailure catch (error) {
      state = state.copyWith(errorKey: error.messageKey);
    }
  }

  Future<void> cancelSentRequest(String requestId) async {
    try {
      await _repository.cancelRequest(requestId);
      state = state.copyWith(
        requests: state.requests.where((r) => r.id != requestId).toList(),
      );
      final profiles = Map<String, UserProfilePreview>.of(state.profiles);
      for (final entry in profiles.entries.toList()) {
        if (entry.value.relationship == ProfileRelationship.pendingOutgoing) {
          profiles[entry.key] = entry.value.copyWith(
            relationship: ProfileRelationship.none,
          );
        }
      }
      state = state.copyWith(profiles: profiles);
    } on ContactsFailure catch (error) {
      state = state.copyWith(errorKey: error.messageKey);
    }
  }

  Future<bool> sendContactRequest(String userId) async {
    try {
      final request = await _repository.sendContactRequest(userId);
      state = state.copyWith(
        requests: [...state.requests, request],
        clearError: true,
      );
      final profiles = Map<String, UserProfilePreview>.of(state.profiles);
      final existing = profiles[userId];
      if (existing != null) {
        profiles[userId] = existing.copyWith(
          relationship: ProfileRelationship.pendingOutgoing,
        );
        state = state.copyWith(profiles: profiles);
      }
      return true;
    } on ContactsFailure catch (error) {
      state = state.copyWith(errorKey: error.messageKey);
      return false;
    } on Object {
      state = state.copyWith(errorKey: 'stateError');
      return false;
    }
  }

  bool isContactVerified(String userId) {
    for (final contact in state.contacts) {
      if (contact.id == userId || contact.username == userId) {
        return contact.isVerified;
      }
    }
    final profile = state.profiles[userId];
    return profile?.isVerified ?? false;
  }

  bool _matchesUser(
    String userId, {
    required String id,
    required String username,
  }) {
    return id == userId ||
        username == userId ||
        (userId == MockSampleData.amiraUserId && username == 'amira');
  }

  Future<void> markVerified(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final contacts = state.contacts.map((contact) {
      if (_matchesUser(userId, id: contact.id, username: contact.username)) {
        return contact.copyWith(isVerified: true);
      }
      return contact;
    }).toList();

    final conversations = state.conversations.map((conversation) {
      if (_matchesUser(
        userId,
        id: conversation.peerId,
        username: conversation.peerUsername,
      )) {
        return conversation.copyWith(isPeerVerified: true);
      }
      return conversation;
    }).toList();

    final profiles = Map<String, UserProfilePreview>.of(state.profiles);
    final existing = profiles[userId] ?? profileFor(userId);
    if (existing != null) {
      profiles[userId] = existing.copyWith(
        relationship: existing.relationship == ProfileRelationship.none
            ? ProfileRelationship.contact
            : existing.relationship,
        isVerified: true,
      );
    }

    state = state.copyWith(
      contacts: contacts,
      conversations: conversations,
      profiles: profiles,
    );
  }

  Future<void> resetVerification(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final contacts = state.contacts.map((contact) {
      if (contact.id == userId ||
          (userId == MockSampleData.amiraUserId &&
              contact.username == 'amira')) {
        return contact.copyWith(isVerified: false);
      }
      return contact;
    }).toList();

    final conversations = state.conversations.map((conversation) {
      if (conversation.peerId == userId ||
          (userId == MockSampleData.amiraUserId &&
              conversation.peerUsername == 'amira')) {
        return conversation.copyWith(isPeerVerified: false);
      }
      return conversation;
    }).toList();

    final profiles = Map<String, UserProfilePreview>.of(state.profiles);
    final existing = profiles[userId];
    if (existing != null) {
      profiles[userId] = UserProfilePreview(
        id: existing.id,
        displayName: existing.displayName,
        username: existing.username,
        pokidokiId: existing.pokidokiId,
        relationship: existing.relationship,
        bio: existing.bio,
        isVerified: false,
        sharedContext: existing.sharedContext,
      );
    }

    state = state.copyWith(
      contacts: contacts,
      conversations: conversations,
      profiles: profiles,
    );
  }

  Future<void> loadBlockedUsers() async {
    state = state.copyWith(isLoadingBlocked: true, blockedError: false);
    try {
      final page = await _repository.getBlockedUsers();
      state = state.copyWith(blockedUsers: page.items, isLoadingBlocked: false);
    } on Object {
      state = state.copyWith(isLoadingBlocked: false, blockedError: true);
    }
  }

  bool isUserBlocked(String userId) {
    return state.blockedUsers.any((user) => user.id == userId);
  }

  Future<void> blockUser({
    required String userId,
    required String displayName,
    required String username,
    String? pokidokiId,
  }) async {
    if (isUserBlocked(userId)) {
      _setConversationBlockedForPeer(userId, true);
      return;
    }

    final blocked = BlockedUser(
      id: userId,
      displayName: displayName,
      username: username,
      pokidokiId: pokidokiId ?? 'PKD-UNKNOWN',
      blockedAt: DateTime.now().toUtc(),
    );
    state = state.copyWith(
      blockedUsers: [blocked, ...state.blockedUsers],
      contacts: state.contacts.where((contact) => contact.id != userId).toList(),
      requests: state.requests.where((request) => request.userId != userId).toList(),
      clearError: true,
    );
    _setConversationBlockedForPeer(userId, true);

    try {
      await _repository.blockUser(userId);
    } on ContactsFailure catch (error) {
      state = state.copyWith(
        blockedUsers: state.blockedUsers
            .where((user) => user.id != userId)
            .toList(),
        errorKey: error.messageKey,
      );
      _setConversationBlockedForPeer(userId, false);
    }
  }

  Future<void> unblockUser(String userId) async {
    final previousBlocked = state.blockedUsers;
    state = state.copyWith(
      blockedUsers: state.blockedUsers
          .where((user) => user.id != userId)
          .toList(),
      clearError: true,
    );
    _setConversationBlockedForPeer(userId, false);

    try {
      await _repository.unblockUser(userId);
    } on ContactsFailure catch (error) {
      state = state.copyWith(
        blockedUsers: previousBlocked,
        errorKey: error.messageKey,
      );
      _setConversationBlockedForPeer(userId, true);
    }
  }

  Future<void> removeContact(String userId) async {
    try {
      await _repository.removeContact(userId);
      state = state.copyWith(
        contacts: state.contacts.where((c) => c.id != userId).toList(),
      );
    } on ContactsFailure catch (error) {
      state = state.copyWith(errorKey: error.messageKey);
    }
  }

  void _setConversationBlockedForPeer(String peerId, bool blocked) {
    final conversations = state.conversations.map((conversation) {
      if (conversation.peerId != peerId) {
        return conversation;
      }
      return conversation.copyWith(isBlocked: blocked);
    }).toList();
    state = state.copyWith(conversations: conversations);
  }

  void _syncConversationBlockedState() {
    final blockedIds = state.blockedUsers.map((user) => user.id).toSet();
    final conversations = state.conversations.map((conversation) {
      return conversation.copyWith(
        isBlocked: blockedIds.contains(conversation.peerId),
      );
    }).toList();
    state = state.copyWith(conversations: conversations);
  }
}

final socialGraphProvider =
    StateNotifierProvider<SocialGraphController, SocialGraphState>((ref) {
      return SocialGraphController(ref.watch(contactsRepositoryProvider));
    });
