import 'dart:async';
import 'package:crypto_ioteam/repository/abstract_coin_repository.dart';
import 'package:crypto_ioteam/repository/models/chart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coin_details_event.dart';
part 'coin_details_state.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  CoinDetailsBloc(this._coinRepository) : super(CoinDetailsInitial()) {
    on<LoadCoinDetails>(_loadCoinChart);
  }

  FutureOr<void> _loadCoinChart(event, emit) async {
    try {
      // if (state is! CoinDetailsLoaded) {
      //   emit(CoinDetailsLoading());
      // }
      emit(CoinDetailsLoading());

      final coinChart =
          await _coinRepository.getCoinChart(event.coinId, event.time);

      emit(CoinDetailsLoaded(chartList: coinChart));
    } catch (e) {
      emit(CoinDetailsLoadingFailure(exeption: e));
    }
  }

  final AbstractCoinRepository _coinRepository;
}
