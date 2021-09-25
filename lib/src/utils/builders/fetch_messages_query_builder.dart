part of volt;

// TODO: test it plsss
class FetchMessagesQueryBuilder extends Builder<RawApiMap> {
  Ulid? _nearby;

  MessageSortDirection _sortDirection = MessageSortDirection.latest;
  set sortDirection(MessageSortDirection direction) =>
      _sortDirection = direction;

  bool? includeUsers;
  Ulid? before;
  Ulid? after;

  int? _limit;
  set limit(int? value) =>
      _limit = value == null ? null : max(min(value, 100), 1);
  int? get limit => _limit;

  FetchMessagesQueryBuilder();

  factory FetchMessagesQueryBuilder.nearby(
    Ulid nearby, {
    MessageSortDirection sortDirection = MessageSortDirection.latest,
    bool? includeUsers,
    int? limit,
  }) {
    // on nearby before after and sort will be ignored
    return FetchMessagesQueryBuilder()
      .._nearby = nearby
      ..includeUsers = includeUsers
      ..sortDirection = sortDirection
      ..limit = limit;
  }

  @override
  RawApiMap build() {
    return {
      if (_limit != null && _nearby == null) 'limit': _limit,
      if (before != null && _nearby == null) 'before': before.toString(),
      if (after != null && _nearby == null) 'after': after.toString(),
      'sort': _sortDirection.value,
      if (_nearby != null) 'nearby': _nearby.toString(),
      if (includeUsers != null) 'include_users': includeUsers,
    };
  }
}

class MessageSortDirection extends Enum<String> {
  static const latest = MessageSortDirection._create('Latest');
  static const oldest = MessageSortDirection._create('Oldest');

  const MessageSortDirection._create(String val) : super(val);
}
