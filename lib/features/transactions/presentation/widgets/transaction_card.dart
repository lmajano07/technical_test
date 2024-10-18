import 'package:flutter/material.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/presentation/presentation.dart';

import 'package:transactions_app/features/shared/shared.dart';

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
            Expanded(
              flex: 2,
              child: Column(
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
            ),
            Flexible(
              flex: 1,
              child: AmountChip(
                isExpense: isExpense,
                amount: transaction.amount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
