import '../models/account_settings.dart';
import '../models/user_profile.dart';

abstract interface class UserRepository {
  Future<UserProfile?> getCurrentUser();
  Future<AccountSettings> getAccountSettings();
}
