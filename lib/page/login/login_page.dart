import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../acnh_widget/acnh_page.dart';
import '../../acnh_widget/alert.dart';
import '../../acnh_widget/common_widget.dart';
import '../../acnh_widget/raised_button_with_loading.dart';
import '../../core/api/error.dart';
import '../../core/deeplink/deeplink_data.dart';
import '../../core/model/player.dart';
import '../../core/provider/account_provider.dart';
import '../../generated/l10n.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    if (args is DeeplinkLoginData) {
      args = args as DeeplinkLoginData;
    } else {
      args = null;
    }

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
            child: _LoginForm(deeplinkLoginData: args),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final DeeplinkLoginData deeplinkLoginData;

  _LoginForm({Key key, this.deeplinkLoginData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _textEditControllerMap = <String, TextEditingController>{};
  DeeplinkLoginData _pendingDeeplinkLoginData;
  bool _isExistingUser = false;

  @override
  void initState() {
    _pendingDeeplinkLoginData = widget.deeplinkLoginData;
    super.initState();
  }

  Widget _buildFormField(BuildContext context, String fieldName,
      {TextCapitalization capitalization = TextCapitalization.none}) {
    final T = S.of(context);

    if (_textEditControllerMap[fieldName] == null) {
      _textEditControllerMap[fieldName] = TextEditingController();
    }

    return TextFormField(
      controller: _textEditControllerMap[fieldName],
      textCapitalization: capitalization,
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

  Future<void> _handleSignin(BuildContext context) async {
    final T = S.of(context);
    final provider = context.read<AccountProvider>();

    final user = Player(
        playerName: getFieldValue(T.playerName),
        islandName: getFieldValue(T.islandName),
        pinCode: getFieldValue(T.loginPagePinCode)?.toUpperCase());

    const defaultErrorMessage = 'Signin fail, please try again later';

    try {
      await provider.signin(user);
    } on ApiError catch (err) {
      debugPrint('Login error ${err.error}');
      await showAlertMessage(
        context,
        T.loginPageLoginErrorTitle,
        err.error ?? defaultErrorMessage,
      );
    } on Exception catch (ex) {
      debugPrint('Login with exception ${ex.toString()}');
      await showAlertMessage(context, 'Login fail', defaultErrorMessage);
    }
  }

  _handleDeeplinkData(BuildContext context) {
    final provider = Provider.of<AccountProvider>(context);
    if (_pendingDeeplinkLoginData != null) {
      print('login from deeplink');
      provider.signin(_pendingDeeplinkLoginData.loginInfo);
      _pendingDeeplinkLoginData = null;
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

    _handleDeeplinkData(context);

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
              Flexible(
                child: _buildFormField(
                  context,
                  T.loginPagePinCode,
                  capitalization: TextCapitalization.characters,
                ),
              ),
              HelpIconButton(alertMessage: T.loginPagePinCodeHelpMessage)
            ]),
          RaisedButtonWithLoading(
            childBuilder: (context, isLoading) => isLoading
                ? LoadingMessage()
                : Text(T.loginPageLogin, style: TextStyle(color: Colors.white)),
            onProcess: () async {
              if (_formKey.currentState.validate()) {
                await _handleSignin(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
