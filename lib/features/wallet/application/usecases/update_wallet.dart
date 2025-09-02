import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/services/wallet_domain_service.dart';

/// Parameters for updating a wallet
class UpdateWalletParams {
  const UpdateWalletParams({required this.wallet});

  final Wallet wallet;
}

/// Use case for updating a wallet
class UpdateWallet implements UseCase<Wallet, UpdateWalletParams> {
  const UpdateWallet(this._repository, this._domainService);

  final WalletRepository _repository;
  final WalletDomainService _domainService;

  @override
  Future<Either<Failure, Wallet>> call(UpdateWalletParams params) async {
    try {
      // Validate wallet
      final validationErrors = _domainService.validateWalletForCreation(
        params.wallet,
      );
      if (validationErrors.isNotEmpty) {
        return Left(ValidationFailure(message: validationErrors.join(', ')));
      }

      // Update wallet with current timestamp
      final updatedWallet = params.wallet.copyWith(updatedAt: DateTime.now());

      // Update wallet in repository
      return await _repository.updateWallet(updatedWallet);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
