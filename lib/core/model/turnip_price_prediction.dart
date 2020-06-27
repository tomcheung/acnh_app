import 'package:flutter/widgets.dart';

import '../../generated/l10n.dart';
import '../price_prediction.dart';

enum TurnipPricePattern {
  fluctuating,
  smallSpike,
  largeSpike,
  decreasing,
}

extension TurnipPricePatternExtension on TurnipPricePattern {
  String localizedDescription(BuildContext context) {
    final T = S.of(context);
    switch (this) {
      case TurnipPricePattern.fluctuating:
        return T.fluctuating;
      case TurnipPricePattern.smallSpike:
        return T.smallSpike;
      case TurnipPricePattern.largeSpike:
        return T.largeSpike;
      case TurnipPricePattern.decreasing:
        return T.decreasing;
      default:
        return '';
    }
  }
}

class TurnipPrediction {
  final TurnipPricePattern type;
  final List<MinMax<int>> pattern;
  double probability;

  TurnipPrediction(this.type, this.pattern, {this.probability});

  @override
  String toString() =>
      'type: $type, pattern $pattern, probability: $probability';
}