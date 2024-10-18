import 'package:flutter/material.dart';
import 'package:transactions_app/features/shared/shared.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.initialDate,
    this.validator,
    required this.onDateChanged,
  });

  final DateTime? initialDate;
  final String? Function(String?)? validator;
  final void Function(DateTime) onDateChanged;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialDate != null) {}
  }

  setDateText(DateTime date) => controller.text = date.format();

  @override
  Widget build(BuildContext context) {
    selectDate() async {
      final newDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        initialDate: widget.initialDate,
      );

      if (newDate == null) return;

      setDateText(newDate);

      widget.onDateChanged(newDate);
    }

    return GestureDetector(
      onTap: selectDate,
      child: TextFormField(
        controller: controller,
        validator: widget.validator,
        enabled: false,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: 'Date',
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          hintText: 'Select a date',
          border: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
    );
  }
}
