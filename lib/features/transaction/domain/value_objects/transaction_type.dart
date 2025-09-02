/// Enum for transaction types
enum TransactionType {
  income('Income'),
  expense('Expense');

  const TransactionType(this.displayName);

  final String displayName;

  /// Check if transaction is income
  bool get isIncome => this == TransactionType.income;

  /// Check if transaction is expense
  bool get isExpense => this == TransactionType.expense;
}
