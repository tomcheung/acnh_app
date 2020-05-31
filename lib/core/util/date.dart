import 'package:intl/intl.dart';

final weekDayString = DateFormat.s()
    .dateSymbols
    .SHORTWEEKDAYS
    .sublist(1)
    .map((w) => w.toUpperCase())
    .toList(growable: false);

final amPmString = DateFormat.s()
    .dateSymbols
    .AMPMS;