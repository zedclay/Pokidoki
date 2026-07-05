import 'package:dio/dio.dart';

import 'contacts_api_models.dart';

class ContactsApi {
  ContactsApi(this._dio);

  final Dio _dio;

  Future<ContactRequestDto> sendContactRequest({required String userId}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/contacts/requests',
      data: {'userId': userId},
    );
    final request = response.data!['request'] as Map<String, dynamic>;
    return ContactRequestDto.fromJson(request);
  }

  Future<PaginatedContactRequestsDto> getContactRequests({
    required String direction,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/contacts/requests',
      queryParameters: {'direction': direction, 'page': page, 'limit': limit},
    );
    return PaginatedContactRequestsDto.fromJson(response.data!);
  }

  Future<void> acceptRequest(String requestId) async {
    await _dio.post<void>('/contacts/requests/$requestId/accept');
  }

  Future<void> declineRequest(String requestId) async {
    await _dio.post<void>('/contacts/requests/$requestId/decline');
  }

  Future<void> cancelRequest(String requestId) async {
    await _dio.delete<void>('/contacts/requests/$requestId');
  }

  Future<PaginatedContactsDto> getContacts({
    int page = 1,
    int limit = 50,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/contacts',
      queryParameters: {'page': page, 'limit': limit},
    );
    return PaginatedContactsDto.fromJson(response.data!);
  }

  Future<void> removeContact(String userId) async {
    await _dio.delete<void>('/contacts/$userId');
  }

  Future<void> blockUser(String userId) async {
    await _dio.post<void>('/blocked-users/$userId');
  }

  Future<void> unblockUser(String userId) async {
    await _dio.delete<void>('/blocked-users/$userId');
  }

  Future<PaginatedBlockedUsersDto> getBlockedUsers({
    int page = 1,
    int limit = 50,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/blocked-users',
      queryParameters: {'page': page, 'limit': limit},
    );
    return PaginatedBlockedUsersDto.fromJson(response.data!);
  }

  Future<RelationshipDto> getRelationship(String userId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/users/$userId/relationship',
    );
    return RelationshipDto.fromJson(response.data!);
  }

  Future<PublicProfileDto> getPublicProfile(String userId) async {
    final response = await _dio.get<Map<String, dynamic>>('/users/$userId');
    return PublicProfileDto.fromJson(response.data!);
  }

  Future<UserSearchPageDto> searchUsers({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/users/search',
      queryParameters: {'query': query, 'page': page, 'limit': limit},
    );
    return UserSearchPageDto.fromJson(response.data!);
  }
}
