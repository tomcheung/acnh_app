import 'package:flutter/material.dart' hide TextField;
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../acnh_widget/acnh_page.dart';
import '../../core/provider/account_provider.dart';
import 'turnip_page_widget.dart';
import 'turnip_provider.dart';

class _PurchasePriceRow extends StatelessWidget {
  _PurchasePriceRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final turnipProvider = context.watch<TurnipProvider>();
    final theme = Theme.of(context);
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Text(
        'Purchase Price',
        style: theme.primaryTextTheme.subtitle2,
      ),
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: StreamProvider(
            create: (_) =>
                turnipProvider.turnipPriceSteam.map((p) => p.purchasePrice),
            child: Consumer<int>(
              builder: (context, value, child) => TurnipTextField(
                value: value?.toString(),
                onTextChange: (t) {
                  turnipProvider.updatePurchasePrice(int.tryParse(t) ?? 0);
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _TurnipInputRow extends StatelessWidget {
  final String rowTitle;
  final int weekDay; // 0 = Monday

  _TurnipInputRow(
    this.rowTitle, {
    @required this.weekDay,
  });

  void _onInputChange(BuildContext context, String newValue, int offset) {
    final provider = context.read<TurnipProvider>();

    provider.updateWeekDayPrice(
      weekDay * 2 + offset,
      int.tryParse(newValue) ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final turnipProvider = context.watch<TurnipProvider>();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: StreamProvider<List<int>>(
          create: (context) {
            return turnipProvider.turnipPriceSteam.map(
              (p) => [
                p.dailyPrice[weekDay * 2],
                p.dailyPrice[weekDay * 2 + 1],
              ],
            );
          },
          initialData: [0, 0],
          updateShouldNotify: (prev, next) {
            return prev[0] != next[0] || prev[1] != next[1];
          },
          child: Consumer<List<int>>(
            builder: (context, value, _) {
              return ThreeColumnRow(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: theme.colorScheme.primary.withAlpha(100),
                    ),
                    child: Text(
                      rowTitle,
                      style: theme.primaryTextTheme.subtitle2,
                    ),
                  ),
                  TurnipTextField(
                    value: value[0].toString(),
                    onTextChange: (t) => _onInputChange(context, t, 0),
                  ),
                  TurnipTextField(
                    value: value[1].toString(),
                    onTextChange: (t) => _onInputChange(context, t, 1),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TurnipInputForm extends StatelessWidget {
  static final DateSymbols _dateSymbols = DateFormat.yMd().dateSymbols;
  final _weekDays = _dateSymbols.WEEKDAYS.sublist(1);

  _TurnipInputForm();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var items = <Widget>[];
    for (var i = 0; i < _weekDays.length; i++) {
      items.add(_TurnipInputRow(
        _weekDays[i],
        weekDay: i,
      ));
    }

    return ListView(children: [
      _PurchasePriceRow(),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ThreeColumnRow(
          children: [
            Container(),
            Icon(Icons.brightness_7, color: theme.primaryColorDark),
            Icon(Icons.brightness_3, color: theme.primaryColorDark)
          ],
        ),
      ),
      ...items,
    ]);
  }
}

class TurnipHomePage extends StatelessWidget {
  static const String title = 'Home';

  @override
  Widget build(BuildContext context) {
    return Provider<TurnipProvider>(
      create: (context) {
        final accountProvider = context.read<AccountProvider>();
        return TurnipProvider(accountProvider)..beginSubscribe();
      },
      dispose: (context, provider) => provider.dispose(),
      child: AcnhPage(
        title: title,
        child: Container(
          padding: EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: _TurnipInputForm(),
          ),
        ),
      ),
    );
  }
}
