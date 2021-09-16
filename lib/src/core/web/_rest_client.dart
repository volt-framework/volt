part of volt;

/// A wrapper around http package that automatically parses url and params, and decodes response.
class _HttpClient {
  final Client _client;
  final String _baseUrl;

  _HttpClient(this._baseUrl) : _client = Client();

  Future<_RestClientResponse> get(
    String endpoint, {
    Map<String, String>? parameters,
    Map<String, String>? headers,
  }) async {
    final Response response = await _client.get(
      Uri.https(_baseUrl, endpoint, parameters),
      headers: headers,
    );

    print(response.body);

    return _RestClientResponse(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }

  Future<_RestClientResponse> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final Response response = await _client.post(
      Uri.https(_baseUrl, endpoint),
      body: body,
      headers: headers,
    );
    print(response.body);
    return _RestClientResponse(
      jsonDecode(utf8.decode(response.bodyBytes)),
      statusCode: response.statusCode,
    );
  }
}

class _RestClientResponse {
  final dynamic body;
  final int statusCode;

  _RestClientResponse(
    this.body, {
    required this.statusCode,
  });
}
