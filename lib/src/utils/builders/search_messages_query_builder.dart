part of volt;

// TODO: test it plsss
class SearchMessagesQueryBuilder extends Builder<RawApiMap> {
  final StringBuffer _query = StringBuffer();
  set query(String query) {
    _query.clear();
    _query.write(query);
  }

  MessageSearchSortDirection? _sortDirection;
  set sortDirection(MessageSearchSortDirection? direction) =>
      _sortDirection = direction;

  bool? _includeUsers;
  set includeUsers(bool? value) => _includeUsers = value;

  Ulid? _before;
  set before(Ulid? value) => _before == null ? value : null;

  Ulid? _after;
  set after(Ulid? value) => _after == null ? value : null;

  int? _limit;
  set limit(int? value) =>
      _limit = value == null ? max(min(value!, 100), 1) : null;

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
      if (_before != null) 'before': _before.toString(),
      if (_after != null) 'after': _after.toString(),
      if (_sortDirection != null) 'sort': _sortDirection!.value,
      if (_includeUsers != null) 'include_users': _includeUsers,
    };
  }
}

class MessageSearchSortDirection extends Enum<String> {
  static const latest = MessageSearchSortDirection._create('Latest');
  static const oldest = MessageSearchSortDirection._create('Oldest');
  static const relevance = MessageSearchSortDirection._create('Oldest');

  const MessageSearchSortDirection._create(String val) : super(val);
}
