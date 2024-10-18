import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AmountChip extends StatelessWidget {
  const AmountChip({
    super.key,
    required this.isExpense,
    required this.amount,
    this.width,
    this.isNeutral = false,
  });

  final bool isExpense, isNeutral;
  final double amount;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00');

    String amountText() {
      String text = '';

      if (!isNeutral) text += isExpense ? '-' : '+';

      text += ' \$${numberFormat.format(amount.abs())}';

      return text;
    }

    return Container(
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isNeutral
            ? Theme.of(context).colorScheme.onSurfaceVariant
            : isExpense
                ? Colors.red
                : Colors.green,
      ),
      child: Text(
        amountText(),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: (isNeutral)
                  ? Theme.of(context).colorScheme.onInverseSurface
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
