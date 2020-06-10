import 'package:rxdart/rxdart.dart';

import '../../page/friend/friend_price.dart';
import '../firebase_service.dart';
import '../model/friend.dart';
import '../model/pair.dart';
import '../model/turnip_price.dart';
import 'friend_price_datasource.dart';

class FriendPriceFirebaseDatasource implements FriendPriceDatasource {
  final _db = FirebaseService.instance.db;

  Stream<List<FriendPrice>> subscribeFriendPrice() async* {
    final friends = await getFriends();
    yield* _subscribePrice(friends).map((result) {
      return friends
          .map((f) => FriendPrice(f, result[f.userId] ?? TurnipPrice.empty()))
          .toList(growable: false);
    });
  }

  Future<List<Friend>> getFriends() async {
    final user = await FirebaseService.instance.auth.currentUser();
    final friendRef = _db.reference().child('friends/${user.uid}');
    await friendRef.keepSynced(true);
    final result = (await friendRef.once()).value as List;
    print('FriendPriceFirebaseDatasource: getFriends $result}');
    var friends = <Friend>[];

    for (var id in result ?? []) {
      if (id is String) {
        friends.add(await _fetchFriendInfoById(id));
      }
    }

    return friends;
  }

  Future<Friend> _fetchFriendInfoById(String id) async {
    var snapshot = await _db.reference().child('usersInfo/$id').once();
    final friend = Friend.fromJson(Map<String, dynamic>.from(snapshot.value));
    friend?.userId = id;
    return friend;
  }

  Stream<Map<String, TurnipPrice>> _subscribePrice(List<Friend> friends) {
    final priceSteamList = friends.map(_subscribeSinglePrice);

    if (priceSteamList.isEmpty) {
      return Stream.value({});
    }

    return Rx.merge(priceSteamList).scan((last, obj, index) {
      last[obj.key.userId] = obj.value;
      return last;
    }, <String, TurnipPrice>{});
  }

  Stream<Pair<Friend, TurnipPrice>> _subscribeSinglePrice(Friend friend) {
    final childPath = 'usersInfo/${friend.userId}/turnipPrices';
    return _db.reference().child(childPath).onValue.map((e) {
      return Pair(friend, TurnipPrice.fromList(e.snapshot.value));
    });
  }
}
