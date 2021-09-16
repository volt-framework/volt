part of volt;

class _WsClient {
  final WebSocketChannel _ws;

  Stream<dynamic> get stream => _ws.stream.asBroadcastStream();

  Future<void> close({int? closeCode, String? closeReason}) async {
    _ws.sink.close(closeCode, closeReason);
  }

  Future<void> send(dynamic data) async {
    _ws.sink.add(data);
  }

  _WsClient(Uri url) : _ws = WebSocketChannel.connect(url);
}
