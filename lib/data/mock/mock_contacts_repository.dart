import '../models/blocked_user.dart';
import '../models/contact.dart';
import '../models/contact_page.dart';
import '../models/contact_request.dart';
import '../models/user_profile_preview.dart';
import '../models/user_relationship.dart';
import '../models/user_search_result.dart';
import '../repositories/contacts_repository.dart';
import 'mock_sample_data.dart';

class MockContactsRepository implements ContactsRepository {
  MockContactsRepository({
    List<Contact>? contacts,
    List<ContactRequest>? requests,
    List<BlockedUser>? blockedUsers,
  }) : _contacts = List.of(contacts ?? MockSampleData.contacts),
       _requests = List.of(requests ?? MockSampleData.contactRequests),
       _blockedUsers = List.of(blockedUsers ?? MockSampleData.blockedUsers);

  List<Contact> _contacts;
  List<ContactRequest> _requests;
  List<BlockedUser> _blockedUsers;

  @override
  Future<ContactRequest> sendContactRequest(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final profile =
        MockSampleData.profiles[userId] ??
        MockSampleData.directoryUsers
            .where((user) => user.id == userId)
            .map(
              (user) => UserProfilePreview(
                id: user.id,
                displayName: user.displayName,
                username: user.username,
                pokidokiId: user.pokidokiId,
                relationship: ProfileRelationship.none,
                bio: user.bio,
                isVerified: user.isVerified,
              ),
            )
            .cast<UserProfilePreview?>()
            .firstOrNull;
    if (profile == null) {
      throw StateError('Unknown user');
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
    _requests = [..._requests, request];
    return request;
  }

  @override
  Future<ContactRequestPage> getIncomingRequests({
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final items = _requests
        .where((r) => r.direction == ContactRequestDirection.incoming)
        .toList();
    return ContactRequestPage(
      items: items,
      page: page,
      limit: limit,
      hasMore: false,
    );
  }

  @override
  Future<ContactRequestPage> getOutgoingRequests({
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final items = _requests
        .where((r) => r.direction == ContactRequestDirection.outgoing)
        .toList();
    return ContactRequestPage(
      items: items,
      page: page,
      limit: limit,
      hasMore: false,
    );
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    ContactRequest? request;
    for (final item in _requests) {
      if (item.id == requestId) {
        request = item;
        break;
      }
    }
    if (request == null) {
      return;
    }
    _requests = _requests.where((r) => r.id != requestId).toList();
    _contacts = [
      ..._contacts,
      Contact(
        id: request.userId,
        displayName: request.displayName,
        username: request.username,
        pokidokiId: request.pokidokiId,
        status: ContactStatus.connected,
      ),
    ]..sort((a, b) => a.displayName.compareTo(b.displayName));
  }

  @override
  Future<void> declineRequest(String requestId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    _requests = _requests.where((r) => r.id != requestId).toList();
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    await declineRequest(requestId);
  }

  @override
  Future<ContactPage> getContacts({int page = 1, int limit = 50}) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return ContactPage(
      items: List.of(_contacts),
      page: page,
      limit: limit,
      hasMore: false,
    );
  }

  @override
  Future<void> removeContact(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    _contacts = _contacts.where((contact) => contact.id != userId).toList();
  }

  @override
  Future<void> blockUser(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final contact = _contacts.where((item) => item.id == userId).firstOrNull;
    _contacts = _contacts.where((item) => item.id != userId).toList();
    _requests = _requests.where((item) => item.userId != userId).toList();
    if (_blockedUsers.any((user) => user.id == userId)) {
      return;
    }
    _blockedUsers = [
      BlockedUser(
        id: userId,
        displayName: contact?.displayName ?? 'Blocked user',
        username: contact?.username ?? 'blocked',
        pokidokiId: contact?.pokidokiId ?? 'PKD-XXXX-XXXX',
        blockedAt: DateTime.now().toUtc(),
      ),
      ..._blockedUsers,
    ];
  }

  @override
  Future<void> unblockUser(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    _blockedUsers = _blockedUsers.where((user) => user.id != userId).toList();
  }

  @override
  Future<BlockedUserPage> getBlockedUsers({
    int page = 1,
    int limit = 50,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return BlockedUserPage(
      items: List.of(_blockedUsers),
      page: page,
      limit: limit,
      hasMore: false,
    );
  }

  @override
  Future<UserRelationship> getRelationship(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    if (_blockedUsers.any((user) => user.id == userId)) {
      return const UserRelationship(
        isContact: false,
        incomingRequestId: null,
        outgoingRequestId: null,
        blockedByMe: true,
        canSendRequest: false,
      );
    }
    if (_contacts.any((contact) => contact.id == userId)) {
      return const UserRelationship(
        isContact: true,
        incomingRequestId: null,
        outgoingRequestId: null,
        blockedByMe: false,
        canSendRequest: false,
      );
    }
    final incoming = _requests
        .where(
          (request) =>
              request.userId == userId &&
              request.direction == ContactRequestDirection.incoming,
        )
        .firstOrNull;
    final outgoing = _requests
        .where(
          (request) =>
              request.userId == userId &&
              request.direction == ContactRequestDirection.outgoing,
        )
        .firstOrNull;
    return UserRelationship(
      isContact: false,
      incomingRequestId: incoming?.id,
      outgoingRequestId: outgoing?.id,
      blockedByMe: false,
      canSendRequest: incoming == null && outgoing == null,
    );
  }

  @override
  Future<UserProfilePreview> getProfilePreview(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final relationship = await getRelationship(userId);
    final existing = MockSampleData.profiles[userId];
    if (existing != null) {
      return existing.copyWith(relationship: _mapRelationship(relationship));
    }
    final directory = MockSampleData.directoryUsers
        .where((user) => user.id == userId)
        .firstOrNull;
    if (directory == null) {
      throw StateError('Unknown user');
    }
    return UserProfilePreview(
      id: directory.id,
      displayName: directory.displayName,
      username: directory.username,
      pokidokiId: directory.pokidokiId,
      bio: directory.bio,
      isVerified: directory.isVerified,
      relationship: _mapRelationship(relationship),
      sharedContext: 'Found through username search',
    );
  }

  @override
  Future<List<UserSearchResult>> searchUsers(String query) async {
    await Future<void>.delayed(const Duration(milliseconds: 280));
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return const [];
    }
    return MockSampleData.directoryUsers
        .where(
          (user) =>
              user.displayName.toLowerCase().contains(q) ||
              user.username.toLowerCase().contains(q) ||
              user.pokidokiId.toLowerCase().contains(q),
        )
        .toList();
  }

  ProfileRelationship _mapRelationship(UserRelationship relationship) {
    if (relationship.blockedByMe) {
      return ProfileRelationship.blockedByMe;
    }
    if (relationship.isContact) {
      return ProfileRelationship.contact;
    }
    if (relationship.incomingRequestId != null) {
      return ProfileRelationship.pendingIncoming;
    }
    if (relationship.outgoingRequestId != null) {
      return ProfileRelationship.pendingOutgoing;
    }
    if (!relationship.canSendRequest) {
      return ProfileRelationship.unavailable;
    }
    return ProfileRelationship.none;
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    return iterator.current;
  }
}
