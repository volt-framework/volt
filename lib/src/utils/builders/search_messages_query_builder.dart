part of volt;

// TODO: test it plsss
class SearchMessagesQueryBuilder extends Builder<RawApiMap> {
  final StringBuffer _query = StringBuffer();
  set query(String query) {
    _query.clear();
    _query.write(query);
  }

  MessageSearchSortDirection? sortDirection;
  bool? includeUsers;
  Ulid? before;
  Ulid? after;

  int? _limit;
  set limit(int? value) =>
      _limit = value == null ? null : max(min(value, 100), 1);
  int? get limit => _limit;

  SearchMessagesQueryBuilder();

  factory SearchMessagesQueryBuilder.query(
    String query, {
    MessageSearchSortDirection? sortDirection,
    Ulid? before,
    Ulid? after,
    bool? includeUsers,
    int? limit,
  }) {
    // on nearby before after and sort will be ignored
    return SearchMessagesQueryBuilder()
      ..query = query
      ..includeUsers = includeUsers
      ..sortDirection = sortDirection
      ..before = before
      ..after = after
      ..limit = limit;
  }

  @override
  RawApiMap build() {
    return {
      'query': _query.toString(),
      if (_limit != null) 'limit': _limit,
      if (before != null) 'before': before.toString(),
      if (after != null) 'after': after.toString(),
      if (sortDirection != null) 'sort': sortDirection!.value,
      if (includeUsers != null) 'include_users': includeUsers,
    };
  }
}

class MessageSearchSortDirection extends Enum<String> {
  static const latest = MessageSearchSortDirection._create('Latest');
  static const oldest = MessageSearchSortDirection._create('Oldest');
  static const relevance = MessageSearchSortDirection._create('Oldest');

  const MessageSearchSortDirection._create(String val) : super(val);
}
