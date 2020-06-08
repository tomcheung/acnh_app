import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/firebase_service.dart';
import '../../core/model/turnip_price.dart';
import '../../core/provider/account_provider.dart';
import '../../core/store/turnip_price_api_datasource.dart';
import '../../core/store/turnip_price_data_source.dart';
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
        _dataSource = kIsWeb
            ? TurnipPriceApiDataSource(accountProvider)
            : TurnipPriceFirebaseDataSource(FirebaseService.instance.db,
                accountProvider.currentUser.userId);

  void beginSubscribe() {
    print('beginSubscribe');
    _sub = _dataSource.subscribePrice().listen((v) {
      print('turnip price $v');
      _lastData = v;
      _priceSteamController.sink.add(v);
    });
  }

  void updateWeekDayPrice(int index, int price) {
    _dataSource.updatePrice(_lastData, {index + 1: price});
  }

  void updatePurchasePrice(int price) async {
    _dataSource.updatePrice(_lastData, {0: price});
  }

  void clearData() async {
    await _dataSource.updatePrice(
        _lastData, TurnipPrice.empty().toList().asMap());
  }

  void dispose() {
    _sub?.cancel();
    _priceSteamController.close();
    _dataSource.dispose();
    print('Price stream closed');
  }
}
