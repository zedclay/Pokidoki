import '../../features/users/domain/user_search_page.dart';
import '../../features/users/domain/username_availability.dart';
import '../../features/users/domain/user_failure.dart';
import '../models/account_settings.dart';
import '../models/user_profile.dart';
import '../models/user_profile_preview.dart';
import '../repositories/user_repository.dart';
import 'mock_sample_data.dart';

class MockUserRepository implements UserRepository {
  const MockUserRepository();

  static const _reservedUsernames = {'admin', 'pokidoki', 'support'};

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

  @override
  Future<UsernameAvailability> checkUsernameAvailability(
    String username,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final normalized = username.toLowerCase();
    return UsernameAvailability(
      username: normalized,
      available: !_reservedUsernames.contains(normalized),
    );
  }

  @override
  Future<UserProfile> createProfile({
    required String username,
    required String displayName,
    String? bio,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return UserProfile(
      id: MockSampleData.currentUser.id,
      displayName: displayName,
      username: username,
      pokidokiId: MockSampleData.currentUser.pokidokiId,
      bio: bio,
      isVerified: true,
    );
  }

  @override
  Future<UserProfile> getCurrentProfile() async {
    final profile = await getCurrentUser();
    if (profile == null) {
      throw StateError('Mock profile missing');
    }
    return profile;
  }

  @override
  Future<UserProfile> updateProfile({
    String? displayName,
    String? bio,
    bool? isDiscoverable,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    const current = MockSampleData.currentUser;
    return current.copyWith(
      displayName: displayName,
      bio: bio,
      isDiscoverable: isDiscoverable,
    );
  }

  @override
  Future<UserProfile> changeUsername(String username) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return MockSampleData.currentUser.copyWith(username: username);
  }

  @override
  Future<UserSearchPage> searchUsers({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 280));
    final q = query.trim().toLowerCase();
    final results = MockSampleData.directoryUsers
        .where(
          (u) =>
              u.displayName.toLowerCase().contains(q) ||
              u.username.toLowerCase().contains(q) ||
              u.pokidokiId.toLowerCase().contains(q),
        )
        .toList();
    return UserSearchPage(
      items: results,
      page: page,
      limit: limit,
      total: results.length,
      hasMore: false,
    );
  }

  @override
  Future<UserProfilePreview> getUserProfile(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    for (final user in MockSampleData.directoryUsers) {
      if (user.id == userId) {
        return UserProfilePreview(
          id: user.id,
          displayName: user.displayName,
          username: user.username,
          pokidokiId: user.pokidokiId,
          bio: user.bio,
          isVerified: user.isVerified,
          relationship: ProfileRelationship.none,
        );
      }
    }
    throw const UserFailure(
      messageKey: 'userNotFound',
      backendCode: 'USER_NOT_FOUND',
    );
  }
}
