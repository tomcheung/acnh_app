import 'package:flutter/material.dart';

Future<void> showAlertMessage(
    BuildContext context, String title, String message) {
  return showDialog(
    context: context,
    child: AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      actions: <Widget>[
        FlatButton(onPressed: Navigator.of(context).pop, child: Text('OK'))
      ],
    ),
  );
}
