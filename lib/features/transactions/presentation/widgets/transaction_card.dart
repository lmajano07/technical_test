import 'package:flutter/material.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';

import 'package:transactions_app/features/shared/shared.dart';

import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onTap,
    this.margin,
  });

  final Transaction transaction;
  final void Function(Transaction) onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == TransactionType.expense;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onTap(transaction),
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorScheme.surfaceBright,
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  transaction.createdAt.format(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurface,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
            const Spacer(),
            _AmountChip(isExpense: isExpense, transaction: transaction),
          ],
        ),
      ),
    );
  }
}

class _AmountChip extends StatelessWidget {
  const _AmountChip({
    required this.isExpense,
    required this.transaction,
  });

  final bool isExpense;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00');

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isExpense ? Colors.red : Colors.green,
      ),
      child: Text(
        '${isExpense ? '-' : '+'} \$${numberFormat.format(transaction.amount)}',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
