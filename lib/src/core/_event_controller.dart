part of volt;

class _EventController implements Disposable {
  final Volt _client;

  late final StreamController<RawApiMap> onRawEvent;
  late final StreamController<ReadyEvent> onReady;
  late final StreamController<MessageReceivedEvent> onMessageReceived;
  late final StreamController<ChannelStartTypingEvent> onChannelStartTyping;
  late final StreamController<ChannelStopTypingEvent> onChannelStopTyping;

  _EventController(this._client) {
    onRawEvent = StreamController.broadcast();
    _client.onRawEvent = onRawEvent.stream;

    onReady = StreamController.broadcast();
    _client.onReady = onReady.stream;

    onMessageReceived = StreamController.broadcast();
    _client.onMessageReceived = onMessageReceived.stream;

    onChannelStartTyping = StreamController.broadcast();
    _client.onChannelStartTyping = onChannelStartTyping.stream;

    onChannelStopTyping = StreamController.broadcast();
    _client.onChannelStopTyping = onChannelStopTyping.stream;
  }

  @override
  Future<void> dispose() async {
    await onRawEvent.close();
    await onMessageReceived.close();
    await onChannelStartTyping.close();
    await onChannelStopTyping.close();
  }
}
