import 'dart:math';

import 'package:flutter/widgets.dart';
import '../../../core/model/turnip_price.dart';
import '../../../core/price_prediction.dart';
import 'package:flutter/foundation.dart';

class TurnipPrediction {
  final int type;
  final List<MinMax<int>> pattern;
  double probability;

  TurnipPrediction(this.type, this.pattern, {this.probability});

  @override
  String toString() =>
      'type: $type, pattern $pattern, probability: $probability';
}

class TurnipPredictionProvider extends ChangeNotifier {
  TurnipPrice currentPrice = TurnipPrice.empty();
  List<TurnipPrediction> patterns = [];
  List<MinMax<int>> patternMinMaxRange = [];

  void computePrice(TurnipPrice price) {
    currentPrice = price;
    const probabilitiesPerPattern = [140, 105, 55, 100];

    final priceFilters = [price.purchasePrice, ...price.dailyPrice];
    var patterns = calculate(priceFilters)
        .map((p) => TurnipPrediction(p.value, p.key))
        .toList(growable: false);

    patterns = _heuristicFilter(price, patterns);

    final countPreType = patterns.fold<Map<int, int>>({0: 0, 1: 0, 2: 0, 3: 0},
        (result, pattern) {
      result[pattern.type] += 1;
      return result;
    });

    final allPatternProb = countPreType.entries.fold(
        0, (result, e) => result + probabilitiesPerPattern[e.key] * e.value);

    for (var p in patterns) {
      p.probability = probabilitiesPerPattern[p.type] /
          allPatternProb /
          countPreType[p.type];
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
