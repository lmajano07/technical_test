import 'package:flutter/material.dart';
import 'package:transactions_app/core/core.dart';

Future<T?> showCustomBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  double? height,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
    vertical: 28,
    horizontal: horizontalPadding,
  ),
  EdgeInsetsGeometry? margin,
}) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: height,
        width: double.infinity,
        padding: padding,
        margin: margin,
        child: child,
      );
    },
  );
}
