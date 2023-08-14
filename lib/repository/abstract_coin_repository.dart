import 'package:crypto_ioteam/repository/models/coin_model.dart';

abstract class AbstractCoinRepository {
  Future<List<CoinModel>> getCoinList();
}
