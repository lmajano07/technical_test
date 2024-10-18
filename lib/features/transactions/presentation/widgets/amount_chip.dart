import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AmountChip extends StatelessWidget {
  const AmountChip({
    super.key,
    required this.isExpense,
    required this.amount,
    this.width,
  });

  final bool isExpense;
  final double amount;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0.00');

    return Container(
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isExpense ? Colors.red : Colors.green,
      ),
      child: Text(
        '${isExpense ? '-' : '+'} \$${numberFormat.format(amount)}',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
