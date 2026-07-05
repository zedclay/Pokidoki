import 'package:dio/dio.dart';

import 'messaging_api_models.dart';

class MessagingApi {
  MessagingApi(this._dio);

  final Dio _dio;

  Future<ConversationDto> createOrGetConversation({
    required String userId,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/conversations',
      data: {'userId': userId},
    );
    return ConversationDto.fromJson(
      response.data!['conversation'] as Map<String, dynamic>,
    );
  }

  Future<PaginatedConversationsDto> getConversations({
    String? cursor,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/conversations',
      queryParameters: {'cursor': ?cursor, 'limit': limit},
    );
    return PaginatedConversationsDto.fromJson(response.data!);
  }

  Future<ConversationDto> getConversation(String conversationId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/conversations/$conversationId',
    );
    return ConversationDto.fromJson(
      response.data!['conversation'] as Map<String, dynamic>,
    );
  }

  Future<PaginatedMessagesDto> getMessages({
    required String conversationId,
    String? before,
    int limit = 50,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/conversations/$conversationId/messages',
      queryParameters: {'before': ?before, 'limit': limit},
    );
    return PaginatedMessagesDto.fromJson(response.data!);
  }

  Future<MessageDto> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/conversations/$conversationId/messages',
      data: {'clientMessageId': clientMessageId, 'text': text},
    );
    return MessageDto.fromJson(
      response.data!['message'] as Map<String, dynamic>,
    );
  }

  Future<void> markDelivered(String messageId) async {
    await _dio.post<void>('/messages/$messageId/delivered');
  }

  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  }) async {
    await _dio.post<void>(
      '/conversations/$conversationId/read',
      data: {'throughMessageId': throughMessageId},
    );
  }

  Future<MuteResponseDto> updateMute({
    required String conversationId,
    DateTime? mutedUntil,
  }) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/conversations/$conversationId/mute',
      data: {'mutedUntil': mutedUntil?.toUtc().toIso8601String()},
    );
    return MuteResponseDto.fromJson(response.data!);
  }

  Future<DisappearingResponseDto> updateDisappearingMessages({
    required String conversationId,
    required int durationSeconds,
  }) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/conversations/$conversationId/disappearing-messages',
      data: {'durationSeconds': durationSeconds},
    );
    return DisappearingResponseDto.fromJson(response.data!);
  }

  Future<PaginatedMessagesDto> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/conversations/$conversationId/messages/search',
      queryParameters: {'query': query, 'cursor': ?cursor, 'limit': limit},
    );
    return PaginatedMessagesDto.fromJson(response.data!);
  }
}
