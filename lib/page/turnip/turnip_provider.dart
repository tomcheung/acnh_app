import 'dart:async';
import '../../core/firebase_service.dart';
import '../../core/model/turnip_price.dart';
import '../../core/provider/account_provider.dart';
import '../../core/store/turnip_price_firebase_datasource.dart';

class TurnipProvider {
  final StreamController<TurnipPrice> _priceSteamController;
  final TurnipPriceDataSource _dataSource;
  TurnipPrice _lastData;

  StreamSubscription _sub;

  Stream<TurnipPrice> get turnipPriceSteam => _priceSteamController.stream;
  TurnipPrice get lastPrice => _lastData;

  TurnipProvider(AccountProvider accountProvider)
      : _priceSteamController = StreamController<TurnipPrice>.broadcast(),
        _dataSource = TurnipPriceFirebaseDataSource(
            FirebaseService.instance.db, accountProvider.currentUser.userId);

  void beginSubscribe() {
    print('beginSubscribe');
    _sub = _dataSource.subscribePrice().listen((v) {
      print('turnip price $v');
      _lastData = v;
      _priceSteamController.sink.add(v);
    });
  }

  void updateWeekDayPrice(int index, int price) {
    var newPrice = TurnipPrice.clone(_lastData);
    newPrice.dailyPrice[index] = price;
    _dataSource.updatePrice(newPrice);
  }

  void updatePurchasePrice(int price) async {
    var newPrice = TurnipPrice.clone(_lastData);
    newPrice.purchasePrice = price;
    _dataSource.updatePrice(newPrice);
  }

  void dispose() {
    _sub?.cancel();
    _priceSteamController.close();
    print('Price stream closed');
  }
}
