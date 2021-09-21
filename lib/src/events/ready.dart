part of volt;

class ReadyEvent extends Event {
  Iterable<User> users;
  Iterable<Server> servers;
  Iterable<Channel> channels;

  ReadyEvent._new(Volt client, RawApiMap raw)
      : users = [
          for (final user in raw['users'] as List)
            User._define(client, user as RawApiMap)
        ],
        servers = [
          for (final server in raw['servers'] as List)
            Server._new(client, server as RawApiMap)
        ],
        channels = [
          for (final channel in raw['channels'] as List)
            Channel._define(client, channel as RawApiMap)
        ],
        super._new(raw['type']);
}
