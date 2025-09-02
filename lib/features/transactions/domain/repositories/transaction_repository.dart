import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../entities/transaction.dart';

/// Port/Interface for transaction repository
abstract class TransactionRepository {
  /// Get all transactions
  Future<Either<Failure, List<Transaction>>> getTransactions();

  /// Get transactions by wallet id
  Future<Either<Failure, List<Transaction>>> getTransactionsByWalletId(
    String walletId,
  );

  /// Get transaction by id
  Future<Either<Failure, Transaction?>> getTransactionById(String id);

  /// Create a new transaction
  Future<Either<Failure, Transaction>> createTransaction(
    Transaction transaction,
  );

  /// Delete a transaction
  Future<Either<Failure, void>> deleteTransaction(String id);

  /// Watch transactions for real-time updates
  Stream<List<Transaction>> watchTransactions();

  /// Watch transactions by wallet id for real-time updates
  Stream<List<Transaction>> watchTransactionsByWalletId(String walletId);
}
