import 'package:uuid/uuid.dart';
import '../../../../core/domain/entities/entity.dart';
import '../value_objects/transaction_amount.dart';
import '../value_objects/transaction_description.dart';
import '../value_objects/transaction_type.dart';

/// Transaction domain entity
class Transaction extends Entity {
  const Transaction({
    required this.id,
    required this.walletId,
    required this.amount,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  @override
  final String id;
  final String walletId;
  final TransactionAmount amount;
  final TransactionType type;
  final TransactionDescription description;
  final DateTime createdAt;

  /// Factory constructor for creating a new transaction
  factory Transaction.create({
    required String walletId,
    required double amount,
    required TransactionType type,
    required String description,
  }) {
    return Transaction(
      id: const Uuid().v4(),
      walletId: walletId,
      amount: TransactionAmount(amount),
      type: type,
      description: TransactionDescription(description),
      createdAt: DateTime.now(),
    );
  }

  /// Copy with method for immutable updates
  Transaction copyWith({
    String? id,
    String? walletId,
    TransactionAmount? amount,
    TransactionType? type,
    TransactionDescription? description,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Get signed amount based on transaction type
  double get signedAmount =>
      type == TransactionType.income ? amount.value : -amount.value;

  @override
  List<Object?> get props => [
    id,
    walletId,
    amount,
    type,
    description,
    createdAt,
  ];
}
