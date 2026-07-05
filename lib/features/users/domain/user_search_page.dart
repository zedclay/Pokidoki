import '../../../data/models/user_search_result.dart';

class UserSearchPage {
  const UserSearchPage({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
    required this.hasMore,
  });

  final List<UserSearchResult> items;
  final int page;
  final int limit;
  final int total;
  final bool hasMore;
}
