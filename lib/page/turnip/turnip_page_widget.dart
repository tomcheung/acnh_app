import 'package:flutter/material.dart' hide TextField;

import '../../acnh_widget/text_field.dart';

class ThreeColumnRow extends StatelessWidget {
  final List<Widget> children;

  ThreeColumnRow({Key key, this.children})
      : assert(children.length == 3),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: children[0]),
        Expanded(flex: 1, child: children[1]),
        SizedBox(width: 20),
        Expanded(flex: 1, child: children[2]),
      ],
    );
  }
}

class TurnipTextField extends TextField {
  TurnipTextField({
    final String value,
    final Function(String) onTextChange,
  }) : super(
    value: value,
    type: TextInputType.number,
    borderRadius: BorderRadius.circular(12),
    textAlign: TextAlign.center,
    debounceTime: Duration(milliseconds: 1000),
    onTextChange: onTextChange,
  );
}
