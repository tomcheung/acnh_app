import 'package:acnhpal/core/model/turnip_price.dart';

abstract class TurnipPriceDataSource {
  Stream<TurnipPrice> subscribePrice();

  Future<void> updatePrice(
      TurnipPrice current, Map<int, int> newValue);

  void dispose() {}
}
