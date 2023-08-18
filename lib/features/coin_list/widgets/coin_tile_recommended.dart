import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/config/routes/router.dart';
import 'package:crypto_ioteam/core/util.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinTileRecommended extends StatelessWidget {
  const CoinTileRecommended({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);

    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.03,
      ),
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(CoinRoute(coin: coin));
        },
        child: Container(
          padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.01,
            left: screenWidth * 0.03,
            right: screenWidth * 0.05,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.035,
                child: Image.network(
                  coin.image,
                ),
              ),
              SizedBox(height: screenHeight * 0.008),
              Text(
                coin.name,
                style: theme.textTheme.labelLarge,
              ),
              SizedBox(height: screenHeight * 0.008),
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
                            : Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
