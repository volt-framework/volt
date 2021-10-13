part of volt;

class RoleBuilder extends Builder<RawApiMap> {
  String name;

  RoleBuilder({required this.name});

  @override
  RawApiMap build() {
    return {
      'name': name,
    };
  }
}
