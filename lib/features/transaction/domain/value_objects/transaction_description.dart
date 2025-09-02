import '../../../../core/domain/value_objects/value_object.dart';

/// Value object for transaction description
class TransactionDescription extends ValueObject<String> {
  const TransactionDescription(super.value);

  /// Validates the transaction description
  bool get isValid => value.isNotEmpty && value.length <= 200;

  /// Error message if validation fails
  String? get errorMessage {
    if (value.isEmpty) {
      return 'Transaction description cannot be empty';
    }
    if (value.length > 200) {
      return 'Transaction description cannot exceed 200 characters';
    }
    return null;
  }
}
