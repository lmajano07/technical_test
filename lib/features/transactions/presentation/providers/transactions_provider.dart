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

  TransactionsNotifier({required this.repository})
      : super(TransactionsState()) {
    _initBalance();
  }

  Future<ApiResponse> create(Transaction transaction) async {
    _toggleLoading();

    if (state.transactions.isEmpty) {
      transaction = transaction.copyWith(id: 1);
    } else {
      transaction = transaction.copyWith(id: state.transactions.length + 1);
    }

    final result = await repository.create(transaction);

    _toggleLoading();

    return result;
  }

  Future<ApiResponse> getAll() async {
    _toggleLoading();

    final result = await repository.getAll();

    return result.fold(
      (error) {
        _toggleLoading();
        return error;
      },
      (transactions) {
        state = state.copyWith(transactions: transactions, isLoading: false);

        return SuccessResponse();
      },
    );
  }

  Future<ApiResponse> update(Transaction transaction) async {
    _toggleLoading();

    final result = await repository.update(transaction);

    _toggleLoading();

    return result;
  }

  Future<ApiResponse> delete(int id) async {
    _toggleLoading();

    final result = await repository.delete(id);

    _toggleLoading();

    return result;
  }

  void calculateBudget() {}

  void _toggleLoading() => state = state.copyWith(isLoading: !state.isLoading);

  void _initBalance() => state = state.copyWith(balance: Balance.empty());
}

class TransactionsState {
  final bool isLoading;
  final List<Transaction> transactions;
  final Balance? balance;

  TransactionsState({
    this.isLoading = false,
    this.transactions = const [],
    this.balance,
  });

  TransactionsState copyWith({
    List<Transaction>? transactions,
    bool? isLoading,
    Balance? balance,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      balance: balance ?? this.balance,
    );
  }
}
