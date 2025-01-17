import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../core/model/model.dart';
import '../../../core/price_prediction.dart';

class TurnipPredictionProvider extends ChangeNotifier {
  TurnipPrice currentPrice = TurnipPrice.empty();
  List<TurnipPrediction> patterns = [];
  List<MinMax<int>> patternMinMaxRange = [];

  void computePrice(TurnipPrice price) {
    currentPrice = price;
    const patternProbabilities = {
      TurnipPricePattern.fluctuating: 140,
      TurnipPricePattern.largeSpike: 105,
      TurnipPricePattern.decreasing: 55,
      TurnipPricePattern.smallSpike: 100
    };

    final priceFilters = [price.purchasePrice, ...price.dailyPrice];
    var patterns = calculate(priceFilters)
        .map((p) => TurnipPrediction(p.value, p.key))
        .toList(growable: false);

    patterns = _heuristicFilter(price, patterns);

    final countPreType = patterns.fold<Map<TurnipPricePattern, int>>(
      Map.fromIterable(TurnipPricePattern.values, value: (_) => 0),
      (result, pattern) {
        result[pattern.type] += 1;
        return result;
      },
    );

    final allPatternProb = countPreType.entries.fold(
        0,
        (prev, pattern) => pattern.value > 0
            ? prev + patternProbabilities[pattern.key]
            : prev);

    for (var p in patterns) {
      p.probability =
          patternProbabilities[p.type] / allPatternProb / countPreType[p.type];
    }

    this.patterns = patterns;
    _computeMinMaxRange();
    notifyListeners();
  }

  _computeMinMaxRange() {
    List<MinMax<int>> minMaxReducer(
        List<MinMax<int>> result, TurnipPrediction element) {
      return result.asMap().entries.map((e) {
        final lastVal = e.value;
        final currentVal = element.pattern[e.key];
        return MinMax(
            min(lastVal.min, currentVal.min), max(lastVal.max, currentVal.max));
      }).toList();
    }

    patternMinMaxRange =
        patterns.fold(List.filled(12, MinMax(999, 0)), minMaxReducer);
  }

  List<TurnipPrediction> _heuristicFilter(
      TurnipPrice inputPrice, List<TurnipPrediction> patterns) {
    final scoreMap = Map<TurnipPrediction, int>.fromEntries(
        patterns.map((p) => MapEntry(p, _calculateScore(inputPrice, p))));

    patterns.sort((a, b) => scoreMap[a] - scoreMap[b]);
    final filterThreshold = scoreMap[patterns[0]] * 1.1;
    return patterns
        .where((p) => scoreMap[p] <= filterThreshold)
        .toList(growable: false);
  }

  int _calculateScore(
    TurnipPrice inputPrice,
    TurnipPrediction predictionPattern,
  ) {
    var totalScore = 0;
    var pattern = predictionPattern.pattern;

    for (var i = 0; i < pattern.length; i++) {
      final filterPrice = inputPrice.dailyPrice[i];
      if (filterPrice == null || filterPrice <= 0) {
        continue;
      }

      if (filterPrice < pattern[i].min) {
        totalScore += pattern[i].min - filterPrice;
      } else if (filterPrice > pattern[i].max) {
        totalScore += filterPrice - pattern[i].max;
      }
    }

    return totalScore;
  }
}
