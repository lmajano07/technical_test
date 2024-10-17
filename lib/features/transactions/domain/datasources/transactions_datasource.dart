import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';

abstract class TransactionsDatasource {
  FutureEitherTransactions getAll();
  Future<ApiResponse> create(Transaction transaction);
  Future<ApiResponse> update(Transaction transaction);
  Future<ApiResponse> delete(Transaction transaction);
  Future<ApiResponse> deleteAll();
}
