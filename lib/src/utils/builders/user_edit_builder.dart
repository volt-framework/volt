part of volt;

class UserEditBuilder extends Builder<RawApiMap> {
  UserStatusBuilder? status;
  UserProfileBuilder? profile;
  String? avatar;
  RemoveField? remove;

  @override
  RawApiMap build() {
    return {
      if (status != null) 'status': status!.build(),
      if (profile != null) 'profile': profile!.build(),
      if (avatar != null && avatar!.isNotEmpty) 'avatar': avatar!,
      if (remove != null) 'remove': remove!.value,
    };
  }
}

class UserProfileBuilder extends Builder<RawApiMap> {
  String? content;
  String? background;

  @override
  RawApiMap build() {
    return {
      if (content != null && content!.isNotEmpty) 'content': content,
      if (content != null && background!.isNotEmpty) 'presence': background,
    };
  }
}

class UserStatusBuilder extends Builder<RawApiMap> {
  String? text;
  UserPresence? presence;

  @override
  RawApiMap build() {
    return {
      if (text != null && text!.isNotEmpty) 'text': text,
      if (presence != null) 'presence': presence!.value,
    };
  }
}

class RemoveField extends Enum<String> {
  static const avatar = RemoveField._create("Avatar");
  static const profileBackground = RemoveField._create("ProfileBackground");
  static const profileContent = RemoveField._create("ProfileContent");
  static const statusText = RemoveField._create("StatusText");

  const RemoveField._create(String value) : super(value);
}

class UserPresence extends Enum<String> {
  static const busy = UserPresence._create('Busy');
  static const idle = UserPresence._create('Idle');
  static const invisible = UserPresence._create('Invisible');
  static const online = UserPresence._create('Online');

  const UserPresence._create(String value) : super(value);
}
