import 'package:crypto_ioteam/repository/abstract_coin_repository.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:dio/dio.dart';

class CoinRepository implements AbstractCoinRepository {
  CoinRepository(this.dio);
  final Dio dio;

  @override
  Future<List<CoinModel>> getCoinList() async {
    final response = await dio.get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true');
    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      return jsonData.map((data) => CoinModel.fromJson(data)).toList();
    } else {
      throw Exception("Error while fetching data");
    }
  }
}
