part of 'coin_list_bloc.dart';

@immutable
abstract class CoinListState extends Equatable {}

final class CoinListInitial extends CoinListState {
  @override
  List<Object> get props => [];
}

final class CoinListLoading extends CoinListState {
  @override
  List<Object> get props => [];
}

final class CoinListLoaded extends CoinListState {
  CoinListLoaded({required this.coinList});
  final List<CoinModel> coinList;

  @override
  List<Object?> get props => [coinList];
}

final class CoinListLoadingFailure extends CoinListState {
  CoinListLoadingFailure({this.exeption});
  final Object? exeption;

  @override
  List<Object?> get props => [exeption!];
}
