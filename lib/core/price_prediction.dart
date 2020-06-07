// Port from Turnip-Calculator
// https://github.com/elxris/Turnip-Calculator/blob/4bc81748eaacaffb94f354ecf2062ac532e6758b/wasm/src/patterns.rs

import 'dart:math';
import 'package:equatable/equatable.dart';

import 'model/pair.dart';

class MinMax<T> extends Equatable {
  final T min;
  final T max;

  const MinMax(this.min, this.max);

  @override
  String toString() => "[$min, $max]";

  @override
  List<Object> get props => [min, max];
}

class MinMaxPoint extends Equatable {
  final double min;
  final double max;
  final int plusValue;

  const MinMaxPoint(this.min, this.max, this.plusValue);

  MinMax<int> toMinMax() => MinMax(
        (min + 0.99999).toInt() + plusValue,
        (max + 0.99999).toInt() + plusValue,
      );

  @override
  String toString() => "[$min, $max] + $plusValue";

  @override
  List<Object> get props => [min, max, plusValue];
}

_randFloat(
  List<MinMaxPoint> current,
  double min,
  double max,
  MinMax<int> basePrice,
  int plusValue,
) {
  current.add(
    MinMaxPoint(min * basePrice.min, max * basePrice.max, plusValue),
  );
}

_randFloatRelative(
    List<MinMaxPoint> arr,
    MinMax<double> start,
    MinMax<double> delta,
    int i,
    int filter,
    MinMax<int> basePrice,
    int plusValue) {
  if (i == 0) {
    return _randFloat(arr, start.min, start.max, basePrice, plusValue);
  }

  final verification = MinMax<double>(
    basePrice.min.toDouble() * (start.min + delta.min * i.toDouble()),
    basePrice.max.toDouble() * (start.max + delta.max * i.toDouble()),
  );

  final previousPrice = arr.last;
  double minPrediction(basePrice) =>
      (previousPrice.min / basePrice + delta.min) * basePrice;
  double maxPrediction(basePrice) =>
      (previousPrice.max / basePrice + delta.max) * basePrice;

  final min1 = minPrediction(basePrice.min.toDouble());
  final min2 = minPrediction(basePrice.max.toDouble());
  final max1 = maxPrediction(basePrice.min.toDouble());
  final max2 = maxPrediction(basePrice.max.toDouble());

  final minValue = max(verification.min, min(min1, min2));
  final maxValue = min(verification.max, max(max1, max2));

  if (filter != null) {
    if (filter >= minValue && filter <= maxValue) {
      // If the filter is in range, means that our prediction is healthy
      arr.add(MinMaxPoint(filter - 0.99999, filter.toDouble(), plusValue));
    } else {
      // If is not in range, maybe is not the right pattern.
      arr.add(MinMaxPoint(minValue, maxValue, plusValue));
    }
  } else {
    if (minValue <= maxValue) {
      // This means our prediction is healthy
      arr.add(MinMaxPoint(minValue, maxValue, plusValue));
    } else {
      // If our prediction is not healty, use wide prediction
      arr.add(MinMaxPoint(verification.min, verification.max, plusValue));
    }
  }
}

// PATTERN 0: high, decreasing, high, decreasing, high
List<Pair<List<MinMax<int>>, int>> _pattern0(
    MinMax<int> basePrice, List<int> filters) {
  final probabilties = <Pair<List<MinMax<int>>, int>>[];
  final current = <MinMaxPoint>[];

  for (var decPhaseLen1 in [2, 3]) {
    final decPhaseLen2 = 5 - decPhaseLen1;

    for (var hiPhaseLen1 = 0; hiPhaseLen1 <= 6; hiPhaseLen1++) {
      final hiPhaseLen2And3 = 7 - hiPhaseLen1;

      for (var hiPhaseLen3 = 0; hiPhaseLen3 < hiPhaseLen2And3; hiPhaseLen3++) {
        // high phase 1
        var work = 2;
        for (var i = 0; i < hiPhaseLen1; i++) {
          _randFloat(current, 0.9, 1.4, basePrice, 0);
          work += 1;
        }

        // decreasing phase 1
        for (var i = 0; i < decPhaseLen1; i++) {
          _randFloatRelative(
            current,
            const MinMax<double>(0.6, 0.8),
            const MinMax<double>(-0.1, -0.04),
            i,
            filters[work - 2],
            basePrice,
            0,
          );

          work += 1;
        }

        // high phase 2
        for (var i = 0; i < (hiPhaseLen2And3 - hiPhaseLen3); i++) {
          _randFloat(current, 0.9, 1.4, basePrice, 0);
          work += 1;
        }

        // decreasing phase 2
        for (var i = 0; i < decPhaseLen2; i++) {
          _randFloatRelative(
            current,
            const MinMax<double>(0.6, 0.8),
            const MinMax<double>(-0.1, -0.04),
            i,
            filters[work - 2],
            basePrice,
            0,
          );
          work += 1;
        }

        // high phase 3
        for (var i = 0; i < hiPhaseLen3; i++) {
          _randFloat(current, 0.9, 1.4, basePrice, 0);
          work += 1;
        }

        probabilties.add(
          Pair(current.map((e) => e.toMinMax()).toList(growable: false), 0),
        );

        current.clear();
      }
    }
  }

  return probabilties;
}

