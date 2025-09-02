import '../../../../core/domain/value_objects/value_object.dart';
import '../policy/wallet_policy.dart';

/// Value object for wallet name
class WalletName extends ValueObject<String> {
  const WalletName(super.value);

  /// Validates the wallet name
  bool get isValid =>
      value.isNotEmpty && value.length <= WalletPolicy.maxNameLength;

  /// Error message if validation fails
  String? get errorMessage {
    if (value.isEmpty) {
      return 'Wallet name cannot be empty';
    }
    if (value.length > WalletPolicy.maxNameLength) {
      return 'Wallet name cannot exceed ${WalletPolicy.maxNameLength} characters';
    }
    return null;
  }
}
