import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsDatasource datasource;

  TransactionsRepositoryImpl({required this.datasource});

  @override
  Future<ApiResponse> create(Transaction transaction) {
    return datasource.create(transaction);
  }

  @override
  Future<ApiResponse> delete(int id) {
    return datasource.delete(id);
  }

  @override
  FutureEitherTransactions getAll() {
    return datasource.getAll();
  }

  @override
  Future<ApiResponse> update(Transaction transaction) {
    return datasource.update(transaction);
  }
}
