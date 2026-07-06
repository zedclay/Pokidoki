import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';
import '../../../../core/network/auth_session_manager.dart';
import '../../../../data/models/conversation.dart';
import '../../../../data/models/conversation_page.dart';
import '../../../../data/models/message.dart';
import '../../../../data/models/message_page.dart';
import '../../../../data/models/message_search_page.dart';
import '../../../../data/models/shared_media_item.dart';
import '../../../../data/repositories/conversations_repository.dart';
import '../../domain/queue_retry_scheduler.dart';
import '../messaging_failure.dart';
import 'messaging_api.dart';
import 'messaging_api_mapper.dart';

class ApiConversationsRepository implements ConversationsRepository {
  ApiConversationsRepository({
    required MessagingApi messagingApi,
    required ApiErrorMapper errorMapper,
    required AuthSessionManager sessionManager,
  }) : _messagingApi = messagingApi,
       _errorMapper = errorMapper,
       _sessionManager = sessionManager;

  final MessagingApi _messagingApi;
  final ApiErrorMapper _errorMapper;
  final AuthSessionManager _sessionManager;

  String? get _currentUserId => _sessionManager.currentUser?.id;

  @override
  Future<Conversation> createOrGetConversation(String userId) async {
    try {
      final dto = await _messagingApi.createOrGetConversation(userId: userId);
      return mapConversationDto(dto, currentUserId: _currentUserId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<ConversationPage> getConversations({
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final dto = await _messagingApi.getConversations(
        cursor: cursor,
        limit: limit,
      );
      return mapConversationPage(dto, currentUserId: _currentUserId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<Conversation> getConversation(String conversationId) async {
    try {
      final dto = await _messagingApi.getConversation(conversationId);
      return mapConversationDto(dto, currentUserId: _currentUserId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<MessagePage> getMessages({
    required String conversationId,
    String? before,
    int limit = 50,
  }) async {
    try {
      final dto = await _messagingApi.getMessages(
        conversationId: conversationId,
        before: before,
        limit: limit,
      );
      return mapMessagePage(dto, currentUserId: _currentUserId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) async {
    try {
      final dto = await _messagingApi.sendMessage(
        conversationId: conversationId,
        clientMessageId: clientMessageId,
        text: text,
      );
      return mapMessageDto(dto, currentUserId: _currentUserId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> markDelivered(String messageId) async {
    try {
      await _messagingApi.markDelivered(messageId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  }) async {
    try {
      await _messagingApi.markConversationRead(
        conversationId: conversationId,
        throughMessageId: throughMessageId,
      );
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<Conversation> updateMute({
    required String conversationId,
    DateTime? mutedUntil,
  }) async {
    try {
      final conversation = await getConversation(conversationId);
      final dto = await _messagingApi.updateMute(
        conversationId: conversationId,
        mutedUntil: mutedUntil,
      );
      return applyMuteToConversation(conversation, dto);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<Conversation> updateDisappearingMessages({
    required String conversationId,
    required int durationSeconds,
  }) async {
    try {
      final conversation = await getConversation(conversationId);
      final dto = await _messagingApi.updateDisappearingMessages(
        conversationId: conversationId,
        durationSeconds: durationSeconds,
      );
      return applyDisappearingToConversation(conversation, dto);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<MessageSearchPage> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) async {
    try {
      final dto = await _messagingApi.searchMessages(
        conversationId: conversationId,
        query: query,
        cursor: cursor,
        limit: limit,
      );
      return mapMessageSearchPage(dto, currentUserId: _currentUserId);
    } on DioException catch (error) {
      throw _mapException(error);
    }
  }

  @override
  Future<List<SharedMediaItem>> getSharedMedia(String conversationId) async {
    return const [];
  }

  MessagingFailure _mapException(DioException error) {
    if (error.response?.data is Map<String, dynamic>) {
      final apiException = _errorMapper.mapResponse(error);
      return MessagingFailure(
        code: apiException.code,
        messageKey: _errorMapper.messageKeyForBackendCode(apiException.code),
      );
    }
    final status = error.response?.statusCode;
    if (status != null) {
      final scheduler = QueueRetryScheduler();
      return MessagingFailure(code: scheduler.codeForHttpStatus(status));
    }
    return const MessagingFailure(code: 'CONNECTION_ERROR');
  }
}
