import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/create_transaction.dart';
import '../../application/usecases/delete_transaction.dart';
import '../../application/usecases/get_transactions.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/services/transaction_domain_service.dart';
import '../../infrastructure/datasources/transaction_local_datasource.dart';
import '../../infrastructure/datasources/transaction_local_datasource_impl.dart';
import '../../infrastructure/repositories/transaction_repository_impl.dart';
import '../notifiers/transaction_notifier.dart';
import '../state/transaction_state.dart';

/// Data source providers
final transactionLocalDataSourceProvider = Provider<TransactionLocalDataSource>(
  (ref) => TransactionLocalDataSourceImpl(),
);

/// Repository providers
final transactionRepositoryProvider = Provider<TransactionRepository>(
  (ref) => TransactionRepositoryImpl(
    localDataSource: ref.watch(transactionLocalDataSourceProvider),
  ),
);

/// Domain service providers
final transactionDomainServiceProvider = Provider<TransactionDomainService>(
  (ref) => TransactionDomainService(),
);

/// Use case providers
final getTransactionsProvider = Provider<GetTransactions>(
  (ref) => GetTransactions(ref.watch(transactionRepositoryProvider)),
);

final getTransactionsByWalletIdProvider = Provider<GetTransactionsByWalletId>(
  (ref) => GetTransactionsByWalletId(ref.watch(transactionRepositoryProvider)),
);

final createTransactionProvider = Provider<CreateTransaction>(
  (ref) => CreateTransaction(
    ref.watch(transactionRepositoryProvider),
    ref.watch(transactionDomainServiceProvider),
  ),
);

final deleteTransactionProvider = Provider<DeleteTransaction>(
  (ref) => DeleteTransaction(ref.watch(transactionRepositoryProvider)),
);

/// State notifier provider
final transactionNotifierProvider =
    StateNotifierProvider<TransactionNotifier, TransactionState>(
      (ref) => TransactionNotifier(
        getTransactions: ref.watch(getTransactionsProvider),
        getTransactionsByWalletId: ref.watch(getTransactionsByWalletIdProvider),
        createTransaction: ref.watch(createTransactionProvider),
        deleteTransaction: ref.watch(deleteTransactionProvider),
        repository: ref.watch(transactionRepositoryProvider),
      ),
    );
