import 'package:transactions_app/core/core.dart';

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

  Future<ApiResponse> create(Transaction transaction) async {
    state = state.copyWith(isLoading: true);

    if (state.transactions.isEmpty) {
      transaction = transaction.copyWith(id: 1);
    } else {
      transaction = transaction.copyWith(id: state.transactions.length + 1);
    }

    final result = await repository.create(transaction);

    state = state.copyWith(isLoading: false);

    return result;
  }
}

class TransactionsState {
  final List<Transaction> transactions;
  final bool isLoading;

  TransactionsState({
    this.transactions = const [],
    this.isLoading = false,
  });

  TransactionsState copyWith({
    List<Transaction>? transactions,
    bool? isLoading,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
