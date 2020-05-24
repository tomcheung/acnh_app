import 'package:flutter/cupertino.dart';

class TextInputRow {
  final String inputKey;
  final TextDecoration textDecoration;

  TextInputRow({@required this.inputKey, @required this.textDecoration});
}

class TextInputForm extends StatefulWidget {
  final List<TextInputRow> rows;

  TextInputForm(this.rows);

  @override
  State<StatefulWidget> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputForm> {
////  final _formKey = GlobalKey<FormState>();
//  final _textEditControllerMap = <String, TextEditingController>{};
//
//  Widget _buildFormField(String fieldName, String hintText) {
//    if (_textEditControllerMap[fieldName] == null) {
//      _textEditControllerMap[fieldName] = TextEditingController();
//    }
//
//    return TextFormField(
//      controller: _textEditControllerMap[fieldName],
//      decoration: InputDecoration(
//        icon: Icon(Icons.person),
//        hintText: hintText,
//        labelText: fieldName,
//      ),
//      validator: (value) {
//        if (value.isEmpty) {
//          return 'Please enter some text';
//        }
//        return null;
//      },
//    );
//  }
//
//  String getFieldValue(String fieldName) {
//    return _textEditControllerMap[fieldName]?.text;
//  }
//
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}