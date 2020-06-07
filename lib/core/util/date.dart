import 'package:intl/intl.dart';

final List<String> weekDayString = DateFormat.s()
    .dateSymbols
    .SHORTWEEKDAYS
    .sublist(1)
    .map((w) => w.toUpperCase())
    .toList(growable: false);

final List<String> amPmString = DateFormat.s()
    .dateSymbols
    .AMPMS;