// PATTERN 1: decreasing middle, high spike, random low
List<Pair<List<MinMax<int>>, int>> _pattern1(
    MinMax<int> basePrice, List<int> filters) {
  final probabilties = <Pair<List<MinMax<int>>, int>>[];
  final current = <MinMaxPoint>[];

  for (var peakStart = 3; peakStart <= 9; peakStart++) {
    var work = 2;
    for (var _i = work; _i < peakStart; _i++) {
      var i = work - 2;
      _randFloatRelative(
        current,
        const MinMax<double>(0.85, 0.9),
        const MinMax<double>(-0.05, -0.03),
        i,
        filters[work - 2],
        basePrice,
        0,
      );
      work += 1;
    }

    _randFloat(current, 0.9, 1.4, basePrice, 0);
    _randFloat(current, 1.4, 2.0, basePrice, 0);
    _randFloat(current, 2.0, 6.0, basePrice, 0);
    _randFloat(current, 1.4, 2.0, basePrice, 0);
    _randFloat(current, 0.9, 1.4, basePrice, 0);
    work += 5;

    for (; work < 14; work++) {
      _randFloat(current, 0.4, 0.9, basePrice, 0);
    }

    probabilties.add(
      Pair(current.map((e) => e.toMinMax()).toList(growable: false), 1),
    );

    current.clear();
  }

  return probabilties;
}

// PATTERN 2: consistently decreasing
List<Pair<List<MinMax<int>>, int>> _pattern2(
    MinMax<int> basePrice, List<int> filters) {
  final probabilties = <Pair<List<MinMax<int>>, int>>[];
  final current = <MinMaxPoint>[];

  var work = 2;
  for (; work < 14; work++) {
    var i = work - 2;
    _randFloatRelative(
      current,
      MinMax(0.85, 0.9),
      MinMax(-0.05, -0.03),
      i,
      filters[work - 2],
      basePrice,
      0,
    );
  }

  probabilties.add(
    Pair(current.map((e) => e.toMinMax()).toList(growable: false), 2),
  );

  return probabilties;
}

// PATTERN 3: decreasing, spike, decreasing
List<Pair<List<MinMax<int>>, int>> _pattern3(
    MinMax<int> basePrice, List<int> filters) {
  final probabilities = <Pair<List<MinMax<int>>, int>>[];
  final current = <MinMaxPoint>[];

  for (var peakStart = 2; peakStart <= 9; peakStart++) {
    var work = 2;
    for (var j = work; j < peakStart; j++) {
      final i = work - 2;
      _randFloatRelative(
        current,
        MinMax(0.4, 0.9),
        MinMax(-0.05, -0.03),
        i,
        filters[work - 2],
        basePrice,
        0,
      );
      work += 1;
    }

    _randFloat(current, 0.9, 1.4, basePrice, 0);
    _randFloat(current, 0.9, 1.4, basePrice, 0);

    var prevPrice = filters[work + 1];
    if (prevPrice != null) {
      var rate = MinMax<double>(
        prevPrice.toDouble() / basePrice.min.toDouble(),
        prevPrice.toDouble() / basePrice.max.toDouble(),
      );
      var rateMin = min(rate.min, rate.max);
      var rateMax = max(rate.min, rate.max);

      if (rateMin < 1.4 || rateMax > 2.0) {
        _randFloat(current, 1.4, 2.0, basePrice, -1);
        _randFloat(current, 1.4, 2.0, basePrice, 0);
        _randFloat(current, 1.4, 2.0, basePrice, -1);
      } else {
        _randFloat(current, 1.4, rateMax, basePrice, -1);
        _randFloat(current, rateMin, rateMax, basePrice, 0);
        _randFloat(current, 1.4, max(rateMax, 1.4), basePrice, -1);
      }
    } else {
      _randFloat(current, 1.4, 2.0, basePrice, -1);
      _randFloat(current, 1.4, 2.0, basePrice, 0);
      _randFloat(current, 1.4, 2.0, basePrice, -1);
    }

    work += 5;

    var i = 0;
    for (var j = work; j < 14; j++) {
      _randFloatRelative(
        current,
        MinMax(0.4, 0.9),
        MinMax(-0.05, -0.03),
        i,
        filters[work - 2],
        basePrice,
        0,
      );
      i += 1;
      work += 1;
    }

    probabilities.add(
      Pair(current.map((e) => e.toMinMax()).toList(growable: false), 3),
    );
    current.clear();
  }

  return probabilities;
}

List<Pair<List<MinMax<int>>, int>> calculate(List<int> filters) {
  final filtersPadded = List.generate(
      13, (i) => i < filters.length && filters[i] > 0 ? filters[i] : null);
  final minPrice = filtersPadded[0] ?? 90;
  final maxPrice = filtersPadded[0] ?? 110;

  final results = <Pair<List<MinMax<int>>, int>>[];

  final basePrice = MinMax(
    max(min(minPrice, maxPrice), 90),
    min(max(minPrice, maxPrice), 110),
  );

  const patterns = [_pattern0, _pattern1, _pattern2, _pattern3];

  for (final patternFn in patterns) {
    final result = patternFn(basePrice, filtersPadded.sublist(1));
    results.addAll(result);
  }

  return results;
}
