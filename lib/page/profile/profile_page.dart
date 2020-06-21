import 'package:flutter/material.dart' hide TextField, Card;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../acnh_widget/acnh_page.dart';
import '../../acnh_widget/alert.dart';
import '../../acnh_widget/card.dart';
import '../../acnh_widget/common_widget.dart';
import '../../acnh_widget/text_field.dart';
import '../../core/config.dart';
import '../../core/deeplink/deeplink_data.dart';
import '../../core/provider/account_provider.dart';
import '../../generated/l10n.dart';
import 'profile_state.dart';

enum _ProfilePageMoreOptions { saveProfile }

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  _showUserToken(BuildContext context) {
    final currentUser = context.read<AccountProvider>().currentUser;
    final data = DeeplinkLoginData(currentUser);
    final link =
        '${env.universalLinkHost}/login?token=${data.toBase64String()}';
    Clipboard.setData(ClipboardData(text: link));
    showAlertMessage(context, S.of(context).magicLinkCopiedTitle, null);
  }

  _handleMoreMenu(BuildContext context, _ProfilePageMoreOptions option) {
    switch (option) {
      case _ProfilePageMoreOptions.saveProfile:
        _showUserToken(context);
        return;
    }
  }

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
        actions: [
          PopupMenuButton<_ProfilePageMoreOptions>(
            onSelected: (option) => _handleMoreMenu(context, option),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _ProfilePageMoreOptions.saveProfile,
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(T.copyLoginMagicLink),
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
              )
            ],
          )
        ],
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

  _copyFriendLink(BuildContext context) async {
    final user = context.read<AccountProvider>().currentUser;
    final link =
        '${env.universalLinkHost}/friend?friend_id=ANH-${user.friendCode.toUpperCase()}';
    await Clipboard.setData(ClipboardData(text: link));
    showAlertMessage(context, 'Friend code copied', null);
  }

  @override
  Widget build(BuildContext context) {
    final T = S.of(context);
    final theme = Theme.of(context);
    final state = context.watch<ProfilePageState>();
    final isEdit = state.isEdit;
    final user = context.watch<AccountProvider>().currentUser;
    final smallTextStyle = TextStyle(
      fontSize: 12,
      color: theme.textTheme.bodyText2.color,
    );

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
        Row(
          children: [
            Text(
              'PIN Code: ${user?.pinCode ?? ''}',
              style: smallTextStyle,
            ),
            HelpIconButton(
              alertTitle: T.loginPagePinCode,
              alertMessage: T.profilePinCodeDescription,
            )
          ],
        ),
        if (user?.friendCode?.isNotEmpty ?? false) ...[
          Text('Friend code'),
          Row(
            children: [
              Flexible(
                child: Text(
                  '${env.friendCodePrefix}${user.friendCode.toUpperCase()}',
                  style: smallTextStyle,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                iconSize: 16,
                icon: Icon(Icons.content_copy),
                onPressed: () async {
                  await _copyFriendLink(context);
                },
              )
            ],
          )
        ],
      ],
    );
  }
}
