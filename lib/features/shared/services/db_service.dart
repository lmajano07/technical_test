import 'package:transactions_app/core/core.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbProvider = Provider<Future<Database>>((ref) async {
  final database = openDatabase(
    join(await getDatabasesPath(), Environment.dbName),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE ${Environment.transactionsName}(id INTEGER PRIMARY KEY, amount DECIMAL(10,2), description TEXT, type TEXT, createdAt DATETIME)',
      );
    },
  );

  return database;
});
