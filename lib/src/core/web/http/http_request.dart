part of volt;

abstract class HttpRequest {
  http.Request toRequest();
}

class BasicRequest extends HttpRequest {
  final _HttpHandler _handler;
  final Uri _url;
  final String method;
  final RawApiMap? body;
  final RawApiMap? queryParameters;

  BasicRequest._new(this._handler, String endpoint,
      {this.method = 'GET', this.body, this.queryParameters})
      : _url = Uri.https(_handler.baseUrl, endpoint, queryParameters);

  @override
  http.Request toRequest() {
    final req = http.Request(method, _url);
    if (body != null) req.body = jsonEncode(body);
    req.headers.addAll({
      'User-Agent': 'Volt',
      'x-bot-token': _handler._client._token,
      'Content-Type': 'application/json',
    });

    return req;
  }

  // we do a little shortcutting
  Future<HttpResponse> execute() => _handler.execute(this);
}
