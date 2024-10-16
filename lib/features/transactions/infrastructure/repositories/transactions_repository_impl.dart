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
  Future<ApiResponse> delete(Transaction transaction) {
    return datasource.delete(transaction);
  }

  @override
  Future<ApiResponse> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  FutureEitherTransactions getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> update(Transaction transaction) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
