import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../acnh_widget/acnh_page.dart';
import '../../acnh_widget/alert.dart';
import '../../acnh_widget/common_widget.dart';
import '../../acnh_widget/raised_button_with_loading.dart';
import '../../core/model/player.dart';
import '../../core/provider/account_provider.dart';
import '../../generated/l10n.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final T = S.of(context);
    return AcnhPage(
      title: T.loginPageTitle,
      showDrawer: false,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.white54),
          margin: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(400, 500)),
            child: _LoginForm(),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _textEditControllerMap = <String, TextEditingController>{};
  bool _isExistingUser = false;

  Widget _buildFormField(BuildContext context, String fieldName) {
    final T = S.of(context);

    if (_textEditControllerMap[fieldName] == null) {
      _textEditControllerMap[fieldName] = TextEditingController();
    }

    return TextFormField(
      controller: _textEditControllerMap[fieldName],
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: fieldName,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return T.textFieldValidationEmpty;
        }
        return null;
      },
    );
  }

  String getFieldValue(String fieldName) {
    return _textEditControllerMap[fieldName]?.text;
  }

  Future<void> _doSignin(BuildContext context) async {
    final T = S.of(context);
    final provider = context.read<AccountProvider>();

    final user = Player(
        playerName: getFieldValue(T.playerName),
        islandName: getFieldValue(T.islandName),
        pinCode: getFieldValue(T.loginPagePinCode)?.toUpperCase());

    try {
      await provider.signin(user);
    } on SigninError catch (err) {
      debugPrint('Login error ${err.message}');
      await showAlertMessage(context, T.loginPageLoginErrorTitle, err.message);
    } on Exception catch (err) {
      debugPrint('Login with exception ${err.toString()}');
      await showAlertMessage(
          context, 'Login fail', 'Signin fail, please try again later');
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
    final T = S.of(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: <Widget>[
          _buildFormField(context, T.playerName),
          SizedBox(height: 24),
          _buildFormField(context, T.islandName),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(T.loginPageExistingUser),
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
            Row(mainAxisSize: MainAxisSize.min, children: [
              Flexible(child: _buildFormField(context, T.loginPagePinCode)),
              HelpIconButton(alertMessage: T.loginPagePinCodeHelpMessage)
            ]),
          RaisedButtonWithLoading(
            childBuilder: (context, isLoading) => isLoading
                ? LoadingMessage()
                : Text(T.loginPageLogin, style: TextStyle(color: Colors.white)),
            onProcess: () async {
              if (_formKey.currentState.validate()) {
                await _doSignin(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
