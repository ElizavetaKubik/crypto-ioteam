import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:crypto_ioteam/core/util.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({super.key, required this.coin});
  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);

    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.02,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              coin.image,
              height: screenHeight * 0.05,
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: theme.textTheme.labelLarge,
                ),
                Text(
                  '0.4${coin.symbol}',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            flex: 5,
            child: SizedBox(
              height: screenHeight * 0.05,
              width: screenWidth * 0.1,
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
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$ ${coin.currentPrice}',
                  style: theme.textTheme.labelLarge,
                ),
                Row(
                  children: [
                    Text(
                      coin.priceChange24H.toString().contains('-')
                          ? "-\$${coin.priceChange24H.toStringAsFixed(2).toString().replaceAll('-', '')}"
                          : "\$${coin.priceChange24H.toStringAsFixed(2)}",
                      style: theme.textTheme.labelSmall,
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      '${coin.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                      style: theme.textTheme.labelSmall?.copyWith(
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
