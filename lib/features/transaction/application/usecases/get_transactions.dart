import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

/// Use case for getting all transactions
class GetTransactions implements UseCaseNoParams<List<Transaction>> {
  const GetTransactions(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Either<Failure, List<Transaction>>> call() async {
    return await _repository.getTransactions();
  }
}

/// Parameters for getting transactions by wallet id
class GetTransactionsByWalletIdParams {
  const GetTransactionsByWalletIdParams({required this.walletId});

  final String walletId;
}

/// Use case for getting transactions by wallet id
class GetTransactionsByWalletId
    implements UseCase<List<Transaction>, GetTransactionsByWalletIdParams> {
  const GetTransactionsByWalletId(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Either<Failure, List<Transaction>>> call(
    GetTransactionsByWalletIdParams params,
  ) async {
    return await _repository.getTransactionsByWalletId(params.walletId);
  }
}
