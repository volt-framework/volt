part of volt;

/// Server channel builder.
class ServerChannelBuilder extends Builder<RawApiMap> {
  /// Channel type.
  ServerChannelType? type;

  /// Channel name.
  String? name;

  /// Channel description.
  String? description;

  /// Whether this channel is Not Safe For Work.
  bool? isNsfw;

  /// Nonce value, used to prevent double requests to create objects.
  String? nonce;

  ServerChannelBuilder();

  /// Server channel constructor with minimal required fields.
  factory ServerChannelBuilder.create({
    required ServerChannelType type,
    required String name,
  }) =>
      ServerChannelBuilder()
        ..type = type
        ..name = name;

  @override
  RawApiMap build() {
    if (type == null) {
      throw ArgumentError.notNull('type');
    }
    if (name == null) {
      throw ArgumentError.notNull('name');
    }

    return {
      'type': type!.value,
      'name': name!,
      if (description != null) 'description': description,
      if (isNsfw != null) 'nsfw': isNsfw,
      'nonce': nonce ?? Ulid.fromNow().toString(),
    };
  }
}

/// Server channel type.
class ServerChannelType extends Enum<String> {
  /// Text channel.
  static const text = ServerChannelType._create('Text');

  /// Voice channel.
  static const voice = ServerChannelType._create('Voice');

  const ServerChannelType._create(String value) : super(value);
}
