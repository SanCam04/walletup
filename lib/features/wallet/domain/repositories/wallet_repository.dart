import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../entities/wallet.dart';

/// Port/Interface for wallet repository
abstract class WalletRepository {
  /// Get all wallets
  Future<Either<Failure, List<Wallet>>> getWallets();

  /// Get wallet by id
  Future<Either<Failure, Wallet?>> getWalletById(String id);

  /// Create a new wallet
  Future<Either<Failure, Wallet>> createWallet(Wallet wallet);

  /// Update an existing wallet
  Future<Either<Failure, Wallet>> updateWallet(Wallet wallet);

  /// Delete a wallet
  Future<Either<Failure, void>> deleteWallet(String id);

  /// Watch wallets for real-time updates
  Stream<List<Wallet>> watchWallets();
}
