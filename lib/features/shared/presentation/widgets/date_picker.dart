import 'package:flutter/material.dart';
import 'package:transactions_app/features/shared/shared.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.initialDate,
    this.validator,
    required this.onDateChanged,
    this.isEnabled = true,
  });

  final DateTime? initialDate;
  final String? Function(String?)? validator;
  final void Function(DateTime) onDateChanged;
  final bool isEnabled;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialDate != null) {
      setDateText(widget.initialDate!);
    }
  }

  setDateText(DateTime date) => controller.text = date.format();

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
    );

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
      onTap: () {
        if (widget.isEnabled) selectDate();
      },
      child: TextFormField(
        controller: controller,
        validator: widget.validator,
        enabled: false,
        style:
            (widget.isEnabled) ? Theme.of(context).textTheme.bodyLarge : null,
        decoration: InputDecoration(
          labelText: 'Date',
          labelStyle:
              (widget.isEnabled) ? Theme.of(context).textTheme.bodyLarge : null,
          hintText: 'Select a date',
          border: border,
          focusedBorder: border,
          disabledBorder: (widget.isEnabled) ? border : null,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
    );
  }
}
