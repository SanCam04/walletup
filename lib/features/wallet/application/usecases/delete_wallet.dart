import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../domain/repositories/wallet_repository.dart';

/// Parameters for deleting a wallet
class DeleteWalletParams {
  const DeleteWalletParams({required this.walletId});

  final String walletId;
}

/// Use case for deleting a wallet
class DeleteWallet implements UseCase<void, DeleteWalletParams> {
  const DeleteWallet(this._repository);

  final WalletRepository _repository;

  @override
  Future<Either<Failure, void>> call(DeleteWalletParams params) async {
    try {
      return await _repository.deleteWallet(params.walletId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
