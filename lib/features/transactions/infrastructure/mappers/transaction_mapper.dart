import 'package:transactions_app/features/transactions/domain/domain.dart';

import 'package:transactions_app/features/shared/shared.dart';

class TransactionMapper {
  TransactionMapper._();

  static Transaction mapToEntity(Map<String, dynamic> map) {
    double amount = 0.0;
    final isInt = map['amount'].runtimeType == int;
    amount = (isInt) ? map['amount'].toDouble() : amount = map['amount'];

    return Transaction(
      id: map['id'],
      amount: amount,
      description: map['description'],
      type: transactionTypeFromString(map['type']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  static Map<String, dynamic> entityToMap(Transaction transaction) {
    return {
      'id': transaction.id,
      'amount': transaction.amount,
      'description': transaction.description,
      'type': transaction.type.toString(),
      'createdAt': transaction.createdAt.millisecondsSinceEpoch,
    };
  }
}
