import '../entities/wallet.dart';
import '../value_objects/wallet_balance.dart';

/// Domain service for wallet business logic
class WalletDomainService {
  /// Calculate total balance across all wallets
  WalletBalance calculateTotalBalance(List<Wallet> wallets) {
    final total = wallets.fold<double>(
      0.0,
      (sum, wallet) => sum + wallet.balance.value,
    );
    return WalletBalance(total);
  }

  /// Check if wallet can perform transaction
  bool canPerformTransaction(Wallet wallet, double amount) {
    if (amount < 0) {
      // For withdrawals, check if sufficient balance
      return wallet.balance.value >= amount.abs();
    }
    // For deposits, always allowed
    return true;
  }

  /// Validate wallet for creation
  List<String> validateWalletForCreation(Wallet wallet) {
    final errors = <String>[];

    if (!wallet.name.isValid) {
      errors.add(wallet.name.errorMessage ?? 'Invalid wallet name');
    }

    if (!wallet.balance.isValid) {
      errors.add(wallet.balance.errorMessage ?? 'Invalid wallet balance');
    }

    return errors;
  }

  /// Check if wallet names are unique
  bool isWalletNameUnique(String name, List<Wallet> existingWallets) {
    return !existingWallets.any(
      (wallet) => wallet.name.value.toLowerCase() == name.toLowerCase(),
    );
  }
}
