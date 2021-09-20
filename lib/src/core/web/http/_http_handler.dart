part of volt;

class _HttpHandler {
  static final Logger _logger = Logger('HTTP');

  final IVolt _client;
  final _HttpClient _http;
  final String baseUrl;

  // TODO: grab baseUrl from client config
  _HttpHandler(this._client, this.baseUrl) : _http = _HttpClient();

  Future<HttpResponse> execute(HttpRequest httpRequest) async =>
      _handle(await _http.execute(httpRequest));

  // TODO: handle errors
  Future<HttpResponse> _handle(http.Response response) async {
    _logger.fine('Got response: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return HttpResponseSuccess._new(
        response.body.isEmpty
            ? null
            : jsonDecode(utf8.decode(response.bodyBytes)),
        statusCode: response.statusCode,
      );
    }

    return HttpResponseError._new(
      response.body.isEmpty
          ? null
          : jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }
}
