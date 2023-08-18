import 'package:crypto_ioteam/features/coin/bloc/coin_details_bloc.dart';
import 'package:crypto_ioteam/features/coin_list/bloc/coin_list_bloc.dart';
import 'package:crypto_ioteam/repository/abstract_coin_repository.dart';
import 'package:crypto_ioteam/repository/coin_list_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<AbstractCoinRepository>(CoinRepository(sl()));

  sl.registerFactory<CoinListBloc>(() => CoinListBloc(sl()));
  sl.registerFactory<CoinDetailsBloc>(() => CoinDetailsBloc(sl()));
}
