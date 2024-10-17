import 'package:transactions_app/features/shared/shared.dart';

class Transaction {
  final double amount;
  final String description;
  final TransactionType type;
  final DateTime createdAt;

  Transaction({
    required this.amount,
    required this.description,
    required this.type,
    required this.createdAt,
  });
}
