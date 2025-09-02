import 'dart:async';
import '../../../../core/presentation/state/base_state_notifier.dart';
import '../../application/usecases/create_wallet.dart';
import '../../application/usecases/delete_wallet.dart';
import '../../application/usecases/get_wallets.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../state/wallet_state.dart';

/// Wallet state notifier
class WalletNotifier extends BaseStateNotifier<WalletState> {
  WalletNotifier({
    required this.getWallets,
    required this.createWallet,
    required this.deleteWallet,
    required this.repository,
  }) : super(const WalletInitial()) {
    _initializeWallets();
  }

  final GetWallets getWallets;
  final CreateWallet createWallet;
  final DeleteWallet deleteWallet;
  final WalletRepository repository;

  StreamSubscription? _walletsSubscription;

  void _initializeWallets() {
    // Watch for real-time updates
    _walletsSubscription = repository.watchWallets().listen(
      (wallets) {
        if (state is! WalletLoading &&
            state is! WalletCreating &&
            state is! WalletDeleting) {
          state = WalletLoaded(wallets: wallets);
        }
      },
      onError: (error) {
        state = WalletError(message: error.toString());
      },
    );

    // Load initial wallets
    loadWallets();
  }

  /// Load all wallets
  Future<void> loadWallets() async {
    state = const WalletLoading();

    final result = await getWallets.call();
    result.fold(
      (failure) => state = WalletError(message: failure.message),
      (wallets) => state = WalletLoaded(wallets: wallets),
    );
  }

  /// Create a new wallet
  Future<void> createNewWallet({
    required String name,
    double initialBalance = 0.0,
  }) async {
    state = const WalletCreating();

    final params = CreateWalletParams(
      name: name,
      initialBalance: initialBalance,
    );

    final result = await createWallet.call(params);
    result.fold((failure) => state = WalletError(message: failure.message), (
      wallet,
    ) {
      state = WalletCreated(wallet: wallet);
      // The stream will automatically update the state to WalletLoaded
    });
  }

  /// Delete a wallet
  Future<void> removeWallet(String walletId) async {
    state = WalletDeleting(walletId: walletId);

    final params = DeleteWalletParams(walletId: walletId);
    final result = await deleteWallet.call(params);

    result.fold((failure) => state = WalletError(message: failure.message), (
      _,
    ) {
      state = WalletDeleted(walletId: walletId);
      // The stream will automatically update the state to WalletLoaded
    });
  }

  /// Refresh wallets
  Future<void> refresh() async {
    await loadWallets();
  }

  @override
  void dispose() {
    _walletsSubscription?.cancel();
    super.dispose();
  }
}
