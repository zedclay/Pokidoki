import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';
import '../../../../data/models/account_settings.dart';
import '../../../../data/models/user_profile.dart';
import '../../../../data/models/user_profile_preview.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../domain/user_failure.dart';
import '../../domain/user_search_page.dart';
import '../../domain/username_availability.dart';
import 'user_api_mapper.dart';
import 'users_api.dart';

class ApiUserRepository implements UserRepository {
  ApiUserRepository({
    required UsersApi usersApi,
    required ApiErrorMapper errorMapper,
  }) : _usersApi = usersApi,
       _errorMapper = errorMapper;

  final UsersApi _usersApi;
  final ApiErrorMapper _errorMapper;

  UserProfile? _cachedProfile;

  @override
  Future<UserProfile?> getCurrentUser() async {
    try {
      final response = await _usersApi.getCurrentProfile();
      _cachedProfile = mapProfileDto(response.profile);
      return _cachedProfile;
    } on DioException catch (error) {
      if (_isProfileNotCreated(error)) {
        _cachedProfile = null;
        return null;
      }
      throw _mapException(error);
    }
  }

  @override
  Future<AccountSettings> getAccountSettings() async {
    return const AccountSettings(
      appLockEnabled: true,
      biometricsEnabled: false,
      disappearingMessagesDefaultHours: null,
      readReceiptsEnabled: true,
      themeModeName: 'dark',
      localeCode: 'en',
    );
  }

  @override
  Future<UsernameAvailability> checkUsernameAvailability(
    String username,
  ) async {
    try {
      final response = await _usersApi.checkUsernameAvailability(
        username: username,
      );
      return mapUsernameAvailabilityDto(response);
    } on DioException catch (error) {
      if (_isUsernameInvalid(error)) {
        return UsernameAvailability(username: username, available: false);
      }
      throw _mapException(error);
    }
  }

  @override
  Future<UserProfile> createProfile({
    required String username,
    required String displayName,
    String? bio,
  }) async {
    try {
      final response = await _usersApi.createProfile(
        username: username,
        displayName: displayName,
        bio: bio,
      );
      _cachedProfile = mapProfileDto(response.profile);
      return _cachedProfile!;
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<UserProfile> getCurrentProfile() async {
    try {
      final response = await _usersApi.getCurrentProfile();
      _cachedProfile = mapProfileDto(response.profile);
      return _cachedProfile!;
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<UserProfile> updateProfile({
    String? displayName,
    String? bio,
    bool? isDiscoverable,
  }) async {
    try {
      final response = await _usersApi.updateProfile(
        displayName: displayName,
        bio: bio,
        isDiscoverable: isDiscoverable,
      );
      _cachedProfile = mapProfileDto(response.profile);
      return _cachedProfile!;
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<UserProfile> changeUsername(String username) async {
    try {
      final response = await _usersApi.changeUsername(username: username);
      _cachedProfile = mapProfileDto(response.profile);
      return _cachedProfile!;
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<UserSearchPage> searchUsers({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _usersApi.searchUsers(
        query: query,
        page: page,
        limit: limit,
      );
      return mapSearchPageDto(response);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<UserProfilePreview> getUserProfile(String userId) async {
    try {
      final response = await _usersApi.getUserProfile(userId: userId);
      return mapProfilePreviewDto(response.profile);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  bool _isProfileNotCreated(DioException error) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      return data['code'] == 'PROFILE_NOT_CREATED';
    }
    return error.response?.statusCode == 404;
  }

  bool _isUsernameInvalid(DioException error) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      return data['code'] == 'USERNAME_INVALID';
    }
    return false;
  }

  UserFailure _mapException(DioException error) {
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      final network = _errorMapper.mapDioException(error);
      return UserFailure(messageKey: network.messageKey);
    }

    if (error.response != null) {
      final apiError = _errorMapper.mapResponse(error);
      return UserFailure(
        messageKey: _errorMapper.messageKeyForBackendCode(apiError.code),
        backendCode: apiError.code,
      );
    }

    return const UserFailure(messageKey: 'userUnexpectedError');
  }
}
