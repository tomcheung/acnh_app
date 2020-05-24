import 'package:firebase_database/firebase_database.dart';
import '../model/turnip_price.dart';

abstract class TurnipPriceDataSource {
  Stream<TurnipPrice> subscribePrice();

  void updatePrice(TurnipPrice newPrice);
}

class TurnipPriceFirebaseDataSource implements TurnipPriceDataSource {
  FirebaseDatabase db;
  String userId;

  TurnipPriceFirebaseDataSource(this.db, this.userId);

  Stream<TurnipPrice> subscribePrice() {
    var priceRef = db.reference().child('usersInfo/$userId/turnipPrices');
    print('subscribe turnip price from firebase with path ${priceRef.path}');
    return priceRef.onValue.map((event) {
      List value = event.snapshot.value;
      if (!(value is List) && value.length == 13) {
        return TurnipPrice.empty();
      }
      return TurnipPrice.fromList(value);

//      var castedList =
//          value.map((v) => v is int ? v : 0).toList(growable: false);

//      return TurnipPrice(castedList[0], castedList.sublist(1));
    });
  }

  void updatePrice(TurnipPrice newPrice) async {
    var priceRef = db.reference().child('usersInfo/$userId');
    var newValue = [newPrice.purchasePrice, ...newPrice.dailyPrice];
    try {
      await priceRef.update({'turnipPrices': newValue});
    } catch (e) {
      print('update error ${e.toString()}');
    }
  }
}
