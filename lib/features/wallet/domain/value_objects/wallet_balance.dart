import '../../../../core/domain/value_objects/value_object.dart';

/// Value object for wallet balance
class WalletBalance extends ValueObject<double> {
  const WalletBalance(super.value);

  /// Validates the wallet balance
  bool get isValid => value >= 0;

  /// Error message if validation fails
  String? get errorMessage {
    if (value < 0) {
      return 'Wallet balance cannot be negative';
    }
    return null;
  }

  /// Formatted balance as currency string
  String get formatted => '\$${value.toStringAsFixed(2)}';

  /// Add amount to balance
  WalletBalance add(double amount) {
    return WalletBalance(value + amount);
  }

  /// Subtract amount from balance
  WalletBalance subtract(double amount) {
    return WalletBalance(value - amount);
  }
}
