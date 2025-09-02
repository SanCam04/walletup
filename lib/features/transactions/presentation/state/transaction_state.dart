import '../../../../core/presentation/state/base_state_notifier.dart';
import '../../domain/entities/transaction.dart';

/// Transaction state
abstract class TransactionState extends BaseState {
  const TransactionState();
}

/// Initial state
class TransactionInitial extends TransactionState {
  const TransactionInitial();

  @override
  List<Object?> get props => [];
}

/// Loading state
class TransactionLoading extends TransactionState {
  const TransactionLoading();

  @override
  List<Object?> get props => [];
}

/// Loaded state
class TransactionLoaded extends TransactionState {
  const TransactionLoaded({required this.transactions});

  final List<Transaction> transactions;

  @override
  List<Object?> get props => [transactions];
}

/// Error state
class TransactionError extends TransactionState {
  const TransactionError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Creating transaction state
class TransactionCreating extends TransactionState {
  const TransactionCreating();

  @override
  List<Object?> get props => [];
}

/// Transaction created successfully state
class TransactionCreated extends TransactionState {
  const TransactionCreated({required this.transaction});

  final Transaction transaction;

  @override
  List<Object?> get props => [transaction];
}

/// Deleting transaction state
class TransactionDeleting extends TransactionState {
  const TransactionDeleting({required this.transactionId});

  final String transactionId;

  @override
  List<Object?> get props => [transactionId];
}

/// Transaction deleted successfully state
class TransactionDeleted extends TransactionState {
  const TransactionDeleted({required this.transactionId});

  final String transactionId;

  @override
  List<Object?> get props => [transactionId];
}
