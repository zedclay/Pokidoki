import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/repositories/user_repository.dart';
import '../../../../features/users/data/user_providers.dart';
import '../../../../features/users/domain/user_failure.dart';
import '../../../../data/mock/mock_sample_data.dart';
import '../../../../data/models/blocked_user.dart';
import '../../../../data/models/contact.dart';
import '../../../../data/models/contact_request.dart';
import '../../../../data/models/conversation.dart';
import '../../../../data/models/user_profile_preview.dart';
import '../../../../data/models/user_search_result.dart';

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
  SocialGraphController(this._userRepository)
    : super(
        SocialGraphState(
          conversations: List.of(MockSampleData.conversations),
          contacts: List.of(MockSampleData.contacts),
          requests: List.of(MockSampleData.contactRequests),
          profiles: Map.of(MockSampleData.profiles),
          blockedUsers: List.of(MockSampleData.blockedUsers),
        ),
      );

  final UserRepository _userRepository;
  int _searchRequestId = 0;

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, clearError: true);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    state = state.copyWith(isLoading: false);
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
    final requestId = ++_searchRequestId;
    final q = query.trim();
    state = state.copyWith(
      searchQuery: query,
      isSearching: true,
      clearError: true,
    );
    if (q.length < 2) {
      state = state.copyWith(searchResults: const [], isSearching: false);
      return;
    }
    try {
      final page = await _userRepository.searchUsers(query: q);
      if (requestId != _searchRequestId) {
        return;
      }
      state = state.copyWith(searchResults: page.items, isSearching: false);
    } on UserFailure catch (failure) {
      if (requestId != _searchRequestId) {
        return;
      }
      state = state.copyWith(
        isSearching: false,
        errorKey: failure.messageKey,
        searchResults: const [],
      );
    }
  }

  Future<UserProfilePreview?> loadProfilePreview(String userId) async {
    final existing = state.profiles[userId];
    if (existing != null) {
      return existing;
    }
    try {
      final preview = await _userRepository.getUserProfile(userId);
      final enriched = _enrichRelationship(preview);
      state = state.copyWith(profiles: {...state.profiles, userId: enriched});
      return enriched;
    } on Object {
      return profileFor(userId);
    }
  }

  UserProfilePreview _enrichRelationship(UserProfilePreview preview) {
    final isContact = state.contacts.any((c) => c.username == preview.username);
    final pending = state.sentRequests.any((r) => r.userId == preview.id);
    return preview.copyWith(
      relationship: isContact
          ? ProfileRelationship.contact
          : pending
          ? ProfileRelationship.pendingOutgoing
          : ProfileRelationship.none,
    );
  }

  UserProfilePreview? profileFor(String userId) {
    final existing = state.profiles[userId];
    if (existing != null) {
      return existing;
    }
    UserSearchResult? directory;
    for (final user in MockSampleData.directoryUsers) {
      if (user.id == userId) {
        directory = user;
        break;
      }
    }
    final matched = directory;
    if (matched == null) {
      return null;
    }
    final isContact = state.contacts.any((c) => c.username == matched.username);
    final pending = state.sentRequests.any((r) => r.userId == userId);
    return UserProfilePreview(
      id: matched.id,
      displayName: matched.displayName,
      username: matched.username,
      pokidokiId: matched.pokidokiId,
      bio: matched.bio,
      isVerified: matched.isVerified,
      relationship: isContact
          ? ProfileRelationship.contact
          : pending
          ? ProfileRelationship.pendingOutgoing
          : ProfileRelationship.none,
      sharedContext: 'Found through username search',
    );
  }

  Future<void> acceptRequest(String requestId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    ContactRequest? request;
    for (final item in state.requests) {
      if (item.id == requestId) {
        request = item;
        break;
      }
    }
    if (request == null) {
      return;
    }
    final contacts = [
      ...state.contacts,
      Contact(
        id: request.userId,
        displayName: request.displayName,
        username: request.username,
        pokidokiId: request.pokidokiId,
        status: ContactStatus.connected,
      ),
    ]..sort((a, b) => a.displayName.compareTo(b.displayName));
    final requests = state.requests.where((r) => r.id != requestId).toList();
    state = state.copyWith(contacts: contacts, requests: requests);
  }

  Future<void> declineRequest(String requestId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    state = state.copyWith(
      requests: state.requests.where((r) => r.id != requestId).toList(),
    );
  }

  Future<void> cancelSentRequest(String requestId) async {
    await declineRequest(requestId);
  }

  Future<bool> sendContactRequest(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final profile = profileFor(userId);
    if (profile == null) {
      return false;
    }
    if (profile.relationship != ProfileRelationship.none) {
      return false;
    }
    final request = ContactRequest(
      id: 'req-$userId',
      userId: userId,
      displayName: profile.displayName,
      username: profile.username,
      pokidokiId: profile.pokidokiId,
      direction: ContactRequestDirection.outgoing,
      createdAt: DateTime.now().toUtc(),
      bio: profile.bio,
    );
    final profiles = Map<String, UserProfilePreview>.of(state.profiles);
    profiles[userId] = profile.copyWith(
      relationship: ProfileRelationship.pendingOutgoing,
    );
    state = state.copyWith(
      requests: [...state.requests, request],
      profiles: profiles,
    );
    return true;
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
    await Future<void>.delayed(const Duration(milliseconds: 200));
    state = state.copyWith(isLoadingBlocked: false);
  }

  bool isUserBlocked(String userId) {
    return state.blockedUsers.any((user) => user.id == userId);
  }

  void blockUser({
    required String userId,
    required String displayName,
    required String username,
    String? pokidokiId,
  }) {
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
    state = state.copyWith(blockedUsers: [blocked, ...state.blockedUsers]);
    _setConversationBlockedForPeer(userId, true);
  }

  void unblockUser(String userId) {
    state = state.copyWith(
      blockedUsers: state.blockedUsers
          .where((user) => user.id != userId)
          .toList(),
    );
    _setConversationBlockedForPeer(userId, false);
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
}

final socialGraphProvider =
    StateNotifierProvider<SocialGraphController, SocialGraphState>((ref) {
      return SocialGraphController(ref.watch(userRepositoryProvider));
    });
