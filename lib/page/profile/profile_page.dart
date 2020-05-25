import 'package:acnhpal/acnh_widget/common_widget.dart';
import 'package:acnhpal/generated/l10n.dart';
import 'package:flutter/material.dart' hide TextField, Card;
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../acnh_widget/acnh_page.dart';
import '../../acnh_widget/alert.dart';
import '../../acnh_widget/card.dart';
import '../../acnh_widget/text_field.dart';
import '../../core/provider/account_provider.dart';
import 'profile_state.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final T = S.of(context);

    final accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    final currentUser = accountProvider.currentUser;

    return ListenableProvider(
      create: (_) => ProfilePageState(
        playerName: currentUser.playerName,
        islandName: currentUser.islandName,
      ),
      child: AcnhPage(
        title: T.pageProfile,
//        floatingActionButton: Consumer<ProfilePageState>(
//          builder: (context, state, child) => FloatingActionButton(
//            child: Icon(state.isEdit ? Icons.done : Icons.edit),
//            onPressed: () {
//              state.toggleEditMode();
//            },
//          ),
//        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.scaleDown,
              image: AssetImage('images/bg1.png'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: Column(
            children: <Widget>[
              _ProfilePassportCard(isEdit: false),
              RaisedButton(
                child: Text(
                  T.profileLogout,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await accountProvider.signOut();
                  Navigator.popAndPushNamed(context, '/');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String fieldName;
  final String value;
  final bool isEdit;
  final TextStyle style;
  final void Function(String) onTextChange;
  final ValueKey _textFieldKey;

  _ProfileField(this.fieldName, this.value,
      {this.isEdit = false, this.style, this.onTextChange})
      : _textFieldKey = ValueKey(fieldName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: isEdit
          ? TextField(
              key: _textFieldKey,
              placeholderText: fieldName,
              value: value,
              onTextChange: onTextChange,
            )
          : Text(value, style: style, key: _textFieldKey),
    );
  }
}

class _ProfilePassportCard extends StatelessWidget {
  final bool isEdit;

  const _ProfilePassportCard({Key key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    final T = S.of(context);
    final theme = Theme.of(context);
    final state = context.watch<ProfilePageState>();
    final isEdit = state.isEdit;

    return Card(
      leftImage: Image.asset('images/profile_image_sample.png'),
      content: <Widget>[
        _ProfileField(
          'Name',
          state.playerName,
          style: theme.textTheme.headline5,
          isEdit: isEdit,
          onTextChange: (v) => state.playerName = v,
        ),
        _ProfileField(
          'Island name',
          state.islandName,
          style: theme.textTheme.subtitle1,
          isEdit: isEdit,
          onTextChange: (v) => state.islandName = v,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Consumer<AccountProvider>(
            builder: (context, account, child) => Row(
              children: [
                Text(
                  'PIN Code: ${account.currentUser?.pinCode ?? ''}',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodyText2.color,
                  ),
                ),
                HelpIconButton(
                  alertTitle: T.loginPagePinCode,
                  alertMessage: T.profilePinCodeDescription,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
