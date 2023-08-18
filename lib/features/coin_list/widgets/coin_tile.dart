import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({super.key, required this.coin});
  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * 0.02,
        vertical: appHeight * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              coin.image,
              height: appHeight * 0.05,
            ),
          ),
          SizedBox(width: appWidth * 0.02),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '0.4${coin.symbol}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: appWidth * 0.02),
          Expanded(
            flex: 5,
            child: SizedBox(
              height: appHeight * 0.05,
              width: appWidth * 0.1,
              child: Sparkline(
                data: coin.sparklineIn7D.price,
                lineWidth: 2.0,
                lineColor: coin.marketCapChangePercentage24H >= 0
                    ? Colors.green
                    : Colors.red,
                fillColor: coin.marketCapChangePercentage24H >= 0
                    ? Colors.green
                    : Colors.red,
                fillMode: FillMode.below,
                fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.7],
                    colors: coin.marketCapChangePercentage24H >= 0
                        ? [Colors.green, Colors.green.shade100]
                        : [Colors.red, Colors.red.shade100]),
              ),
            ),
          ),
          SizedBox(width: appWidth * 0.03),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$ ${coin.currentPrice}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      coin.priceChange24H.toString().contains('-')
                          ? "-\$${coin.priceChange24H.toStringAsFixed(2).toString().replaceAll('-', '')}"
                          : "\$${coin.priceChange24H.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        // color: coin.marketCapChangePercentage24H > 0
                        //     ? Colors.green
                        //     : Colors.red,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: appWidth * 0.03),
                    Text(
                      '${coin.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: coin.marketCapChangePercentage24H > 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
