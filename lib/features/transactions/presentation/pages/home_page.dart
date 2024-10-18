import 'package:flutter/material.dart';

import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/presentation/presentation.dart';

import 'package:transactions_app/features/shared/shared.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider = StateProvider<TransactionType?>((ref) => null);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Transaction> transactions = [];

  Future _getTransactions() async {
    final result = await ref.read(transactionsProvider.notifier).getAll();

    if (result.type == ResponseType.error) {
      showCustomDialog(
        context,
        title: 'Error',
        content: 'Couldn\'t fetch your records. Please try again later',
      );
      return;
    }

    setState(() => transactions = ref.read(transactionsProvider).transactions);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getTransactions();
    });

    super.initState();
  }

  List<Transaction> filteredTransactions() {
    final filter = ref.watch(filterProvider);

    switch (filter) {
      case TransactionType.expense:
        return transactions
            .where((item) => item.type == TransactionType.expense)
            .toList();
      case TransactionType.income:
        return transactions
            .where((item) => item.type == TransactionType.income)
            .toList();
      default:
        return transactions;
    }
  }

  _showFilterSheet() {
    return showCustomBottomSheet(
      context,
      height: MediaQuery.of(context).size.height * 0.35,
      child: const FilterWidget(),
    );
  }

  _navigateToManage(Transaction transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageTransactionPage(transaction: transaction),
      ),
    ).then((val) async => await _getTransactions());
  }

  @override
  Widget build(BuildContext context) {
    final transactions = filteredTransactions();

    return RefreshIndicator.adaptive(
      onRefresh: _getTransactions,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        appBar: AppBar(
          title: const Text('Transactions'),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(themeNotifierProvider.notifier).toggleDarkmode();
              },
              icon: const Icon(Icons.sunny),
            ),
            IconButton(
              onPressed: _showFilterSheet,
              icon: const Icon(Icons.sort),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              Expanded(
                child: (ref.watch(transactionsProvider).isLoading)
                    ? const _Loader()
                    : (transactions.isNotEmpty)
                        ? ListView.builder(
                            padding: const EdgeInsets.only(top: 32),
                            shrinkWrap: true,
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return TransactionCard(
                                margin: const EdgeInsets.only(bottom: 22),
                                transaction: transactions[index],
                                onTap: _navigateToManage,
                              );
                            },
                          )
                        : const _EmptyList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateTransactionPage(),
              ),
            ).then((val) async => await _getTransactions());
          },
        ),
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Center(
            child: Text(
              'No transactions',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
