import 'dart:math';

import 'package:acnhpal/core/model/turnip_price_prediction.dart';

import '../../../core/util/date.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../acnh_widget/acnh_page.dart';
import '../../../acnh_widget/price_item.dart';
import '../../../core/model/turnip_price.dart';
import '../../../core/price_prediction.dart';
import '../../../generated/l10n.dart';
import 'turnip_prediction_provider.dart';

extension MinMaxWidgetString on MinMax {
  String toWidgetText() => '${this.min} - ${this.max}';
}

class TurnipPredictionArguments {
  final TurnipPrice inputPrice;

  const TurnipPredictionArguments(this.inputPrice);
}

class _TurnipPredictionChart extends StatelessWidget {
  String _mapBottomTitle(double index) {
    return '${weekDayString[index ~/ 2]}\n${amPmString[index.toInt() % 2]}';
  }

  FlLine _getDrawingLine(bool showDash) => FlLine(
    color: Colors.white60,
    strokeWidth: 1,
    dashArray: showDash ? null : [1, 2],
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<TurnipPredictionProvider>();
    final labelColor = Colors.white;
    var minVal = <FlSpot>[];
    var maxVal = <FlSpot>[];
    var currentVal = <FlSpot>[];
    var maxY = 0;

    for (var i=0; i<provider.patternMinMaxRange.length; i++) {
      final range = provider.patternMinMaxRange[i];
      final current = provider.currentPrice.dailyPrice[i].toDouble();
      minVal.add(FlSpot(i.toDouble(), range.min.toDouble()));
      maxVal.add(FlSpot(i.toDouble(), range.max.toDouble()));

      if (current > 0) {
        currentVal.add(FlSpot(i.toDouble(), current));
      }
      maxY = max(maxY, range.max);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xCC448330), Color(0xCC2A531D)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        color: theme.primaryColorLight,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: LineChart(
        LineChartData(
          maxY: ((maxY / 100).ceilToDouble() * 100),
          minY: 0,
          minX: 0,
          maxX: 11,
          gridData: FlGridData(
            show: true,
            horizontalInterval: 25,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (val) => _getDrawingLine(val % 50 == 0),
            getDrawingVerticalLine: (val) => _getDrawingLine(val % 2 == 0),
          ),
          betweenBarsData: [
            BetweenBarsData(
              fromIndex: 0,
              toIndex: 1,
              colors: [theme.primaryColorLight.withAlpha(160)],
            )
          ],
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white),
          ),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: true,
              interval: 50,
              reservedSize: 30,
              textStyle: TextStyle(fontSize: 10, color: labelColor),
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: _mapBottomTitle,
              textStyle: TextStyle(fontSize: 8.5, color: labelColor),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              fitInsideVertically: true,
              tooltipBgColor: Color(0xCC2A531D),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              dotData: FlDotData(show: false),
              isCurved: true,
              spots: minVal,
              colors: [theme.primaryColorLight],
            ),
            LineChartBarData(
              dotData: FlDotData(show: false),
              isCurved: true,
              spots: maxVal,
              colors: [theme.primaryColorLight],
            ),
            LineChartBarData(
              isCurved: true,
              spots: currentVal,
              colors: [Color(0xFFFFF09C)],
            )
          ],
        ),
      ),
    );
  }
}

class TurnipPredictionPage extends StatelessWidget {
  static const routeName = '/turnip/prediction';

  @override
  Widget build(BuildContext context) {
    final T = S.of(context);

    final TurnipPredictionArguments args =
        ModalRoute.of(context).settings.arguments;

    print(args.inputPrice);

    return AcnhPage(
      title: T.turnipPredictPageTitle,
      showDrawer: false,
      child: ListenableProvider(
        create: (content) =>
            TurnipPredictionProvider()..computePrice(args.inputPrice),
        child: Container(
          padding: EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                SizedBox(
                  child: _TurnipPredictionChart(),
                  height: 300,
                ),
                Expanded(child: _TurnipPredictionTable()),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        ),
      ),
    );
  }
}

class _TurnipPredictionTable extends StatelessWidget {
  String mapMinMaxLabel(MinMax minMax) => '${minMax.min} - ${minMax.max}';

  Widget _buildTableRow(TurnipPrediction prediction, BuildContext context) {
    final items = Iterable.generate(weekDayString.length).map(
      (weekDayIndex) {
        final patterns = prediction.pattern;
        return PriceItem(
          weekday: weekDayString[weekDayIndex],
          morningValue: patterns[weekDayIndex * 2].toWidgetText(),
          afternoonValue: patterns[weekDayIndex * 2 + 1].toWidgetText(),
        );
      },
    ).toList();

    return Table(children: [
      TableRow(children: [
        Text(prediction.type.localizedDescription(context)),
        const SizedBox(),
        const SizedBox()
      ]),
      TableRow(children: items.sublist(0, 3)),
      TableRow(children: items.sublist(3))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TurnipPredictionProvider>();
    final items = provider.patterns.map((p) => _buildTableRow(p, context)).toList(growable: false);
    return ListView(
      children: items,
      cacheExtent: 100,
    );
  }
}
