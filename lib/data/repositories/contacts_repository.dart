import '../models/contact_page.dart';
import '../models/contact_request.dart';
import '../models/user_profile_preview.dart';
import '../models/user_relationship.dart';
import '../models/user_search_result.dart';

abstract interface class ContactsRepository {
  Future<ContactRequest> sendContactRequest(String userId);

  Future<ContactRequestPage> getIncomingRequests({
    int page = 1,
    int limit = 20,
  });

  Future<ContactRequestPage> getOutgoingRequests({
    int page = 1,
    int limit = 20,
  });

  Future<void> acceptRequest(String requestId);

  Future<void> declineRequest(String requestId);

  Future<void> cancelRequest(String requestId);

  Future<ContactPage> getContacts({int page = 1, int limit = 50});

  Future<void> removeContact(String userId);

  Future<void> blockUser(String userId);

  Future<void> unblockUser(String userId);

  Future<BlockedUserPage> getBlockedUsers({int page = 1, int limit = 50});

  Future<UserRelationship> getRelationship(String userId);

  Future<UserProfilePreview> getProfilePreview(String userId);

  Future<List<UserSearchResult>> searchUsers(String query);
}
