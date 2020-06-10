import 'dart:convert';

import 'package:acnhpal/core/api/acnh_api.dart';
import 'package:acnhpal/core/model/friend.dart';
import 'package:acnhpal/core/model/turnip_price.dart';
import 'package:acnhpal/core/provider/account_provider.dart';
import 'package:acnhpal/core/store/friend_price_datasource.dart';
import 'package:acnhpal/page/friend/friend_price.dart';

class FriendPriceApiDatasource implements FriendPriceDatasource {
  final AccountProvider _accountProvider;

  FriendPriceApiDatasource(this._accountProvider);

  @override
  Stream<List<FriendPrice>> subscribeFriendPrice() async* {
    final response = await request(
        Method.get, 'v1/friend', accountProvider: _accountProvider);

    if (response.statusCode != 200) {
      return;
    }

    final json = jsonDecode(response.body);
    final friendJsonArray = json['friends'] as List;

    final result = friendJsonArray.map((f) {
      final priceList = f['turnipPrices'] as List;
      return FriendPrice(
        Friend.fromJson(f),
        TurnipPrice.fromList(priceList.cast<num>()),
      );
    });

    yield result.toList(growable: false);
  }

}