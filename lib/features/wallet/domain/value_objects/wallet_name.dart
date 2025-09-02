import '../../../../core/domain/value_objects/value_object.dart';

/// Value object for wallet name
class WalletName extends ValueObject<String> {
  const WalletName(super.value);

  /// Validates the wallet name
  bool get isValid => value.isNotEmpty && value.length <= 50;

  /// Error message if validation fails
  String? get errorMessage {
    if (value.isEmpty) {
      return 'Wallet name cannot be empty';
    }
    if (value.length > 50) {
      return 'Wallet name cannot exceed 50 characters';
    }
    return null;
  }
}
