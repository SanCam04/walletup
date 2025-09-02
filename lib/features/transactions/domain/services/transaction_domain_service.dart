import '../entities/transaction.dart';
import '../value_objects/transaction_type.dart';

/// Domain service for transaction business logic
class TransactionDomainService {
  /// Calculate total income from transactions
  double calculateTotalIncome(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type.isIncome)
        .fold<double>(0.0, (sum, t) => sum + t.amount.value);
  }

  /// Calculate total expenses from transactions
  double calculateTotalExpenses(List<Transaction> transactions) {
    return transactions
        .where((t) => t.type.isExpense)
        .fold<double>(0.0, (sum, t) => sum + t.amount.value);
  }

  /// Calculate net balance from transactions
  double calculateNetBalance(List<Transaction> transactions) {
    return calculateTotalIncome(transactions) -
        calculateTotalExpenses(transactions);
  }

  /// Group transactions by date
  Map<DateTime, List<Transaction>> groupTransactionsByDate(
    List<Transaction> transactions,
  ) {
    final Map<DateTime, List<Transaction>> grouped = {};

    for (final transaction in transactions) {
      final date = DateTime(
        transaction.createdAt.year,
        transaction.createdAt.month,
        transaction.createdAt.day,
      );

      grouped.putIfAbsent(date, () => []).add(transaction);
    }

    return grouped;
  }

  /// Validate transaction for creation
  List<String> validateTransactionForCreation(Transaction transaction) {
    final errors = <String>[];

    if (!transaction.amount.isValid) {
      errors.add(
        transaction.amount.errorMessage ?? 'Invalid transaction amount',
      );
    }

    if (!transaction.description.isValid) {
      errors.add(
        transaction.description.errorMessage ??
            'Invalid transaction description',
      );
    }

    if (transaction.walletId.isEmpty) {
      errors.add('Wallet ID is required');
    }

    return errors;
  }

  /// Get transactions filtered by type
  List<Transaction> filterTransactionsByType(
    List<Transaction> transactions,
    TransactionType type,
  ) {
    return transactions.where((t) => t.type == type).toList();
  }

  /// Get recent transactions (last N transactions)
  List<Transaction> getRecentTransactions(
    List<Transaction> transactions,
    int limit,
  ) {
    final sortedTransactions = List<Transaction>.from(transactions)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return sortedTransactions.take(limit).toList();
  }
}
