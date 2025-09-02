import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/usecases/create_wallet.dart';
import '../../application/usecases/delete_wallet.dart';
import '../../application/usecases/get_wallets.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/services/wallet_domain_service.dart';
import '../../infrastructure/datasources/wallet_local_datasource.dart';
import '../../infrastructure/datasources/wallet_local_datasource_impl.dart';
import '../../infrastructure/repositories/wallet_repository_impl.dart';
import '../notifiers/wallet_notifier.dart';
import '../state/wallet_state.dart';

/// Data source providers
final walletLocalDataSourceProvider = Provider<WalletLocalDataSource>(
  (ref) => WalletLocalDataSourceImpl(),
);

/// Repository providers
final walletRepositoryProvider = Provider<WalletRepository>(
  (ref) => WalletRepositoryImpl(
    localDataSource: ref.watch(walletLocalDataSourceProvider),
  ),
);

/// Domain service providers
final walletDomainServiceProvider = Provider<WalletDomainService>(
  (ref) => WalletDomainService(),
);

/// Use case providers
final getWalletsProvider = Provider<GetWallets>(
  (ref) => GetWallets(ref.watch(walletRepositoryProvider)),
);

final createWalletProvider = Provider<CreateWallet>(
  (ref) => CreateWallet(
    ref.watch(walletRepositoryProvider),
    ref.watch(walletDomainServiceProvider),
  ),
);

final deleteWalletProvider = Provider<DeleteWallet>(
  (ref) => DeleteWallet(ref.watch(walletRepositoryProvider)),
);

/// State notifier provider
final walletNotifierProvider =
    StateNotifierProvider<WalletNotifier, WalletState>(
      (ref) => WalletNotifier(
        getWallets: ref.watch(getWalletsProvider),
        createWallet: ref.watch(createWalletProvider),
        deleteWallet: ref.watch(deleteWalletProvider),
        repository: ref.watch(walletRepositoryProvider),
      ),
    );
