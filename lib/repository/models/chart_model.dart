import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ChartModel extends Equatable {
  ChartModel({
    required this.time,
    this.open,
    this.high,
    this.low,
    this.close,
  });

  DateTime time;
  double? open;
  double? high;
  double? low;
  double? close;

  factory ChartModel.fromJson(List list) {
    return ChartModel(
      time: DateTime.fromMillisecondsSinceEpoch(list[0]),
      open: list[1],
      high: list[2],
      low: list[3],
      close: list[4],
    );
  }

  @override
  List<Object?> get props => [time, open, high, low, close];
}
