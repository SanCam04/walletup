import 'dart:async';
import '../models/transaction_model.dart';
import 'transaction_local_datasource.dart';

/// In-memory implementation of transaction local data source
/// In a real app, you would use SharedPreferences, Hive, SQLite, etc.
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  TransactionLocalDataSourceImpl();

  // In-memory storage (replace with actual persistence in real app)
  final Map<String, TransactionModel> _transactions = {};
  final StreamController<List<TransactionModel>> _transactionsController =
      StreamController<List<TransactionModel>>.broadcast();

  @override
  Future<List<TransactionModel>> getTransactions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _transactions.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<TransactionModel>> getTransactionsByWalletId(
    String walletId,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _transactions.values.where((t) => t.walletId == walletId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<TransactionModel?> getTransactionById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return _transactions[id];
  }

  @override
  Future<void> cacheTransaction(TransactionModel transaction) async {
    _transactions[transaction.id] = transaction;
    _notifyTransactionsChanged();
  }

  @override
  Future<void> cacheTransactions(List<TransactionModel> transactions) async {
    for (final transaction in transactions) {
      _transactions[transaction.id] = transaction;
    }
    _notifyTransactionsChanged();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    _transactions.remove(id);
    _notifyTransactionsChanged();
  }

  @override
  Future<void> clearTransactions() async {
    _transactions.clear();
    _notifyTransactionsChanged();
  }

  @override
  Stream<List<TransactionModel>> watchTransactions() {
    // Emit current state immediately
    _notifyTransactionsChanged();
    return _transactionsController.stream;
  }

  @override
  Stream<List<TransactionModel>> watchTransactionsByWalletId(String walletId) {
    return _transactionsController.stream.map(
      (transactions) =>
          transactions.where((t) => t.walletId == walletId).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  void _notifyTransactionsChanged() {
    final transactionsList = _transactions.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _transactionsController.add(transactionsList);
  }

  /// Dispose resources
  void dispose() {
    _transactionsController.close();
  }
}
