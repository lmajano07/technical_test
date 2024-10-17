import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>(
  BuildContext context, {
  String? title,
  required String content,
  void Function()? onOkPressed,
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
          TextButton(
            onPressed: () {
              if (onOkPressed == null) {
                Navigator.pop(context);
                return;
              }

              onOkPressed();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
