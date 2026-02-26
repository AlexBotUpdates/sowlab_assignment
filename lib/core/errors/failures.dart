abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure([String message = "No Internet Connection"]) : super(message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class AuthFailure extends Failure {
  AuthFailure(super.message);
}
