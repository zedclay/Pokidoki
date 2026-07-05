import 'conversation.dart';

class ConversationPage {
  const ConversationPage({
    required this.items,
    this.nextCursor,
    this.hasMore = false,
  });

  final List<Conversation> items;
  final String? nextCursor;
  final bool hasMore;
}
