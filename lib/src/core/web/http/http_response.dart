part of volt;

abstract class HttpResponse {
  final dynamic body;
  final int statusCode;

  HttpResponse._new(
    this.body, {
    required this.statusCode,
  });
}

class HttpResponseSuccess extends HttpResponse {
  HttpResponseSuccess._new(dynamic body, {required int statusCode})
      : super._new(body, statusCode: statusCode);
}

class HttpResponseError extends HttpResponse {
  HttpResponseError._new(dynamic body, {required int statusCode})
      : super._new(body, statusCode: statusCode);
}
