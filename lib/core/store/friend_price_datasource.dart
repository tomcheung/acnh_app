import 'package:acnhpal/core/provider/account_provider.dart';

import '../../page/friend/friend_price.dart';

abstract class FriendPriceDatasource {
  Stream<List<FriendPrice>> subscribeFriendPrice();
}