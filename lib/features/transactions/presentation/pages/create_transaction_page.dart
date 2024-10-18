import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/shared/shared.dart';
import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/presentation/presentation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTransactionPage extends ConsumerStatefulWidget {
  const CreateTransactionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTransactionPageState();
}

class _CreateTransactionPageState extends ConsumerState<CreateTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  bool isIncome = false;

  _createRecord() async {
    final Transaction transaction = Transaction.create(
      amount: double.parse(amountController.text),
      description: descriptionController.text.trim(),
      type: !isIncome ? TransactionType.expense : TransactionType.income,
      createdAt: selectedDate!,
    );

    final notifier = ref.read(transactionsProvider.notifier);

    final result = await notifier.create(transaction);

    if (result.type == ResponseType.error) {
      showCustomDialog(
        context,
        title: 'Error!',
        content: 'Couldn\'t create this transaction. Please try again later',
      );
    } else {
      showCustomDialog(
        context,
        title: 'Success!',
        content: 'Transacion created succesfully',
        onOkPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add transaction'),
      ),
      body: Padding(
        padding: screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: descriptionController,
                label: 'Description',
                hint: 'Add a brief description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: amountController,
                label: 'Amount',
                hint: 'Enter the amount',
                textInputType: const TextInputType.numberWithOptions(),
                inputFormatters: [
                  FourDigitsTwoDecimalsFormatter(),
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{0,4}(\.\d{0,2})?$'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is required';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              DatePicker(
                initialDate: selectedDate,
                onDateChanged: (date) {
                  setState(() => selectedDate = date);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date is required';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              TransactionTypeSwitch(
                value: isIncome,
                onChanged: (value) {
                  setState(() => isIncome = value);
                },
              ),
              const Spacer(),
              CustomButton(
                text: 'Save',
                isLoading: ref.watch(transactionsProvider).isLoading,
                onTap: () async {
                  if (!_formKey.currentState!.validate()) return;

                  await _createRecord();
                },
              ),
              const BottomSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionTypeSwitch extends StatelessWidget {
  const TransactionTypeSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Expense',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(width: 8),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(width: 8),
        Text(
          'Income',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
