part of volt;

/// A wrapper around http package that automatically parses url and params, and decodes response.
class _HttpClient implements Disposable {
  final http.Client _innerClient;

  _HttpClient() : _innerClient = http.Client();

  Future<HttpResponse> get(Uri url, {Map<String, String>? headers}) async {
    final http.Response response =
        await _innerClient.get(url, headers: headers);

    return HttpResponse._new(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }

  Future<HttpResponse> post(Uri url,
      {dynamic body, Map<String, String>? headers}) async {
    final http.Response response =
        await _innerClient.post(url, body: body, headers: headers);

    return HttpResponse._new(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }

  Future<HttpResponse> put(Uri url,
      {dynamic body, Map<String, String>? headers}) async {
    final http.Response response =
        await _innerClient.put(url, body: body, headers: headers);

    return HttpResponse._new(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }

  Future<HttpResponse> patch(Uri url,
      {dynamic body, Map<String, String>? headers}) async {
    final http.Response response =
        await _innerClient.patch(url, body: body, headers: headers);

    return HttpResponse._new(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }

  Future<HttpResponse> delete(Uri url,
      {dynamic body, Map<String, String>? headers}) async {
    final http.Response response =
        await _innerClient.delete(url, body: body, headers: headers);

    return HttpResponse._new(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }

  Future<HttpResponse> head(Uri url, {Map<String, String>? headers}) async {
    final http.Response response =
        await _innerClient.head(url, headers: headers);

    return HttpResponse._new(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
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
