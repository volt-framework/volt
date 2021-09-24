part of volt;

/// Server role.
class Role {
  /// Role name.
  String name;

  /// Role permissions.
  RolePermissions permissions;

  /// Valid HTML color.
  String? color;

  /// Whether to display this role separately on the members list.
  bool? isHoist;

  /// Role ranking. A role with a smaller number will have permissions over roles with larger numbers.
  int? rank;

  Role._new(RawApiMap raw)
      : name = raw['name'] as String,
        permissions = RolePermissions._new(raw['permissions'] as List<dynamic>),
        color = raw['colour'] as String?,
        isHoist = raw['hoist'] as bool?,
        rank = raw['rank'] as int?;
}