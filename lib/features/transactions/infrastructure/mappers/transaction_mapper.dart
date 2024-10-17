import 'package:transactions_app/features/transactions/domain/domain.dart';

import 'package:transactions_app/features/shared/shared.dart';

class TransactionMapper {
  TransactionMapper._();

  static Transaction mapToEntity(Map<String, dynamic> map) {
    return Transaction(
      amount: map['amount'],
      description: map['description'],
      type: transactionTypeFromString(map['type']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  static Map<String, dynamic> entityToMap(Transaction transaction) {
    return {
      'amount': transaction.amount,
      'description': transaction.description,
      'type': transaction.type.toString(),
      'createdAt': transaction.createdAt,
    };
  }
}
