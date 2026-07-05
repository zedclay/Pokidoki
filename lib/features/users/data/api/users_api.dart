import 'package:dio/dio.dart';

import 'users_api_models.dart';

class UsersApi {
  UsersApi(this._dio);

  final Dio _dio;

  Future<UsernameAvailabilityDto> checkUsernameAvailability({
    required String username,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/users/username-availability',
      queryParameters: {'username': username},
    );
    return UsernameAvailabilityDto.fromJson(response.data!);
  }

  Future<ProfileResponseDto> createProfile({
    required String username,
    required String displayName,
    String? bio,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/users/me/profile',
      data: {
        'username': username,
        'displayName': displayName,
        if (bio != null && bio.isNotEmpty) 'bio': bio,
      },
    );
    return ProfileResponseDto.fromJson(response.data!);
  }

  Future<ProfileResponseDto> getCurrentProfile() async {
    final response = await _dio.get<Map<String, dynamic>>('/users/me/profile');
    return ProfileResponseDto.fromJson(response.data!);
  }

  Future<ProfileResponseDto> updateProfile({
    String? displayName,
    String? bio,
    bool? isDiscoverable,
  }) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/users/me/profile',
      data: {
        if (displayName != null) 'displayName': displayName,
        if (bio != null) 'bio': bio,
        if (isDiscoverable != null) 'isDiscoverable': isDiscoverable,
      },
    );
    return ProfileResponseDto.fromJson(response.data!);
  }

  Future<ProfileResponseDto> changeUsername({required String username}) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/users/me/username',
      data: {'username': username},
    );
    return ProfileResponseDto.fromJson(response.data!);
  }

  Future<SearchUsersResponseDto> searchUsers({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/users/search',
      queryParameters: {'query': query, 'page': page, 'limit': limit},
    );
    return SearchUsersResponseDto.fromJson(response.data!);
  }

  Future<ProfilePreviewResponseDto> getUserProfile({
    required String userId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>('/users/$userId');
    return ProfilePreviewResponseDto.fromJson(response.data!);
  }
}
