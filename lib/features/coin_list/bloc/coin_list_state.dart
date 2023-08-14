part of 'coin_list_bloc.dart';

@immutable
abstract class CoinListState {}

final class CoinListInitial extends CoinListState {}

final class CoinListLoading extends CoinListState {}

final class CoinListLoaded extends CoinListState {
  CoinListLoaded({required this.coinList});
  final List<CoinModel> coinList;
}

final class CoinListLoadingFailure extends CoinListState {
  CoinListLoadingFailure({this.exeption});
  final Object? exeption;
}
