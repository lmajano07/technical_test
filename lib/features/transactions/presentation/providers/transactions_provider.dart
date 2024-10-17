import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/presentation/presentation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, TransactionsState>((ref) {
  final repository = ref.watch(transactionsRepoProvider);

  return TransactionsNotifier(repository: repository);
});

class TransactionsNotifier extends StateNotifier<TransactionsState> {
  final TransactionsRepository repository;

  TransactionsNotifier({required this.repository}) : super(TransactionsState());
}

class TransactionsState {
  final List<Transaction> transactions;

  TransactionsState({this.transactions = const []});

  TransactionsState copyWith(List<Transaction>? transactions) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
    );
  }
}
