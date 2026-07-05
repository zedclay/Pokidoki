import 'dart:io' show Platform;

import '../models/conversation.dart';
import '../models/conversation_page.dart';
import '../models/message.dart';
import '../models/message_page.dart';
import '../models/message_search_page.dart';
import '../models/shared_media_item.dart';
import '../repositories/conversations_repository.dart';
import 'mock_sample_data.dart';

class MockConversationsRepository implements ConversationsRepository {
  const MockConversationsRepository();

  Future<void> _maybeDelay() async {
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      await Future<void>.delayed(const Duration(milliseconds: 40));
    }
  }

  @override
  Future<Conversation> createOrGetConversation(String userId) async {
    await _maybeDelay();
    final existing = MockSampleData.conversations.where(
      (c) => c.peerId == userId,
    );
    if (existing.isNotEmpty) {
      return existing.first;
    }
    return MockSampleData.conversations.first;
  }

  @override
  Future<ConversationPage> getConversations({
    String? cursor,
    int limit = 20,
  }) async {
    await _maybeDelay();
    return ConversationPage(items: MockSampleData.conversations);
  }

  @override
  Future<Conversation> getConversation(String conversationId) async {
    await _maybeDelay();
    return MockSampleData.conversations.firstWhere(
      (c) => c.id == conversationId,
      orElse: () => MockSampleData.conversations.first,
    );
  }

  @override
  Future<MessagePage> getMessages({
    required String conversationId,
    String? before,
    int limit = 50,
  }) async {
    await _maybeDelay();
    return MessagePage(
      items: MockSampleData.messages[conversationId] ?? const [],
    );
  }

  @override
  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  }) async {
    await _maybeDelay();
    return ChatMessage(
      id: 'mock-$clientMessageId',
      conversationId: conversationId,
      clientMessageId: clientMessageId,
      senderId: MockSampleData.currentUser.id,
      body: text,
      sentAt: DateTime.now().toUtc(),
      isOutgoing: true,
      deliveryStatus: MessageDeliveryStatus.sent,
    );
  }

  @override
  Future<void> markDelivered(String messageId) async {}

  @override
  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  }) async {}

  @override
  Future<Conversation> updateMute({
    required String conversationId,
    DateTime? mutedUntil,
  }) async {
    final conversation = await getConversation(conversationId);
    return conversation.copyWith(isMuted: mutedUntil != null);
  }

  @override
  Future<Conversation> updateDisappearingMessages({
    required String conversationId,
    required int durationSeconds,
  }) async {
    final conversation = await getConversation(conversationId);
    return conversation.copyWith(
      disappearingDurationHours: durationSeconds == 0
          ? null
          : durationSeconds ~/ 3600,
      clearDisappearing: durationSeconds == 0,
      disappearingMessagesEnabled: durationSeconds != 0,
    );
  }

  @override
  Future<MessageSearchPage> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  }) async {
    final messages = MockSampleData.messages[conversationId] ?? const [];
    final q = query.trim().toLowerCase();
    final results = messages
        .where((m) => m.body.toLowerCase().contains(q))
        .toList();
    return MessageSearchPage(items: results);
  }

  @override
  Future<List<SharedMediaItem>> getSharedMedia(String conversationId) async {
    await _maybeDelay();
    return MockSampleData.sharedMedia[conversationId] ?? const [];
  }
}
