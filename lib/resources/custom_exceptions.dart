//  -------------- CUSTOM EXCEPTIONS --------------
//  Class of custom exceptions called after failed http requests

class CustomException implements Exception {
  final message;
  final prefix;
  final body;

  CustomException(this.body, [this.message, this.prefix]);

  String toString() {
    return "$prefix$message: $body";
  }
}

class FetchDataException extends CustomException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException(body, [message])
      : super(message, "Invalid Request: ", body);
}

class ForbiddenException extends CustomException {
  ForbiddenException([message]) : super(message, "Forbidden: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
