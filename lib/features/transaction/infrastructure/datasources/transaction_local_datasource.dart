import '../models/transaction_model.dart';

/// Abstract interface for local transaction data source
abstract class TransactionLocalDataSource {
  /// Get all transactions from local storage
  Future<List<TransactionModel>> getTransactions();

  /// Get transactions by wallet id from local storage
  Future<List<TransactionModel>> getTransactionsByWalletId(String walletId);

  /// Get transaction by id from local storage
  Future<TransactionModel?> getTransactionById(String id);

  /// Cache transaction to local storage
  Future<void> cacheTransaction(TransactionModel transaction);

  /// Cache multiple transactions to local storage
  Future<void> cacheTransactions(List<TransactionModel> transactions);

  /// Delete transaction from local storage
  Future<void> deleteTransaction(String id);

  /// Clear all transactions from local storage
  Future<void> clearTransactions();

  /// Watch transactions for real-time updates
  Stream<List<TransactionModel>> watchTransactions();

  /// Watch transactions by wallet id for real-time updates
  Stream<List<TransactionModel>> watchTransactionsByWalletId(String walletId);
}
