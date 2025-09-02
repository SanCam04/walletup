import 'package:dartz/dartz.dart';
import '../failures/failure.dart';

/// Base interface for all use cases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case with no parameters
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// No parameters class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
