import 'blocked_user.dart';
import 'contact.dart';
import 'contact_request.dart';

class ContactPage {
  const ContactPage({
    required this.items,
    required this.page,
    required this.limit,
    required this.hasMore,
  });

  final List<Contact> items;
  final int page;
  final int limit;
  final bool hasMore;
}

class ContactRequestPage {
  const ContactRequestPage({
    required this.items,
    required this.page,
    required this.limit,
    required this.hasMore,
  });

  final List<ContactRequest> items;
  final int page;
  final int limit;
  final bool hasMore;
}

class BlockedUserPage {
  const BlockedUserPage({
    required this.items,
    required this.page,
    required this.limit,
    required this.hasMore,
  });

  final List<BlockedUser> items;
  final int page;
  final int limit;
  final bool hasMore;
}
