import '../models/conversation.dart';
import '../models/message.dart';
import '../models/shared_media_item.dart';

abstract interface class ConversationsRepository {
  Future<List<Conversation>> getConversations();
  Future<List<ChatMessage>> getMessages(String conversationId);
  Future<List<SharedMediaItem>> getSharedMedia(String conversationId);
}
