import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:transactions_app/core/core.dart';

import 'package:transactions_app/features/transactions/domain/domain.dart';
import 'package:transactions_app/features/transactions/presentation/presentation.dart';

import 'package:transactions_app/features/shared/shared.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageTransactionPage extends ConsumerStatefulWidget {
  const ManageTransactionPage({super.key, required this.transaction});

  final Transaction transaction;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageTransactionPageState();
}

class _ManageTransactionPageState extends ConsumerState<ManageTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  bool isIncome = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    descriptionController.text = widget.transaction.description;
    amountController.text = widget.transaction.amount.toString();
    selectedDate = widget.transaction.createdAt;
    isIncome = !widget.transaction.type.isExpense();
  }

  _showBottomSheet() {
    final colorScheme = Theme.of(context).colorScheme;

    showCustomBottomSheet(
      context,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() => _isEditing = !_isEditing);
              Navigator.pop(context);
            },
            title: const Text('Edit'),
            leading: const Icon(Icons.edit),
          ),
          const Divider(),
          ListTile(
            onTap: () async {
              Navigator.pop(context);
              await _deleteTransaction();
            },
            title: const Text('Delete'),
            titleTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: colorScheme.error),
            leading: Icon(
              Icons.delete,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  _editTransaction() async {
    final newTransaction = widget.transaction.copyWith(
      amount: double.parse(amountController.text),
      description: descriptionController.text,
      type: !isIncome ? TransactionType.expense : TransactionType.income,
      createdAt: selectedDate!,
    );

    final result =
        await ref.read(transactionsProvider.notifier).update(newTransaction);

    showCustomDialog(
      context,
      title: result.type.toString(),
      content: result.message,
      onOkPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  _deleteTransaction() async {
    final bool confirmAction = await showCustomDialog<bool>(
          context,
          title: 'Are you sure?',
          content: 'This action can\'t be undone',
          showCancel: true,
          onCancelPressed: () => Navigator.pop(context, false),
          okText: 'Delete',
          onOkPressed: () => Navigator.pop(context, true),
        ) ??
        false;

    if (!confirmAction) return;

    final result = await ref
        .read(transactionsProvider.notifier)
        .delete(widget.transaction.id);

    final didDelete = result.type == ResponseType.success;

    showCustomDialog(
      context,
      title: result.type.toString(),
      content: result.message,
      onOkPressed: () {
        if (didDelete) Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
        actions: [
          IconButton(
            onPressed: _showBottomSheet,
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                isEnabled: _isEditing,
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
                isEnabled: _isEditing,
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
                isEnabled: _isEditing,
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
                isEnabled: _isEditing,
                value: isIncome,
                onChanged: (value) {
                  setState(() => isIncome = value);
                },
              ),
              const Spacer(),
              if (_isEditing)
                CustomButton(
                  text: 'Save',
                  isLoading: ref.watch(transactionsProvider).isLoading,
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) return;

                    await _editTransaction();
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
