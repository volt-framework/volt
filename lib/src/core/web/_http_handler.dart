part of volt;

class _HttpHandler {
  static final Logger _logger = Logger('HTTP');

  final IVolt _client;
  final _HttpClient _http;
  final String baseUrl;

  // TODO: grab baseUrl from client config
  _HttpHandler(this._client, this.baseUrl) : _http = _HttpClient();

  Future<HttpResponse> get(
    String path, {
    Map<String, String>? headers,
  }) async {
    headers ??= {}..addAll({'x-bot-token': _client._token});
    return _handle(await _http.get(Uri.https(baseUrl, path), headers: headers));
  }

  Future<HttpResponse> head(
    String path, {
    Map<String, String>? headers,
  }) async {
    headers ??= {}..addAll({'x-bot-token': _client._token});
    return _handle(
      await _http.head(Uri.https(baseUrl, path), headers: headers),
    );
  }

  Future<HttpResponse> patch(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    headers ??= {}..addAll({
        'x-bot-token': _client._token,
        'Content-Type': 'application/json',
      });
    return _handle(
      await _http.patch(Uri.https(baseUrl, path),
          headers: headers, body: jsonEncode(body)),
    );
  }

  Future<HttpResponse> delete(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    headers ??= {}..addAll({
        'x-bot-token': _client._token,
        'Content-Type': 'application/json',
      });
    return _handle(await _http.delete(Uri.https(baseUrl, path),
        headers: headers, body: jsonEncode(body)));
  }

  Future<HttpResponse> put(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    headers ??= {}..addAll({
        'x-bot-token': _client._token,
        'Content-Type': 'application/json',
      });
    return _handle(
      await _http.put(Uri.https(baseUrl, path),
          headers: headers, body: jsonEncode(body)),
    );
  }

  Future<HttpResponse> post(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    headers ??= {}..addAll({
        'x-bot-token': _client._token,
        'Content-Type': 'application/json',
      });
    return _handle(
      await _http.post(Uri.https(baseUrl, path),
          headers: headers, body: jsonEncode(body)),
    );
  }

  Future<HttpResponse> _handle(HttpResponse response) async {
    _logger.fine('Got response: ${response.body}');
    return response;
  }
}
