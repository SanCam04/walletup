import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_local_datasource.dart';
import '../models/wallet_model.dart';

/// Implementation of wallet repository
class WalletRepositoryImpl implements WalletRepository {
  const WalletRepositoryImpl({required this.localDataSource});

  final WalletLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Wallet>>> getWallets() async {
    try {
      final walletModels = await localDataSource.getWallets();
      final wallets = walletModels.map((model) => model.toEntity()).toList();
      return Right(wallets);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get wallets: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Wallet?>> getWalletById(String id) async {
    try {
      final walletModel = await localDataSource.getWalletById(id);
      final wallet = walletModel?.toEntity();
      return Right(wallet);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get wallet: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Wallet>> createWallet(Wallet wallet) async {
    try {
      final walletModel = WalletModel.fromEntity(wallet);
      await localDataSource.cacheWallet(walletModel);
      return Right(wallet);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to create wallet: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Wallet>> updateWallet(Wallet wallet) async {
    try {
      final walletModel = WalletModel.fromEntity(wallet);
      await localDataSource.cacheWallet(walletModel);
      return Right(wallet);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to update wallet: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteWallet(String id) async {
    try {
      await localDataSource.deleteWallet(id);
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to delete wallet: ${e.toString()}'),
      );
    }
  }

  @override
  Stream<List<Wallet>> watchWallets() {
    return localDataSource.watchWallets().map(
      (walletModels) => walletModels.map((model) => model.toEntity()).toList(),
    );
  }
}
