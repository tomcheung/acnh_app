import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/api/acnh_api.dart';
import '../../core/api/error.dart';
import '../../core/firebase_service.dart';
import '../../core/model/friend.dart';
import '../../core/provider/account_provider.dart';
import '../../core/store/friend_price_firebase_datasource.dart';
import 'friend_price.dart';

class FriendProvider extends ChangeNotifier {
  final AccountProvider _accountProvider;

  final _dataSource = FriendPriceFirebaseDatasource();
  final _priceStreamController =
      StreamController<List<FriendPrice>>.broadcast();
  StreamSubscription _subscription;

  Stream<List<FriendPrice>> get priceStream => _priceStreamController.stream;

  FriendProvider(this._accountProvider);

  void subscribeFriendPrice() async {
    print('fetching friend price list');

    _subscription?.cancel();
    _subscription = _dataSource.subscribeFriendPrice().listen((data) {
      print('friend price $data');
      _priceStreamController.sink.add(data);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> addFriend(String friendCode) async {
    final idToken = await FirebaseService.instance.getInstanceId();

    if (idToken == null) {
      print('fetchFriends idToken do not exist!');
      return;
    }

    final response = await request(Method.post, 'v1/friend', {'friendCode': friendCode},
        accountProvider: _accountProvider);

    print('idToken: $idToken, userId: ${_accountProvider.currentUser.userId}');

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 1));
      subscribeFriendPrice();
    } else {
      throw ApiError.fromJson(json);
    }
  }

  Future<void> removeFriend(Friend user) async {
    final idToken = await FirebaseService.instance.getInstanceId();

    if (idToken == null) {
      print('fetchFriends error: idToken do not exist!');
      return;
    }

    print('removing friend $user');
    final response = await request(Method.delete, 'v1/friend', {'friendId': user.userId},
        accountProvider: _accountProvider);

    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await Future.delayed(Duration(seconds: 1));
      subscribeFriendPrice();
    } else {
      throw ApiError.fromJson(json);
    }
  }
}
