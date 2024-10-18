import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transactions_app/features/transactions/presentation/presentation.dart';

class BalanceWidget extends ConsumerWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Balance',
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 12),
          const _SummaryItem(
            isIncome: true,
            amount: 1000.99,
            showLabel: false,
          ),
          const SizedBox(height: 24),
          Text(
            'Summary',
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _SummaryItem(
                  isIncome: true,
                  amount: 1000.99,
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _SummaryItem(
                  isIncome: false,
                  amount: 1111.99,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.isIncome,
    required this.amount,
    this.showLabel = true,
  });

  final bool isIncome, showLabel;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showLabel)
          Text(
            (isIncome) ? 'Income' : 'Expense',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        AmountChip(
          isExpense: !isIncome,
          amount: amount,
        ),
      ],
    );
  }
}
