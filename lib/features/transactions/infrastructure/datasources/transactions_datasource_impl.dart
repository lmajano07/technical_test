import 'package:dartz/dartz.dart';
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
  Future<ApiResponse> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  FutureEitherTransactions getAll() async {
    try {
      final List<Transaction> transactions = [];
      final db = await database;

      final List<Map<String, Object?>> transactionObjetcs = await db.query(
        Environment.transactionsName,
      );

      for (var item in transactionObjetcs) {
        transactions.add(TransactionMapper.mapToEntity(item));
      }

      return right(transactions);
    } catch (e) {
      return left(ErrorResponse(message: e.toString()));
    }
  }

  @override
  Future<ApiResponse> update(Transaction transaction) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
