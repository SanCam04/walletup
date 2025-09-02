import '../../../../core/domain/value_objects/value_object.dart';
import '../policy/transaction_policy.dart';

/// Value object for transaction description
class TransactionDescription extends ValueObject<String> {
  const TransactionDescription(super.value);

  /// Validates the transaction description
  bool get isValid =>
      value.isNotEmpty &&
      value.length <= TransactionPolicy.maxDescriptionLength;

  /// Error message if validation fails
  String? get errorMessage {
    if (value.isEmpty) {
      return 'Transaction description cannot be empty';
    }
    if (value.length > TransactionPolicy.maxDescriptionLength) {
      return 'Transaction description cannot exceed ${TransactionPolicy.maxDescriptionLength} characters';
    }
    return null;
  }
}
