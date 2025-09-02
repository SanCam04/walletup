import '../../../../core/presentation/state/base_state_notifier.dart';
import '../../domain/entities/wallet.dart';

/// Wallet state
abstract class WalletState extends BaseState {
  const WalletState();
}

/// Initial state
class WalletInitial extends WalletState {
  const WalletInitial();

  @override
  List<Object?> get props => [];
}

/// Loading state
class WalletLoading extends WalletState {
  const WalletLoading();

  @override
  List<Object?> get props => [];
}

/// Loaded state
class WalletLoaded extends WalletState {
  const WalletLoaded({required this.wallets});

  final List<Wallet> wallets;

  @override
  List<Object?> get props => [wallets];
}

/// Error state
class WalletError extends WalletState {
  const WalletError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Creating wallet state
class WalletCreating extends WalletState {
  const WalletCreating();

  @override
  List<Object?> get props => [];
}

/// Wallet created successfully state
class WalletCreated extends WalletState {
  const WalletCreated({required this.wallet});

  final Wallet wallet;

  @override
  List<Object?> get props => [wallet];
}

/// Deleting wallet state
class WalletDeleting extends WalletState {
  const WalletDeleting({required this.walletId});

  final String walletId;

  @override
  List<Object?> get props => [walletId];
}

/// Wallet deleted successfully state
class WalletDeleted extends WalletState {
  const WalletDeleted({required this.walletId});

  final String walletId;

  @override
  List<Object?> get props => [walletId];
}
