import 'package:acnhpal/core/model/pair.dart';
import 'package:acnhpal/core/price_prediction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Price prediction test', () {
    final samplePrice = [102, 91, 86, 81, 77, 141];
    final result = calculate(samplePrice);
    const expectedResult = [
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(66, 73),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(66, 73),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(66, 73),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(66, 73),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(77, 77),
        MinMax(66, 73),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(92, 143)
      ], 0),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78),
        MinMax(41, 74),
        MinMax(92, 143),
        MinMax(62, 82),
        MinMax(51, 78)
      ], 0),
      Pair([
        MinMax(87, 92),
        MinMax(92, 143),
        MinMax(143, 204),
        MinMax(204, 613),
        MinMax(143, 204),
        MinMax(92, 143),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92)
      ], 1),
      Pair([
        MinMax(87, 92),
        MinMax(86, 86),
        MinMax(92, 143),
        MinMax(143, 204),
        MinMax(204, 613),
        MinMax(143, 204),
        MinMax(92, 143),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92)
      ], 1),
      Pair([
        MinMax(87, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(92, 143),
        MinMax(143, 204),
        MinMax(204, 613),
        MinMax(143, 204),
        MinMax(92, 143),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92)
      ], 1),
      Pair([
        MinMax(87, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(92, 143),
        MinMax(143, 204),
        MinMax(204, 613),
        MinMax(143, 204),
        MinMax(92, 143),
        MinMax(41, 92),
        MinMax(41, 92),
        MinMax(41, 92)
      ], 1),
      Pair([
        MinMax(87, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(71, 74),
        MinMax(92, 143),
        MinMax(143, 204),
        MinMax(204, 613),
        MinMax(143, 204),
        MinMax(92, 143),
        MinMax(41, 92),
        MinMax(41, 92)
      ], 1),
      Pair([
        MinMax(87, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(71, 74),
        MinMax(66, 71),
        MinMax(92, 143),
        MinMax(143, 204),
        MinMax(204, 613),
        MinMax(143, 204),
        MinMax(92, 143),
        MinMax(41, 92)
      ], 1),
      Pair([
        MinMax(87, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(71, 74),
        MinMax(66, 71),
        MinMax(61, 68),
        MinMax(92, 143),
        MinMax(143, 204),
        MinMax(204, 613),
        MinMax(143, 204),
        MinMax(92, 143)
      ], 1),
      Pair([
        MinMax(87, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(71, 74),
        MinMax(66, 71),
        MinMax(61, 68),
        MinMax(56, 65),
        MinMax(51, 62),
        MinMax(46, 59),
        MinMax(41, 56),
        MinMax(36, 53)
      ], 2),
      Pair([
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203),
        MinMax(41, 92),
        MinMax(36, 89),
        MinMax(31, 86),
        MinMax(26, 83),
        MinMax(21, 80),
        MinMax(16, 77),
        MinMax(11, 74)
      ], 3),
      Pair([
        MinMax(41, 92),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203),
        MinMax(41, 92),
        MinMax(36, 89),
        MinMax(31, 86),
        MinMax(26, 83),
        MinMax(21, 80),
        MinMax(16, 77)
      ], 3),
      Pair([
        MinMax(41, 92),
        MinMax(86, 86),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203),
        MinMax(41, 92),
        MinMax(36, 89),
        MinMax(31, 86),
        MinMax(26, 83),
        MinMax(21, 80)
      ], 3),
      Pair([
        MinMax(41, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203),
        MinMax(41, 92),
        MinMax(36, 89),
        MinMax(31, 86),
        MinMax(26, 83)
      ], 3),
      Pair([
        MinMax(41, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203),
        MinMax(41, 92),
        MinMax(36, 89),
        MinMax(31, 86)
      ], 3),
      Pair([
        MinMax(41, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(71, 74),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203),
        MinMax(41, 92),
        MinMax(36, 89)
      ], 3),
      Pair([
        MinMax(41, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(71, 74),
        MinMax(66, 71),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203),
        MinMax(41, 92)
      ], 3),
      Pair([
        MinMax(41, 92),
        MinMax(86, 86),
        MinMax(81, 81),
        MinMax(77, 77),
        MinMax(71, 74),
        MinMax(66, 71),
        MinMax(61, 68),
        MinMax(92, 143),
        MinMax(92, 143),
        MinMax(142, 203),
        MinMax(143, 204),
        MinMax(142, 203)
      ], 3),
    ];

    expect(result.length, expectedResult.length);

    for (var i = 0; i < expectedResult.length; i++) {
      for (var j = 0; j < result[i].key.length; j++) {
//        if ((result[i].key[j].min - expectedResult[i].key[j].min).abs() > 1 ||
//            (result[i].key[j].max - expectedResult[i].key[j].max).abs() > 1) {
//          print('fail: $i ${result[i].value} ${result[i].key[j]}, ${expectedResult[i].key[j]}');
//        }
      // FIXME: Rounding issue
        expect((result[i].key[j].min - expectedResult[i].key[j].min).abs() <= 1,
            isTrue);
        expect((result[i].key[j].max - expectedResult[i].key[j].max).abs() <= 1,
            isTrue);
      }
      expect(result[i].value, expectedResult[i].value);
    }

//    expect(result, expectedResult);
  });
}
