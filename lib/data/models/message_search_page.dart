import 'message.dart';

class MessageSearchPage {
  const MessageSearchPage({
    required this.items,
    this.nextCursor,
    this.hasMore = false,
  });

  final List<ChatMessage> items;
  final String? nextCursor;
  final bool hasMore;
}
