import '../models/wallet_model.dart';

/// Abstract interface for local wallet data source
abstract class WalletLocalDataSource {
  /// Get all wallets from local storage
  Future<List<WalletModel>> getWallets();

  /// Get wallet by id from local storage
  Future<WalletModel?> getWalletById(String id);

  /// Cache wallet to local storage
  Future<void> cacheWallet(WalletModel wallet);

  /// Cache multiple wallets to local storage
  Future<void> cacheWallets(List<WalletModel> wallets);

  /// Delete wallet from local storage
  Future<void> deleteWallet(String id);

  /// Clear all wallets from local storage
  Future<void> clearWallets();

  /// Watch wallets for real-time updates
  Stream<List<WalletModel>> watchWallets();
}
