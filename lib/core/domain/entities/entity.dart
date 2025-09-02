import 'package:equatable/equatable.dart';

/// Base class for all domain entities
abstract class Entity extends Equatable {
  const Entity();

  /// Unique identifier for the entity
  String get id;

  @override
  List<Object?> get props => [id];
}
