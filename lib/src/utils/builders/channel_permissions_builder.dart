part of volt;

class ChannelPermissionsBuilder extends Builder<int> {
  int _raw = 0;

  bool? viewChannel;
  bool? sendMessages;
  bool? manageMessages;
  bool? manageChannel;
  bool? voiceCall;
  bool? inviteOthers;
  bool? embedLinks;
  bool? uploadFiles;

  ChannelPermissionsBuilder();

  ChannelPermissionsBuilder.from(ChannelPermissions permissions)
      : viewChannel = permissions.viewChannel,
        sendMessages = permissions.sendMessages,
        manageMessages = permissions.manageMessages,
        manageChannel = permissions.manageChannel,
        voiceCall = permissions.voiceCall,
        inviteOthers = permissions.inviteOthers,
        embedLinks = permissions.embedLinks,
        uploadFiles = permissions.uploadFiles;

  void _apply(bool? applies, int shift) =>
      _raw = FlagsUtils.apply(_raw, applies, shift);

  @override
  int build() {
    _raw = 0;

    _apply(viewChannel, 1 << 0);
    _apply(sendMessages, 1 << 1);
    _apply(manageMessages, 1 << 2);
    _apply(manageChannel, 1 << 3);
    _apply(voiceCall, 1 << 4);
    _apply(inviteOthers, 1 << 5);
    _apply(embedLinks, 1 << 6);
    _apply(uploadFiles, 1 << 7);

    return _raw;
  }
}
