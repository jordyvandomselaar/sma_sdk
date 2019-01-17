class HttpException implements Exception {
  int statusCode;
  String message;

  HttpException(this.statusCode, this.message);

  @override
  String toString() {
    return "Status: ${statusCode}, message: ${message}";
  }
}

class UnauthorizedException extends HttpException {
    UnauthorizedException(message): super(401, message);
}

class ValidationException extends HttpException {
    ValidationException(message): super(422, message);
}