part of volt;

class MemberEditBuilder extends Builder<RawApiMap> {
  /// Member server nickname.
  String? nickname;

  /// Member server avatar (Autumn file ID).
  String? avatar;

  /// List of member roles.
  List<Ulid>? roles;

  /// Field to remove from member.
  MemberRemoveField? remove;

  MemberEditBuilder();

  /// Construct [MemberEditBuilder] from [Member].
  factory MemberEditBuilder.from(Member member) => MemberEditBuilder()
    ..nickname = member.nickname
    ..avatar = member.avatar?.id
    ..roles = member.roles.map((e) => e.id).toList();

  void addRole(Role role) => (roles ??= []).add(role.id);
  void addRoles(List<Role> roles) =>
      (this.roles ??= []).addAll(roles.map((e) => e.id));

  @override
  RawApiMap build() {
    return {
      if (nickname != null) 'nickname': nickname,
      if (avatar != null) 'avatar': avatar,
      if (roles != null) 'roles': roles!.map((e) => e.toString()).toList(),
      if (remove != null) 'remove': remove!.value,
    };
  }
}

class MemberRemoveField extends Enum<String> {
  static const avatar = MemberRemoveField._create('Avatar');
  static const nickname = MemberRemoveField._create('Nickname');

  const MemberRemoveField._create(String value) : super(value);
}
