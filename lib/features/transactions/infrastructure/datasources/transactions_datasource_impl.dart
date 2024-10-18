import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/infrastructure/infrastructure.dart';

import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart' as sqlite;

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
  Future<ApiResponse> delete(int id) async {
    try {
      final db = await database;

      await db.delete(
        Environment.transactionsName,
        where: 'id = ?',
        whereArgs: [id],
      );

      return SuccessResponse(message: 'Deleted successfully!');
    } catch (e) {
      return ErrorResponse(message: e.toString());
    }
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
  Future<ApiResponse> update(Transaction transaction) async {
    try {
      final db = await database;

      final newData = TransactionMapper.entityToMap(transaction);

      await db.update(
        Environment.transactionsName,
        newData,
        where: 'id = ?',
        whereArgs: [transaction.id],
      );

      return SuccessResponse(message: 'Updated successfully!');
    } catch (e) {
      return ErrorResponse(message: e.toString());
    }
  }
}
