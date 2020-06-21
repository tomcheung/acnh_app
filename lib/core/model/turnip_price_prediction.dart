import 'package:flutter/widgets.dart';

import '../../generated/l10n.dart';

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