import 'package:intl/intl.dart';

abstract class AppData {
  static const List<String> intervalSymbolList = [
    'D',
    'W',
    'M',
    '3M',
    '6M',
    'Y'
  ];
  static const List<int> intervalDurationList = [1, 7, 30, 90, 180, 365];
  static final List<DateFormat> dataFormatList = [
    DateFormat.Hm(),
    DateFormat.MMMd(),
    DateFormat.MMMd(),
    DateFormat.MMMd(),
    DateFormat.MMM(),
    DateFormat.MMM(),
  ];
}
