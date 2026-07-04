import '../models/blocked_user.dart';
import '../models/contact.dart';
import '../models/contact_request.dart';

abstract interface class ContactsRepository {
  Future<List<Contact>> getContacts();
  Future<List<ContactRequest>> getContactRequests();
  Future<List<BlockedUser>> getBlockedUsers();
}
