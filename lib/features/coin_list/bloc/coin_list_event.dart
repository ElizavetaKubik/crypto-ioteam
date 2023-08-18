part of 'coin_list_bloc.dart';

@immutable
abstract class CoinListEvent extends Equatable {}

class LoadCoinList extends CoinListEvent {
  @override
  List<Object> get props => [];
}
