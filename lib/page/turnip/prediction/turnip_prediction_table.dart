import 'dart:math';

import 'package:acnhpal/core/util/date.dart';
import 'package:acnhpal/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/model/model.dart';
import '../../../core/price_prediction.dart';
import '../../../core/util/util.dart';
import 'turnip_prediction_provider.dart';

class _PredictionGroup extends StatelessWidget {
  static const backgroundColors = {
    TurnipPricePattern.decreasing: Color(0xFFEF6E8E),
    TurnipPricePattern.fluctuating: Color(0xFFF09993),
    TurnipPricePattern.smallSpike: Color(0xFFEECC8A),
    TurnipPricePattern.largeSpike: Color(0xFFFFE5AD),
  };

  static final _cachedColor = <int, Color>{};

  final TurnipPricePattern pattern;
  final List<TurnipPrediction> predictions;
  final TurnipPrice inputPrice;

  _PredictionGroup({
    Key key,
    @required this.pattern,
    @required this.predictions,
    @required this.inputPrice,
  }) : super(key: key);

  Color _getTextColor(MinMax<int> value) =>
      _cachedColor.putIfAbsent(value.max, () {
        var hue = value.max.toDouble() * 0.24;
        // hue = value.max / 700 [Max value] * 144 [Hue range 0 - 144, red - green]
        return HSVColor.fromAHSV(1, hue, 0.8, 0.7).toColor();
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final header = weekDayString
        .expand((e) => ['$e ${amPmString[0]}', '$e ${amPmString[1]}'])
        .toList(growable: false);

    final totalProbability =
        predictions.map((e) => e.probability).reduce((s, a) => s + a);

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColors[pattern],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${pattern.localizedDescription(context)}'
            ': ${totalProbability.toPercentageString()}',
            style: theme.textTheme.subtitle2,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(S.of(context).probability),
                  ...List.generate(
                    predictions.length,
                    (i) =>
                        Text(predictions[i].probability.toPercentageString()),
                  ),
                ],
              ),
              ...List.generate(
                predictions.first.pattern.length,
                (c) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0x55FCFFF7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      Text(header[c]),
                      ...List.generate(predictions.length, (i) {
                        final pattern = predictions[i].pattern[c];
                        final enterPrice = inputPrice.dailyPrice[c];
                        return Text(
                          enterPrice > 0
                              ? enterPrice.toString()
                              : '${pattern.min} - ${pattern.max}',
                          style: TextStyle(
                            color: enterPrice > 0
                                ? Colors.black
                                : _getTextColor(pattern),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TurnipPredictionTable extends StatelessWidget {
  String mapMinMaxLabel(MinMax minMax) => '${minMax.min} - ${minMax.max}';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TurnipPredictionProvider>();
    final predictions = provider.patterns;

    var predictionsByType = <TurnipPricePattern, List<TurnipPrediction>>{};

    for (final p in predictions) {
      if (!predictionsByType.containsKey(p.type)) {
        predictionsByType[p.type] = <TurnipPrediction>[];
      }
      predictionsByType[p.type].add(p);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: predictionsByType.entries
              .map((e) => _PredictionGroup(
                    pattern: e.key,
                    predictions: e.value,
                    inputPrice: provider.currentPrice,
                  ))
              .toList(growable: false),
        ),
      ),
    );
  }
}
