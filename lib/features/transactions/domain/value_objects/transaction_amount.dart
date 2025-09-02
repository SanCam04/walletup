import '../../../../core/domain/value_objects/value_object.dart';
import '../policy/transaction_policy.dart';

/// Value object for transaction amount
class TransactionAmount extends ValueObject<double> {
  const TransactionAmount(super.value);

  /// Validates the transaction amount
  bool get isValid =>
      value >= TransactionPolicy.minAmount &&
      value <= TransactionPolicy.maxAmount;

  /// Error message if validation fails
  String? get errorMessage {
    if (value < TransactionPolicy.minAmount) {
      return 'Transaction amount must be at least \$${TransactionPolicy.minAmount}';
    }
    if (value > TransactionPolicy.maxAmount) {
      return 'Transaction amount cannot exceed \$${TransactionPolicy.maxAmount}';
    }
    return null;
  }

  /// Formatted amount as currency string
  String get formatted => '\$${value.toStringAsFixed(2)}';
}
