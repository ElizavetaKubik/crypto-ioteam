part of 'coin_details_bloc.dart';

abstract class CoinDetailsState extends Equatable {
  const CoinDetailsState();

  @override
  List<Object> get props => [];
}

final class CoinDetailsInitial extends CoinDetailsState {
  @override
  List<Object> get props => [];
}

final class CoinDetailsLoading extends CoinDetailsState {
  @override
  List<Object> get props => [];
}

final class CoinDetailsLoaded extends CoinDetailsState {
  const CoinDetailsLoaded({required this.chartList});
  final List<ChartModel> chartList;

  @override
  List<Object> get props => [chartList];
}

final class CoinDetailsLoadingFailure extends CoinDetailsState {
  const CoinDetailsLoadingFailure({this.exeption});
  final Object? exeption;

  @override
  List<Object> get props => [exeption!];
}
