part of volt;

class UserProfile {
  final String? content;
  final Attachment? background;

  UserProfile._new(RawApiMap raw)
      : content = raw['content'] as String?,
        background = raw['content'] == null
            ? null
            : Attachment._new(raw['content'] as RawApiMap);
}
