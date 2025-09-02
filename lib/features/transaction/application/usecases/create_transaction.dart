import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/services/transaction_domain_service.dart';
import '../../domain/value_objects/transaction_type.dart';

/// Parameters for creating a transaction
class CreateTransactionParams {
  const CreateTransactionParams({
    required this.walletId,
    required this.amount,
    required this.type,
    required this.description,
  });

  final String walletId;
  final double amount;
  final TransactionType type;
  final String description;
}

/// Use case for creating a transaction
class CreateTransaction
    implements UseCase<Transaction, CreateTransactionParams> {
  const CreateTransaction(this._repository, this._domainService);

  final TransactionRepository _repository;
  final TransactionDomainService _domainService;

  @override
  Future<Either<Failure, Transaction>> call(
    CreateTransactionParams params,
  ) async {
    try {
      // Create transaction entity
      final transaction = Transaction.create(
        walletId: params.walletId,
        amount: params.amount,
        type: params.type,
        description: params.description,
      );

      // Validate transaction
      final validationErrors = _domainService.validateTransactionForCreation(
        transaction,
      );
      if (validationErrors.isNotEmpty) {
        return Left(ValidationFailure(message: validationErrors.join(', ')));
      }

      // Create transaction in repository
      return await _repository.createTransaction(transaction);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
