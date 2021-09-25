part of volt;

class MessageQueryData {
  final Iterable<Message> messages;
  final Iterable<User> users;
  final Iterable<Member> members;

  MessageQueryData._new(IVolt client, dynamic raw)
      : messages = [
          if (raw is RawApiList)
            for (final message in raw)
              Message._new(client, message as RawApiMap)
          else
            for (final message in raw['messages'] as RawApiList)
              Message._new(client, message as RawApiMap)
        ],
        users = [
          if (raw is RawApiMap && raw['users'] != null)
            for (final message in raw['users'] as RawApiList)
              User._new(client, message as RawApiMap)
        ],
        members = [
          if (raw is RawApiMap && raw['members'] != null)
            for (final message in raw['members'] as RawApiList)
              Member._new(client, message as RawApiMap)
        ];
}
