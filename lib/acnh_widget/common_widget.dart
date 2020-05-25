import 'package:flutter/material.dart';

import 'alert.dart';

class HelpIconButton extends StatelessWidget {
  final String alertTitle;
  final String alertMessage;

  HelpIconButton({
    Key key,
    this.alertTitle,
    @required this.alertMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(Icons.help_outline),
        onPressed: () {
          showAlertMessage(
            context,
            alertTitle,
            alertMessage,
          );
        },
      );
}
