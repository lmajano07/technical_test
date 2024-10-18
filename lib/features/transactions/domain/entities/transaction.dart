import 'package:transactions_app/features/shared/shared.dart';

class Transaction {
  final int id;
  final double amount;
  final String description;
  final TransactionType type;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.type,
    required this.createdAt,
  });

  factory Transaction.create({
    required double amount,
    required String description,
    required TransactionType type,
    required DateTime createdAt,
  }) {
    return Transaction(
      id: 1,
      amount: amount,
      description: description,
      type: type,
      createdAt: createdAt,
    );
  }

  Transaction copyWith({
    int? id,
    double? amount,
    String? description,
    TransactionType? type,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
