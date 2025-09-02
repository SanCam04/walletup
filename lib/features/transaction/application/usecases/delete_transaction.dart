import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../domain/repositories/transaction_repository.dart';

/// Parameters for deleting a transaction
class DeleteTransactionParams {
  const DeleteTransactionParams({required this.transactionId});

  final String transactionId;
}

/// Use case for deleting a transaction
class DeleteTransaction implements UseCase<void, DeleteTransactionParams> {
  const DeleteTransaction(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Either<Failure, void>> call(DeleteTransactionParams params) async {
    try {
      return await _repository.deleteTransaction(params.transactionId);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
