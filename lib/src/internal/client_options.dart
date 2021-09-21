part of volt;

/// Here you can set up your client, e.g. change HTTP and WS URLs, enable or disable cache, etc.
class ClientOptions {
  /// REST endpoints URL. Defaults to `api.revolt.chat`
  final String httpBaseUrl;

  /// WebSocket events URL. Defaults to `ws.revolt.chat`
  final String wsBaseUrl;

  /// Cache options.
  final CacheOptions cacheOptions;

  /// Whether the client will ignore unhandled exceptions servers or not.
  final bool ignoreExceptions;

  /// Enable or disable logging.
  final bool enableLogging;

  ClientOptions({
    this.httpBaseUrl = 'api.revolt.chat',
    this.wsBaseUrl = 'ws.revolt.chat',
    this.cacheOptions = const CacheOptions._default(),
    this.ignoreExceptions = true,
    this.enableLogging = true,
  });
}

class CacheOptions {
  // Whether the client can cache servers or not.
  final bool cacheServers;

  // Whether the client can cache channels or not.
  final bool cacheChannels;

  // Whether the client can cache users or not.
  final bool cacheUsers;

  // Whether the client can cache members or not.
  final bool cacheMembers;

  // Whether the client can cache messages or not.
  final bool cacheMessages;

  CacheOptions({
    this.cacheServers = true,
    this.cacheChannels = true,
    this.cacheUsers = true,
    this.cacheMembers = true,
    this.cacheMessages = true,
  });

  const CacheOptions._default()
      : cacheServers = true,
        cacheChannels = true,
        cacheUsers = true,
        cacheMembers = true,
        cacheMessages = true;
}
