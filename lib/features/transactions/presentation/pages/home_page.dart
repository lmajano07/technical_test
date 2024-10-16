import 'package:flutter/material.dart';

import 'package:transactions_app/core/core.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transactions_app/features/shared/shared.dart';
import 'package:transactions_app/features/transactions/domain/domain.dart';

final filterProvider = StateProvider<TransactionType?>((ref) => null);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Transaction> transactions = [];

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

  @override
  Widget build(BuildContext context) {
    final transactions = filteredTransactions();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              const HomeHeader(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ),
              )
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
    showFilterSheet() {
      return showCustomBottomSheet(
        context,
        height: MediaQuery.of(context).size.height * 0.35,
        child: const FilterWidget(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My transactions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          onPressed: showFilterSheet,
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }
}
