import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/value_objects/transaction_amount.dart';
import '../../domain/value_objects/transaction_description.dart';
import '../../domain/value_objects/transaction_type.dart';

part 'transaction_model.g.dart';

/// Data model for transaction persistence
@JsonSerializable()
class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.walletId,
    required this.amount,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  final String id;
  final String walletId;
  final double amount;
  final String type;
  final String description;
  final DateTime createdAt;

  /// Convert from domain entity
  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      walletId: transaction.walletId,
      amount: transaction.amount.value,
      type: transaction.type.name,
      description: transaction.description.value,
      createdAt: transaction.createdAt,
    );
  }

  /// Convert to domain entity
  Transaction toEntity() {
    return Transaction(
      id: id,
      walletId: walletId,
      amount: TransactionAmount(amount),
      type: TransactionType.values.firstWhere((t) => t.name == type),
      description: TransactionDescription(description),
      createdAt: createdAt,
    );
  }

  /// JSON serialization
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  /// Copy with method
  TransactionModel copyWith({
    String? id,
    String? walletId,
    double? amount,
    String? type,
    String? description,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
