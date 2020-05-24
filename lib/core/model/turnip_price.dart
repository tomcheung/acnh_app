class TurnipPrice {
  int purchasePrice;
  List<int> dailyPrice = List.filled(12, 0);

  TurnipPrice(this.purchasePrice, this.dailyPrice);

  TurnipPrice.empty() : this(0, List.filled(12, 0));

  TurnipPrice.clone(TurnipPrice from)
      : this(from.purchasePrice, List.from(from.dailyPrice));

  TurnipPrice.fromList(List list) {
    assert(list.length == 13);
    final castedList = list.map((v) => v is int ? v : 0).toList();
    purchasePrice = castedList[0];
    dailyPrice = castedList.sublist(1);
  }

  @override
  String toString() {
    return 'TurnipPrice: ${[purchasePrice, ...dailyPrice]}';
  }
}
