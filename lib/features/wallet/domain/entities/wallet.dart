import 'package:uuid/uuid.dart';
import '../../../../core/domain/entities/entity.dart';
import '../value_objects/wallet_balance.dart';
import '../value_objects/wallet_name.dart';

/// Wallet domain entity
class Wallet extends Entity {
  const Wallet({
    required this.id,
    required this.name,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  final WalletName name;
  final WalletBalance balance;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Factory constructor for creating a new wallet
  factory Wallet.create({required String name, double initialBalance = 0.0}) {
    final now = DateTime.now();
    return Wallet(
      id: const Uuid().v4(),
      name: WalletName(name),
      balance: WalletBalance(initialBalance),
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Copy with method for immutable updates
  Wallet copyWith({
    String? id,
    WalletName? name,
    WalletBalance? balance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Wallet(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, balance, createdAt, updatedAt];
}
