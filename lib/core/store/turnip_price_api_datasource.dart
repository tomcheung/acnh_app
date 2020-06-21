import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import '../api/acnh_api.dart';
import '../model/turnip_price.dart';
import '../provider/account_provider.dart';
import 'turnip_price_data_source.dart';

class TurnipPriceApiDataSource implements TurnipPriceDataSource {
  final AccountProvider _accountProvider;
  final _priceStream = BehaviorSubject<TurnipPrice>();

  TurnipPriceApiDataSource(this._accountProvider);

  @override
  Stream<TurnipPrice> subscribePrice() {
    request(Method.get, 'v1/turnip', accountProvider: _accountProvider)
        .then((result) {
      if (result.statusCode != 200) {
        return;
      }

      var json = jsonDecode(result.body);
      var price = json['price'].cast<int>();
      _priceStream.add(TurnipPrice.fromList(price));
    });

    return _priceStream.stream;
  }

  @override
  Future<void> updatePrice(TurnipPrice current, Map<int, int> newValue) async {
    final param = newValue
        .map((key, value) => MapEntry(key.toString(), value.toString()));
    final result = await request(Method.patch, 'v1/turnip',
        accountProvider: _accountProvider, body: param);

    var json = jsonDecode(result.body);
    if (json == null && json['updatedValue'] == null) {
      var newPriceInArray = current.toList();
      newValue.forEach((key, value) {
        newPriceInArray[key] = value;
      });

      var newPrice = TurnipPrice.fromList(newPriceInArray);
      _priceStream.add(newPrice);
    }
  }

  @override
  void dispose() {}
}
