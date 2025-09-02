import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';

/// Use case for getting all wallets
class GetWallets implements UseCaseNoParams<List<Wallet>> {
  const GetWallets(this._repository);

  final WalletRepository _repository;

  @override
  Future<Either<Failure, List<Wallet>>> call() async {
    return await _repository.getWallets();
  }
}
