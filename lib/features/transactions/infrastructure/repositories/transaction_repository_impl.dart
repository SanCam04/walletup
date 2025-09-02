import 'package:dartz/dartz.dart';
import '../../../../core/domain/failures/failure.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_datasource.dart';
import '../models/transaction_model.dart';

/// Implementation of transaction repository
class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl({required this.localDataSource});

  final TransactionLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    try {
      final transactionModels = await localDataSource.getTransactions();
      final transactions = transactionModels
          .map((model) => model.toEntity())
          .toList();
      return Right(transactions);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get transactions: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionsByWalletId(
    String walletId,
  ) async {
    try {
      final transactionModels = await localDataSource.getTransactionsByWalletId(
        walletId,
      );
      final transactions = transactionModels
          .map((model) => model.toEntity())
          .toList();
      return Right(transactions);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get transactions: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Transaction?>> getTransactionById(String id) async {
    try {
      final transactionModel = await localDataSource.getTransactionById(id);
      final transaction = transactionModel?.toEntity();
      return Right(transaction);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to get transaction: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Transaction>> createTransaction(
    Transaction transaction,
  ) async {
    try {
      final transactionModel = TransactionModel.fromEntity(transaction);
      await localDataSource.cacheTransaction(transactionModel);
      return Right(transaction);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to create transaction: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    try {
      await localDataSource.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Failed to delete transaction: ${e.toString()}'),
      );
    }
  }

  @override
  Stream<List<Transaction>> watchTransactions() {
    return localDataSource.watchTransactions().map(
      (transactionModels) =>
          transactionModels.map((model) => model.toEntity()).toList(),
    );
  }

  @override
  Stream<List<Transaction>> watchTransactionsByWalletId(String walletId) {
    return localDataSource
        .watchTransactionsByWalletId(walletId)
        .map(
          (transactionModels) =>
              transactionModels.map((model) => model.toEntity()).toList(),
        );
  }
}
