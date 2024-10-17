import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';

import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:transactions_app/features/transactions/infrastructure/infrastructure.dart';

class TransactionsDatasourceImpl implements TransactionsDatasource {
  final Future<sqlite.Database> database;

  TransactionsDatasourceImpl({required this.database});

  @override
  Future<ApiResponse> create(Transaction transaction) async {
    try {
      final db = await database;

      await db.insert(
        Environment.transactionsName,
        TransactionMapper.entityToMap(transaction),
        conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
      );

      return SuccessResponse();
    } catch (e) {
      return ErrorResponse(message: e.toString());
    }
  }

  @override
  Future<ApiResponse> delete(Transaction transaction) {
    // TODO: implement delete
    throw UnimplementedError();
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
