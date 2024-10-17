import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.textInputType,
    this.inputFormatters,
  });

  final String label, hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.textInputType,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
