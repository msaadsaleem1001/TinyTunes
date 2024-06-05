class AppExceptions implements Exception{
  final String? message;
  final String? prefix;
  AppExceptions([this.message, this.prefix]);
  @override
  String toString(){
    return '$message$prefix';
  }
}

class InternetException extends AppExceptions{
  InternetException([String? message]) : super('No Internet!');

}

class RequestTimeOut extends AppExceptions{
  RequestTimeOut([String? message]) : super('Request Time Out!');
}

class ServerException extends AppExceptions{
  ServerException([String? message]) : super('Server Exception!');
}

class InvalidUrlException extends AppExceptions{
  InvalidUrlException([String? message]) : super('Invalid Url!');
}

class UnAuthorizedException extends AppExceptions{
  UnAuthorizedException([String? message]) : super('Un Authorized User Exception!');
}

class NotFoundException extends AppExceptions{
  NotFoundException([String? message]) : super('Not Found Exception!');
}

class ServiceUnavailableException extends AppExceptions{
  ServiceUnavailableException([String? message]) : super('Service Unavailable Right Now!');
}

class DefaultException extends AppExceptions{
  DefaultException([String? message]) : super('Internal Server Error!');
}