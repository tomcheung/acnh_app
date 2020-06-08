import 'package:firebase_database/firebase_database.dart';
import '../model/turnip_price.dart';
import 'turnip_price_data_source.dart';

class TurnipPriceFirebaseDataSource extends TurnipPriceDataSource {
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
    });
  }

  Future<void> updatePrice(TurnipPrice current, Map<int, int> newValue) async {
    var priceRef = db.reference().child('usersInfo/$userId/turnipPrices');
    try {
      await priceRef.update(
          newValue.map((key, value) => MapEntry(key.toString(), value)));
    } catch (e) {
      print('update error ${e.toString()}');
    }
  }
}
