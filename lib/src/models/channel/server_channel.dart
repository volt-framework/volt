part of volt;

class ServerChannel extends Channel implements Mentionable {
  // TODO: replace with cacheable server
  final UlidEntity server;

  final String name;
  final String? description;

  // TODO: replace with attachment object
  final RawApiMap? icon;

  // TODO: replace with permissions object
  final int? defaultPermissions;

  // TODO: replace with map {role:permissions}
  RawApiMap? rolePermissions;

  final bool? isNsfw;

  // TODO: replace with cacheable message??
  final UlidEntity? lastMessage;

  ServerChannel._new(IVolt client, RawApiMap raw)
      : server = UlidEntity(Ulid(raw['server'] as String)),
        name = raw['name'] as String,
        description = raw['description'] as String?,
        icon = raw['icon'] as RawApiMap?,
        defaultPermissions = raw['default_permissions'] as int?,
        rolePermissions = raw['role_permissions'] as RawApiMap?,
        isNsfw = raw['nsfw'] as bool?,
        lastMessage = raw['last_message_id'] == null
            ? null
            : UlidEntity(Ulid(raw['last_message_id'])),
        super._new(client, raw);

  @override
  String get mention => '<#${id.toString()}>';
}
