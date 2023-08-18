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
      emit(CoinDetailsLoading());

      final chartList =
          await _coinRepository.getCoinChart(event.coinId, event.time);

      double minVal = _calculateMinVal(chartList);
      double maxVal = _calculateMaxVal(chartList);

      emit(CoinDetailsLoaded(
        chartList: chartList,
        minVal: minVal,
        maxVal: maxVal,
      ));
    } catch (e) {
      emit(CoinDetailsLoadingFailure(exeption: e));
    }
  }

  double _calculateMaxVal(List<ChartModel> chartList) {
    double maxVal = chartList.map((e) => e.high).fold(
        double.negativeInfinity,
        (double current, double? next) =>
            next != null ? (next > current ? next : current) : current);
    return maxVal;
  }

  double _calculateMinVal(List<ChartModel> chartList) {
    double minVal = chartList.map((e) => e.low).fold(
        double.infinity,
        (double current, double? next) =>
            next != null ? (next < current ? next : current) : current);
    return minVal;
  }

  final AbstractCoinRepository _coinRepository;
}
