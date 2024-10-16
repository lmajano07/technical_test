import 'package:flutter/material.dart';

import 'package:transactions_app/features/transactions/presentation/presentation.dart';

import 'package:transactions_app/features/shared/shared.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterWidget extends ConsumerStatefulWidget {
  const FilterWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends ConsumerState<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    final currentValue = ref.watch(filterProvider);

    onOptionSelected(value) {
      ref.read(filterProvider.notifier).state = value;
      Navigator.pop(context);
    }

    return Column(
      children: [
        Text(
          'Filter by',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        RadioListTile.adaptive(
          value: TransactionType.expense,
          groupValue: currentValue,
          onChanged: onOptionSelected,
          title: const Text('Expense'),
        ),
        RadioListTile.adaptive(
          value: TransactionType.income,
          groupValue: currentValue,
          onChanged: onOptionSelected,
          title: const Text('Income'),
        ),
        RadioListTile.adaptive(
          value: null,
          groupValue: currentValue,
          onChanged: onOptionSelected,
          title: const Text('None'),
        ),
      ],
    );
  }
}
