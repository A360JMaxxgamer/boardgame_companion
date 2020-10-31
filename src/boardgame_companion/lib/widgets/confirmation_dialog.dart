import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirmed;

  const ConfirmationDialog(
      {Key key, @required this.message, @required this.onConfirmed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            onConfirmed.call();
            Navigator.of(context).pop();
          },
        ),
      ],
      content: Text(message),
    );
  }
}
