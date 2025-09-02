import 'package:equatable/equatable.dart';

/// Base class for all value objects
abstract class ValueObject<T> extends Equatable {
  const ValueObject(this.value);

  final T value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '$runtimeType($value)';
}
