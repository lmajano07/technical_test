import 'package:flutter/material.dart';

import 'package:transactions_app/core/core.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transactions_app/features/shared/shared.dart';
import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/presentation/presentation.dart';

final filterProvider = StateProvider<TransactionType?>((ref) => null);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Transaction> transactions = [];

  Future _getTransactions() async {
    setState(() {
      transactions = [
        Transaction(
          amount: 5.0,
          description: 'description',
          type: TransactionType.expense,
          createdAt: DateTime.now(),
        ),
        Transaction(
          amount: 5.0,
          description: 'description',
          type: TransactionType.income,
          createdAt: DateTime.now(),
        ),
        Transaction(
          amount: 5.0,
          description: 'description',
          type: TransactionType.expense,
          createdAt: DateTime.now(),
        ),
      ];
    });
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
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 32),
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      margin: const EdgeInsets.only(bottom: 22),
                      transaction: transactions[index],
                      onTap: (trs) {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My transactions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
