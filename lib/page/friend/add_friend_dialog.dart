import 'package:flutter/material.dart';

import '../../acnh_widget/alert.dart';
import '../../core/api/error.dart';
import '../../core/model/friend.dart';
import 'friend_provider.dart';

class AddFriendDialog extends StatefulWidget {
  final FriendProvider friendProvider;

  const AddFriendDialog(this.friendProvider);

  @override
  State<StatefulWidget> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  final _friendNameController = TextEditingController();
  final _friendIslandNameController = TextEditingController();
  final _friendPinCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  String _validator(String input) {
    if (input.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

  void _submitForm(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final friend = Friend(
      playerName: _friendNameController.text,
      islandName: _friendIslandNameController.text,
      pinCode: _friendPinCodeController.text.toUpperCase(),
    );

    setState(() {
      _loading = true;
    });

    widget.friendProvider
        .addFriend(friend)
        .then((value) => Navigator.pop(context), onError: (error) {
      if (error is ApiError) {
        showAlertMessage(context, 'Cannot add friend', error.error);
      } else {
        showAlertMessage(context, 'Cannot add friend', 'Unexpected error');
      }
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build alert');
    final theme = Theme.of(context);
    return Dialog(
      shape: theme.cardTheme.shape,
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
                controller: _friendNameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Friend Name',
                ),
                validator: _validator,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _friendIslandNameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Friend Island Name',
                ),
                validator: _validator,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _friendPinCodeController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_open),
                  labelText: 'Friend Pin Code',
                ),
                validator: _validator,
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: _loading
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            child: CircularProgressIndicator(strokeWidth: 2,),
                            height: 18,
                            width: 18,
                          ),
                          SizedBox(width: 8),
                          Text('Loading...'),
                        ],
                      ),
                    )
                    : RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => _submitForm(context),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
