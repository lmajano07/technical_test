import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/infrastructure/infrastructure.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsRepoProvider = Provider<TransactionsRepository>((ref) {
  return TransactionsRepositoryImpl(datasource: TransactionsDatasourceImpl());
});
