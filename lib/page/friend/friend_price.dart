import '../../core/model/friend.dart';
import '../../core/model/turnip_price.dart';

class FriendPrice {
  final Friend friend;
  final TurnipPrice price;

  FriendPrice(this.friend, this.price);

  @override
  String toString() => '${friend.userId}: $price';
}
