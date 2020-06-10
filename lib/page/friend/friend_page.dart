import 'package:acnhpal/core/util/date.dart';
import 'package:acnhpal/page/turnip/prediction/turnip_prediction_page.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:provider/provider.dart';

import '../../acnh_widget/acnh_page.dart';
import '../../acnh_widget/card.dart';
import '../../acnh_widget/price_item.dart';
import '../../core/model/turnip_price.dart';
import '../../core/provider/account_provider.dart';
import '../../generated/l10n.dart';
import 'add_friend_dialog.dart';
import 'friend_price.dart';
import 'friend_provider.dart';

class _FriendItem extends StatelessWidget {
  final FriendPrice friendPrice;
  final bool isEdit;

  _FriendItem(this.friendPrice, {this.isEdit = false});

  _openPredictionPage(BuildContext context) {
    Navigator.of(context).pushNamed('/turnip/prediction',
        arguments: TurnipPredictionArguments(friendPrice.price));
  }

  Widget _buildPrice(BuildContext context, TurnipPrice price) {
    final dailyPrice = price.dailyPrice;
    var row = <Widget>[];
    for (var i = 0; i < dailyPrice.length; i += 2) {
      row.add(
        PriceItem(
          weekday: weekDayString[i ~/ 2],
          morningValue: dailyPrice[i].toString(),
          afternoonValue: dailyPrice[i + 1].toString(),
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openPredictionPage(context),
      child: Wrap(
        direction: Axis.horizontal,
        children: row,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      leftImage: Column(
        children: [
          SizedBox(
            child: Image.asset('images/profile_image_sample.png'),
            width: 55,
          ),
          SizedBox(height: 8),
          Text(friendPrice.friend.playerName),
          if (isEdit)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                var provider = context.read<FriendProvider>();
                provider.removeFriend(friendPrice.friend);
              },
            )
        ],
      ),
      content: <Widget>[_buildPrice(context, friendPrice.price)],
      color: theme.cardColor,
    );
  }
}

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  bool _isEdit = false;

  void _showEditAlert(BuildContext context, FriendProvider friendProvider) {
    showDialog(context: context, child: AddFriendDialog(friendProvider));
  }

  void _toggleEditMode() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final T = S.of(context);
    return ChangeNotifierProvider(
      create: (context) {
        final accountProvider = context.read<AccountProvider>();
        return FriendProvider(accountProvider)..subscribeFriendPrice();
      },
      child: AcnhPage(
        title: T.pageFriends,
        actions: [
          IconButton(
            icon: Icon(_isEdit ? Icons.done : Icons.edit),
            onPressed: _toggleEditMode,
          ),
        ],
        child: Consumer<FriendProvider>(
          builder: (context, provider, child) =>
              StreamBuilder<List<FriendPrice>>(
            stream: provider.priceStream,
            builder: (context, snapshot) {
              if ((snapshot.data?.length ?? 0) == 0) {
                return Text('Your friend list is empty');
              }

              return RefreshIndicator(
                onRefresh: () async {
                  provider.subscribeFriendPrice();
                },
                child: ListView(
                  children: snapshot.data
                      .map((d) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _FriendItem(d, isEdit: _isEdit),
                      ))
                      .toList(),
                ),
              );
            },
          ),
        ),
        floatingActionButton: Consumer<FriendProvider>(
          builder: (ctx, provider, child) {
            return _isEdit
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _showEditAlert(context, provider);
                    })
                : Container();
          },
        ),
      ),
    );
  }
}
