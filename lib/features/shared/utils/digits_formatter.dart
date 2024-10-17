import 'package:flutter/services.dart';

class FourDigitsTwoDecimalsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp regExp = RegExp(r'^\d{0,4}(\.\d{0,2})?$');

    if (regExp.hasMatch(newValue.text)) return newValue;

    return oldValue;
  }
}
