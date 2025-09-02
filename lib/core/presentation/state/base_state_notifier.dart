import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

/// Base state for all state notifiers
abstract class BaseState extends Equatable {
  const BaseState();
}

/// Loading state
class LoadingState extends BaseState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

/// Error state
class ErrorState extends BaseState {
  const ErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Base state notifier
abstract class BaseStateNotifier<T extends BaseState> extends StateNotifier<T> {
  BaseStateNotifier(super.initialState);

  /// Set loading state
  void setLoading() {
    if (state is! LoadingState) {
      state = const LoadingState() as T;
    }
  }

  /// Set error state
  void setError(String message) {
    state = ErrorState(message: message) as T;
  }
}
