import '../../../../core/domain/value_objects/value_object.dart';

/// Value object for transaction amount
class TransactionAmount extends ValueObject<double> {
  const TransactionAmount(super.value);

  /// Validates the transaction amount
  bool get isValid => value > 0;

  /// Error message if validation fails
  String? get errorMessage {
    if (value <= 0) {
      return 'Transaction amount must be positive';
    }
    return null;
  }

  /// Formatted amount as currency string
  String get formatted => '\$${value.toStringAsFixed(2)}';
}
