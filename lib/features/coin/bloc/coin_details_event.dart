part of 'coin_details_bloc.dart';

abstract class CoinDetailsEvent extends Equatable {
  const CoinDetailsEvent();
}

final class LoadCoinDetails extends CoinDetailsEvent {
  const LoadCoinDetails({required this.coinId, required this.time});
  final String coinId;
  final int time;

  @override
  List<Object> get props => [];
}
