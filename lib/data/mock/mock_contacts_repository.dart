import '../models/blocked_user.dart';
import '../models/contact.dart';
import '../models/contact_request.dart';
import '../repositories/contacts_repository.dart';
import 'mock_sample_data.dart';

class MockContactsRepository implements ContactsRepository {
  const MockContactsRepository();

  @override
  Future<List<Contact>> getContacts() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.contacts;
  }

  @override
  Future<List<ContactRequest>> getContactRequests() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.contactRequests;
  }

  @override
  Future<List<BlockedUser>> getBlockedUsers() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.blockedUsers;
  }
}
