import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>(
  BuildContext context, {
  String? title,
  required String content,
  String okText = 'Ok',
  void Function()? onOkPressed,
  bool showCancel = false,
  String cancelText = 'Cancel',
  void Function()? onCancelPressed,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title != null) ? Text(title) : null,
        titleTextStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
        content: Text(content),
        contentTextStyle: Theme.of(context).textTheme.bodyMedium!,
        actions: [
          if (showCancel)
            TextButton(
              onPressed: () {
                if (onCancelPressed == null) {
                  Navigator.pop(context);
                  return;
                }

                onCancelPressed();
              },
              child: Text(cancelText),
            ),
          TextButton(
            onPressed: () {
              if (onOkPressed == null) {
                Navigator.pop(context);
                return;
              }

              onOkPressed();
            },
            child: Text(okText),
          ),
        ],
      );
    },
  );
}
