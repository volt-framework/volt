part of volt;

class RoleEditBuilder extends Builder<RawApiMap> {
  String name;
  String? color;
  bool? isHoist;
  int? rank;
  RoleRemoveField? remove;

  RoleEditBuilder({required this.name});

  @override
  RawApiMap build() {
    return {
      'name': name,
      if (color != null) 'colour': color,
      if (isHoist != null) 'hoist': isHoist,
      if (rank != null) 'rank': rank,
      if (remove != null) 'remove': remove!.value,
    };
  }
}

class RoleRemoveField extends Enum<String> {
  static const color = RoleRemoveField._create('Colour');

  const RoleRemoveField._create(String value) : super(value);
}
