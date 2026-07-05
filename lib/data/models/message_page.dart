import 'message.dart';

class MessagePage {
  const MessagePage({
    required this.items,
    this.nextCursor,
    this.hasMore = false,
  });

  final List<ChatMessage> items;
  final String? nextCursor;
  final bool hasMore;
}
