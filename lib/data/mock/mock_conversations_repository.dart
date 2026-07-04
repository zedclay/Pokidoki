import '../models/conversation.dart';
import '../models/message.dart';
import '../models/shared_media_item.dart';
import '../repositories/conversations_repository.dart';
import 'mock_sample_data.dart';

class MockConversationsRepository implements ConversationsRepository {
  const MockConversationsRepository();

  @override
  Future<List<Conversation>> getConversations() async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.conversations;
  }

  @override
  Future<List<ChatMessage>> getMessages(String conversationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.messages[conversationId] ?? const [];
  }

  @override
  Future<List<SharedMediaItem>> getSharedMedia(String conversationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    return MockSampleData.sharedMedia[conversationId] ?? const [];
  }
}
