import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../acnh_widget/acnh_page.dart';
import '../../acnh_widget/alert.dart';
import '../../core/model/player.dart';
import '../../core/provider/account_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AcnhPage(
      title: 'Welcome',
      showDrawer: false,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.white54),
          margin: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(400, 500)),
            child: _OnBoardingForm(),
          ),
        ),
      ),
    );
  }
}

class _OnBoardingForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnBoardingFormState();
}

class _OnBoardingFormState extends State<_OnBoardingForm> {
  static const _formFieldIslandName = 'Island Name';
  static const _formFieldPlayerName = 'Name';
  static const _formFieldPinCode = 'Pin code';

  final _formKey = GlobalKey<FormState>();
  final _textEditControllerMap = <String, TextEditingController>{};
  bool _isExistingUser = false;

  Widget _buildFormField(String fieldName, String hintText) {
    if (_textEditControllerMap[fieldName] == null) {
      _textEditControllerMap[fieldName] = TextEditingController();
    }

    return TextFormField(
      controller: _textEditControllerMap[fieldName],
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: hintText,
        labelText: fieldName,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Cannot be blank';
        }
        return null;
      },
    );
  }

  String getFieldValue(String fieldName) {
    return _textEditControllerMap[fieldName]?.text;
  }

  Future<void> _doSignin(BuildContext context) async {
    final provider = context.read<AccountProvider>();

    final user = Player(
        playerName: getFieldValue(_formFieldPlayerName),
        islandName: getFieldValue(_formFieldIslandName),
        pinCode: getFieldValue(_formFieldPinCode)?.toUpperCase());

    //TODO: Use error alert
    try {
      await provider.signin(user);
    } on SigninError catch (err) {
      debugPrint('Sign in error ${err.message}');
      await showAlertMessage(context, 'Signin fail', err.message);
    } on Exception catch (err) {
      debugPrint('Sign in with exception ${err.toString()}');
      await showAlertMessage(
          context, 'Signin fail', 'Signin fail, please try again later');
    }
  }

  @override
  void dispose() {
    for (var c in _textEditControllerMap.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: <Widget>[
          _buildFormField(_formFieldPlayerName, 'What is your name'),
          SizedBox(height: 24),
          _buildFormField(_formFieldIslandName, 'What is your island name'),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Existing user?'),
              Switch(
                  value: _isExistingUser,
                  onChanged: (isOn) {
                    setState(() {
                      _isExistingUser = isOn;
                    });
                  }),
            ],
          ),
          if (_isExistingUser)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildFormField(
                _formFieldPinCode,
                'Pin code for previous account',
              ),
            ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await _doSignin(context);
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
