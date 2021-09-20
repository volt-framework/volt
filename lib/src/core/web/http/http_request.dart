part of volt;

abstract class HttpRequest {
  http.Request toRequest();
}

class BasicRequest extends HttpRequest {
  final _HttpHandler _handler;
  final Uri _url;
  final String method;
  final RawApiMap? body;

  BasicRequest._new(
    this._handler,
    String endpoint, {
    this.method = 'GET',
    this.body,
  }) : _url = Uri.https(_handler.baseUrl, endpoint);

  @override
  http.Request toRequest() {
    final req = http.Request(method, _url);
    if (body != null) req.body = jsonEncode(body);
    req.headers.addAll({
      'x-bot-token': _handler._client._token,
      'Content-Type': 'application/json',
    });

    return http.Request(method, _url);
  }

  // we do a little shortcutting
  Future<HttpResponse> execute() => _handler.execute(this);
}
