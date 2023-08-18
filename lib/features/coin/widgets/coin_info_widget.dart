import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinInfoWidget extends StatelessWidget {
  const CoinInfoWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.theme,
    required this.coin,
  });

  final double screenWidth;
  final double screenHeight;
  final ThemeData theme;
  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Low',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text('\$${coin.low24H}', style: theme.textTheme.labelMedium),
            ],
          ),
          Column(
            children: [
              Text(
                'High',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text('\$${coin.high24H}', style: theme.textTheme.labelMedium),
            ],
          ),
          Column(
            children: [
              Text(
                'Vol',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text('\$${coin.totalVolume}M',
                  style: theme.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
