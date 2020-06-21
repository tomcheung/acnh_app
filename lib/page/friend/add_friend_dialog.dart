import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../acnh_widget/alert.dart';
import '../../acnh_widget/raised_button_with_loading.dart';
import '../../core/api/error.dart';
import '../../core/config.dart';
import 'friend_provider.dart';

class AddFriendDialog extends StatefulWidget {
  final FriendProvider friendProvider;

  const AddFriendDialog(this.friendProvider);

  @override
  State<StatefulWidget> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  final _friendCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      Clipboard.getData('text/plain').then((clipboardData) {
        var text = clipboardData.text ?? '';
        var prefixIndex = text.indexOf(env.friendCodePrefix);
        if (prefixIndex != -1) {
          _friendCodeController.text =
              text.substring(prefixIndex + env.friendCodePrefix.length);
        }
      });
    }
  }

  String _validator(String input) {
    if (input.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    try {
      await widget.friendProvider.addFriend(_friendCodeController.text);
    } on ApiError catch (error) {
      showAlertMessage(context, 'Cannot add friend', error.error);
      print('addfrend error: $error}');
    } catch (error) {
      showAlertMessage(context, 'Cannot add friend', 'Unexpected error');
      print('addfrend error: $error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: theme.cardTheme.shape,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 500),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Add Friend', style: theme.textTheme.headline5),
                      CloseButton()
                    ],
                  ),
                ),
                TextFormField(
                  controller: _friendCodeController,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Friend code',
                  ),
                  validator: _validator,
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButtonWithLoading(
                    childBuilder: (context, isLoading) => isLoading
                        ? LoadingMessage()
                        : Text('Submit', style: TextStyle(color: Colors.white)),
                    onProcess: () async {
                      await _submitForm(context);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
