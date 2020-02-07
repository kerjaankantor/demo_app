import 'dart:io';

class MovieApiError extends HttpException {
  final int code;
  final String method;
  final String body;

  MovieApiError({
    String message = 'MovieApiError',
    this.method,
    Uri uri,
    this.body,
    this.code,
  }) : super(message, uri: uri);

  String toString() {
    var b = new StringBuffer()..write('MovieApiError: ')..write(message);
    if (method != null) {
      b.write(', method = $method');
    }
    if (uri != null) {
      b.write(', uri = $uri');
    }
    if (body != null) {
      b.write(', body = $body');
    }
    return b.toString();
  }
}
