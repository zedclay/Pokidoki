import '../../features/users/domain/user_search_page.dart';
import '../../features/users/domain/username_availability.dart';
import '../models/account_settings.dart';
import '../models/user_profile.dart';
import '../models/user_profile_preview.dart';

abstract interface class UserRepository {
  Future<UserProfile?> getCurrentUser();

  Future<AccountSettings> getAccountSettings();

  Future<UsernameAvailability> checkUsernameAvailability(String username);

  Future<UserProfile> createProfile({
    required String username,
    required String displayName,
    String? bio,
  });

  Future<UserProfile> getCurrentProfile();

  Future<UserProfile> updateProfile({
    String? displayName,
    String? bio,
    bool? isDiscoverable,
  });

  Future<UserProfile> changeUsername(String username);

  Future<UserSearchPage> searchUsers({
    required String query,
    int page = 1,
    int limit = 20,
  });

  Future<UserProfilePreview> getUserProfile(String userId);
}
