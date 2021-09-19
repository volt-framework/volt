part of volt;

class UserProfile {
  final String? content;
  final File? background;

  UserProfile._new(RawApiMap raw)
      : content = raw['content'] as String?,
        background = raw['content'] == null
            ? null
            : File._new(raw['content'] as RawApiMap);
}
