import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Generic server failure
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

/// Cache failure for local storage issues
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Network failure for connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

/// Validation failure for input validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}
