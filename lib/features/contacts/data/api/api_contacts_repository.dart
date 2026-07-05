import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';
import '../../../../data/models/contact_page.dart';
import '../../../../data/models/contact_request.dart';
import '../../../../data/models/user_profile_preview.dart';
import '../../../../data/models/user_relationship.dart';
import '../../../../data/models/user_search_result.dart';
import '../../../../data/repositories/contacts_repository.dart';
import '../contacts_failure.dart';
import 'contacts_api.dart';
import 'contacts_api_mapper.dart';

class ApiContactsRepository implements ContactsRepository {
  ApiContactsRepository({
    required ContactsApi contactsApi,
    required ApiErrorMapper errorMapper,
  }) : _contactsApi = contactsApi,
       _errorMapper = errorMapper;

  final ContactsApi _contactsApi;
  final ApiErrorMapper _errorMapper;

  @override
  Future<ContactRequest> sendContactRequest(String userId) async {
    try {
      final dto = await _contactsApi.sendContactRequest(userId: userId);
      return mapContactRequestDto(dto);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<ContactRequestPage> getIncomingRequests({
    int page = 1,
    int limit = 20,
  }) {
    return _getRequests(direction: 'incoming', page: page, limit: limit);
  }

  @override
  Future<ContactRequestPage> getOutgoingRequests({
    int page = 1,
    int limit = 20,
  }) {
    return _getRequests(direction: 'outgoing', page: page, limit: limit);
  }

  Future<ContactRequestPage> _getRequests({
    required String direction,
    required int page,
    required int limit,
  }) async {
    try {
      final dto = await _contactsApi.getContactRequests(
        direction: direction,
        page: page,
        limit: limit,
      );
      return mapContactRequestPage(dto);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> acceptRequest(String requestId) async {
    try {
      await _contactsApi.acceptRequest(requestId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> declineRequest(String requestId) async {
    try {
      await _contactsApi.declineRequest(requestId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> cancelRequest(String requestId) async {
    try {
      await _contactsApi.cancelRequest(requestId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<ContactPage> getContacts({int page = 1, int limit = 50}) async {
    try {
      final dto = await _contactsApi.getContacts(page: page, limit: limit);
      return mapContactPage(dto);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> removeContact(String userId) async {
    try {
      await _contactsApi.removeContact(userId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> blockUser(String userId) async {
    try {
      await _contactsApi.blockUser(userId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> unblockUser(String userId) async {
    try {
      await _contactsApi.unblockUser(userId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<BlockedUserPage> getBlockedUsers({
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final dto = await _contactsApi.getBlockedUsers(page: page, limit: limit);
      return mapBlockedUserPage(dto);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<UserRelationship> getRelationship(String userId) async {
    try {
      final dto = await _contactsApi.getRelationship(userId);
      return mapRelationshipDto(dto);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<UserProfilePreview> getProfilePreview(String userId) async {
    try {
      final profile = await _contactsApi.getPublicProfile(userId);
      final relationship = await _contactsApi.getRelationship(userId);
      return mapPublicProfilePreview(
        profile: profile,
        relationship: mapRelationshipDto(relationship),
      );
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<List<UserSearchResult>> searchUsers(String query) async {
    try {
      final dto = await _contactsApi.searchUsers(query: query);
      return dto.items.map(mapSearchResultDto).toList();
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  ContactsFailure _mapException(DioException error) {
    if (error.response != null) {
      final apiError = _errorMapper.mapResponse(error);
      return ContactsFailure(
        messageKey: _errorMapper.messageKeyForBackendCode(apiError.code),
        backendCode: apiError.code,
      );
    }

    final network = _errorMapper.mapDioException(error);
    return ContactsFailure(messageKey: network.messageKey);
  }
}
