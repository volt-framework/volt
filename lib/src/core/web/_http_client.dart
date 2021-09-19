part of volt;

// TODO: does in really need? lmao
class _HttpClient implements Disposable {
  final http.Client _innerClient;

  _HttpClient() : _innerClient = http.Client();

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return _innerClient.get(url, headers: headers);
  }

  Future<http.Response> post(Uri url,
      {dynamic body, Map<String, String>? headers}) {
    return _innerClient.post(url, body: body, headers: headers);
  }

  Future<http.Response> put(Uri url,
      {dynamic body, Map<String, String>? headers}) {
    return _innerClient.put(url, body: body, headers: headers);
  }

  Future<http.Response> patch(Uri url,
      {dynamic body, Map<String, String>? headers}) {
    return _innerClient.patch(url, body: body, headers: headers);
  }

  Future<http.Response> delete(Uri url,
      {dynamic body, Map<String, String>? headers}) {
    return _innerClient.delete(url, body: body, headers: headers);
  }

  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    return _innerClient.head(url, headers: headers);
  }

  @override
  Future<void> dispose() async {
    _innerClient.close();
  }
}

class HttpResponse {
  final dynamic body;
  final int statusCode;

  HttpResponse._new(
    this.body, {
    required this.statusCode,
  });
}
