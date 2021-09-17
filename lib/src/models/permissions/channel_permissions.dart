part of volt;

class ChannelPermissions extends Permissions {
  final bool viewChannel;
  final bool sendMessages;
  final bool manageMessages;
  final bool manageChannel;
  final bool voiceCall;
  final bool inviteOthers;
  final bool embedLinks;
  final bool uploadFiles;

  ChannelPermissions._new(int raw)
      : viewChannel = FlagsUtils.isApplied(raw, 1 << 0),
        sendMessages = FlagsUtils.isApplied(raw, 1 << 1),
        manageMessages = FlagsUtils.isApplied(raw, 1 << 2),
        manageChannel = FlagsUtils.isApplied(raw, 1 << 3),
        voiceCall = FlagsUtils.isApplied(raw, 1 << 4),
        inviteOthers = FlagsUtils.isApplied(raw, 1 << 5),
        embedLinks = FlagsUtils.isApplied(raw, 1 << 6),
        uploadFiles = FlagsUtils.isApplied(raw, 1 << 7);
}
