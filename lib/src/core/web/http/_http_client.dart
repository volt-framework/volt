part of volt;

class _HttpClient implements Disposable {
  final http.Client _innerClient;

  _HttpClient() : _innerClient = http.Client();

  Future<http.Response> execute(HttpRequest httpRequest) async {
    return await http.Response.fromStream(
      await _innerClient.send(httpRequest.toRequest()),
    );
  }

  @override
  Future<void> dispose() async {
    _innerClient.close();
  }
}
