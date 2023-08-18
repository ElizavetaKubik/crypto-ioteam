import 'package:crypto_ioteam/repository/models/chart_model.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';

abstract class AbstractCoinRepository {
  Future<List<CoinModel>> getCoinList();

  Future<List<ChartModel>> getCoinChart(String coinId, int time);
}
