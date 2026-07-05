import '../models/conversation.dart';
import '../models/conversation_page.dart';
import '../models/message.dart';
import '../models/message_page.dart';
import '../models/message_search_page.dart';
import '../models/shared_media_item.dart';

abstract interface class ConversationsRepository {
  Future<Conversation> createOrGetConversation(String userId);

  Future<ConversationPage> getConversations({String? cursor, int limit = 20});

  Future<Conversation> getConversation(String conversationId);

  Future<MessagePage> getMessages({
    required String conversationId,
    String? before,
    int limit = 50,
  });

  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String clientMessageId,
    required String text,
  });

  Future<void> markDelivered(String messageId);

  Future<void> markConversationRead({
    required String conversationId,
    required String throughMessageId,
  });

  Future<Conversation> updateMute({
    required String conversationId,
    DateTime? mutedUntil,
  });

  Future<Conversation> updateDisappearingMessages({
    required String conversationId,
    required int durationSeconds,
  });

  Future<MessageSearchPage> searchMessages({
    required String conversationId,
    required String query,
    String? cursor,
    int limit = 20,
  });

  Future<List<SharedMediaItem>> getSharedMedia(String conversationId);
}
