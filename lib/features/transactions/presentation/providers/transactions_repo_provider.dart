import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/infrastructure/infrastructure.dart';

import 'package:transactions_app/features/shared/shared.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsRepoProvider = Provider<TransactionsRepository>((ref) {
  final database = ref.watch(dbProvider);

  return TransactionsRepositoryImpl(
    datasource: TransactionsDatasourceImpl(database: database),
  );
});
