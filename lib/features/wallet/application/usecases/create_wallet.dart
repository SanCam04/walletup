import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/services/wallet_domain_service.dart';

/// Parameters for creating a wallet
class CreateWalletParams {
  const CreateWalletParams({required this.name, this.initialBalance = 0.0});

  final String name;
  final double initialBalance;
}

/// Use case for creating a wallet
class CreateWallet implements UseCase<Wallet, CreateWalletParams> {
  const CreateWallet(this._repository, this._domainService);

  final WalletRepository _repository;
  final WalletDomainService _domainService;

  @override
  Future<Either<Failure, Wallet>> call(CreateWalletParams params) async {
    try {
      // Create wallet entity
      final wallet = Wallet.create(
        name: params.name,
        initialBalance: params.initialBalance,
      );

      // Validate wallet
      final validationErrors = _domainService.validateWalletForCreation(wallet);
      if (validationErrors.isNotEmpty) {
        return Left(ValidationFailure(message: validationErrors.join(', ')));
      }

      // Check if name is unique
      final existingWalletsResult = await _repository.getWallets();
      return existingWalletsResult.fold((failure) => Left(failure), (
        existingWallets,
      ) async {
        if (!_domainService.isWalletNameUnique(params.name, existingWallets)) {
          return const Left(
            ValidationFailure(message: 'Wallet name already exists'),
          );
        }

        // Create wallet in repository
        return await _repository.createWallet(wallet);
      });
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
