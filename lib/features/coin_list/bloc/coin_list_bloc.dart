import 'dart:async';
import 'package:crypto_ioteam/repository/abstract_coin_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc(this._coinRepository) : super(CoinListInitial()) {
    on<LoadCoinList>(_loadCoinList);
  }

  final AbstractCoinRepository _coinRepository;

  FutureOr<void> _loadCoinList(event, emit) async {
    try {
      if (state is! CoinListLoaded) {
        emit(CoinListLoading());
      }
      final coinList = await _coinRepository.getCoinList();
      emit(CoinListLoaded(coinList: coinList));
    } catch (e) {
      emit(CoinListLoadingFailure(exeption: e));
    }
  }
}
