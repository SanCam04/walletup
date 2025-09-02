import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/value_objects/wallet_balance.dart';
import '../../domain/value_objects/wallet_name.dart';

part 'wallet_model.g.dart';

/// Data model for wallet persistence
@JsonSerializable()
class WalletModel {
  const WalletModel({
    required this.id,
    required this.name,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final double balance;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Convert from domain entity
  factory WalletModel.fromEntity(Wallet wallet) {
    return WalletModel(
      id: wallet.id,
      name: wallet.name.value,
      balance: wallet.balance.value,
      createdAt: wallet.createdAt,
      updatedAt: wallet.updatedAt,
    );
  }

  /// Convert to domain entity
  Wallet toEntity() {
    return Wallet(
      id: id,
      name: WalletName(name),
      balance: WalletBalance(balance),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// JSON serialization
  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletModelToJson(this);

  /// Copy with method
  WalletModel copyWith({
    String? id,
    String? name,
    double? balance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletModel(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
