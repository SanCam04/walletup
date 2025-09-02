import 'dart:async';
import '../models/wallet_model.dart';
import 'wallet_local_datasource.dart';

/// In-memory implementation of wallet local data source
/// In a real app, you would use SharedPreferences, Hive, SQLite, etc.
class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  WalletLocalDataSourceImpl();

  // In-memory storage (replace with actual persistence in real app)
  final Map<String, WalletModel> _wallets = {};
  final StreamController<List<WalletModel>> _walletsController =
      StreamController<List<WalletModel>>.broadcast();

  @override
  Future<List<WalletModel>> getWallets() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _wallets.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<WalletModel?> getWalletById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return _wallets[id];
  }

  @override
  Future<void> cacheWallet(WalletModel wallet) async {
    _wallets[wallet.id] = wallet;
    _notifyWalletsChanged();
  }

  @override
  Future<void> cacheWallets(List<WalletModel> wallets) async {
    for (final wallet in wallets) {
      _wallets[wallet.id] = wallet;
    }
    _notifyWalletsChanged();
  }

  @override
  Future<void> deleteWallet(String id) async {
    _wallets.remove(id);
    _notifyWalletsChanged();
  }

  @override
  Future<void> clearWallets() async {
    _wallets.clear();
    _notifyWalletsChanged();
  }

  @override
  Stream<List<WalletModel>> watchWallets() {
    // Emit current state immediately
    _notifyWalletsChanged();
    return _walletsController.stream;
  }

  void _notifyWalletsChanged() {
    final walletsList = _wallets.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _walletsController.add(walletsList);
  }

  /// Dispose resources
  void dispose() {
    _walletsController.close();
  }
}
