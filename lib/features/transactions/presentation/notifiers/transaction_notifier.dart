import 'dart:async';
import '../../../../core/presentation/state/base_state_notifier.dart';
import '../../application/usecases/create_transaction.dart';
import '../../application/usecases/delete_transaction.dart';
import '../../application/usecases/get_transactions.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/value_objects/transaction_type.dart';
import '../state/transaction_state.dart';

/// Transaction state notifier
class TransactionNotifier extends BaseStateNotifier<TransactionState> {
  TransactionNotifier({
    required this.getTransactions,
    required this.getTransactionsByWalletId,
    required this.createTransaction,
    required this.deleteTransaction,
    required this.repository,
  }) : super(const TransactionInitial()) {
    _initializeTransactions();
  }

  final GetTransactions getTransactions;
  final GetTransactionsByWalletId getTransactionsByWalletId;
  final CreateTransaction createTransaction;
  final DeleteTransaction deleteTransaction;
  final TransactionRepository repository;

  StreamSubscription? _transactionsSubscription;

  void _initializeTransactions() {
    // Watch for real-time updates
    _transactionsSubscription = repository.watchTransactions().listen(
      (transactions) {
        if (state is! TransactionLoading &&
            state is! TransactionCreating &&
            state is! TransactionDeleting) {
          state = TransactionLoaded(transactions: transactions);
        }
      },
      onError: (error) {
        state = TransactionError(message: error.toString());
      },
    );

    // Load initial transactions
    loadTransactions();
  }

  /// Load all transactions
  Future<void> loadTransactions() async {
    state = const TransactionLoading();

    final result = await getTransactions.call();
    result.fold(
      (failure) => state = TransactionError(message: failure.message),
      (transactions) => state = TransactionLoaded(transactions: transactions),
    );
  }

  /// Load transactions by wallet id
  Future<void> loadTransactionsByWalletId(String walletId) async {
    state = const TransactionLoading();

    final params = GetTransactionsByWalletIdParams(walletId: walletId);
    final result = await getTransactionsByWalletId.call(params);
    result.fold(
      (failure) => state = TransactionError(message: failure.message),
      (transactions) => state = TransactionLoaded(transactions: transactions),
    );
  }

  /// Create a new transaction
  Future<void> createNewTransaction({
    required String walletId,
    required double amount,
    required TransactionType type,
    required String description,
  }) async {
    state = const TransactionCreating();

    final params = CreateTransactionParams(
      walletId: walletId,
      amount: amount,
      type: type,
      description: description,
    );

    final result = await createTransaction.call(params);
    result.fold(
      (failure) => state = TransactionError(message: failure.message),
      (transaction) {
        state = TransactionCreated(transaction: transaction);
        // The stream will automatically update the state to TransactionLoaded
      },
    );
  }

  /// Delete a transaction
  Future<void> removeTransaction(String transactionId) async {
    state = TransactionDeleting(transactionId: transactionId);

    final params = DeleteTransactionParams(transactionId: transactionId);
    final result = await deleteTransaction.call(params);

    result.fold(
      (failure) => state = TransactionError(message: failure.message),
      (_) {
        state = TransactionDeleted(transactionId: transactionId);
        // The stream will automatically update the state to TransactionLoaded
      },
    );
  }

  /// Refresh transactions
  Future<void> refresh() async {
    await loadTransactions();
  }

  @override
  void dispose() {
    _transactionsSubscription?.cancel();
    super.dispose();
  }
}
