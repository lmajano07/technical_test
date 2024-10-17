import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String format({String format = 'dd/MM/yyyy'}) {
    final dateFormat = DateFormat(format);

    return dateFormat.format(this);
  }
}
