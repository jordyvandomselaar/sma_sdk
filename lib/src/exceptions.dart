class HttpException implements Exception {
  int statusCode;
  String message;

  HttpException(this.statusCode, this.message);
}

class UnauthorizedException extends HttpException {
    UnauthorizedException(message): super(statusCode, message);
}