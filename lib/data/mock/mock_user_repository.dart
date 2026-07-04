import '../models/account_settings.dart';
import '../models/user_profile.dart';
import '../repositories/user_repository.dart';
import 'mock_sample_data.dart';

class MockUserRepository implements UserRepository {
  const MockUserRepository();

  @override
  Future<UserProfile?> getCurrentUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.currentUser;
  }

  @override
  Future<AccountSettings> getAccountSettings() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.accountSettings;
  }
}
