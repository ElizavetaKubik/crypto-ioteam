import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Padding HeaderInfoWidget(
    double screenHeight, double screenWidth, CoinModel coin, ThemeData theme) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: screenHeight * 0.02,
      horizontal: screenWidth * 0.05,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: screenHeight * 0.08,
              child: Image.network(coin.image),
            ),
            SizedBox(width: screenWidth * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: theme.textTheme.labelMedium,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  coin.symbol,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${coin.currentPrice}',
              style: theme.textTheme.labelMedium,
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              '${coin.marketCapChangePercentage24H}%',
              style: theme.textTheme.labelMedium?.copyWith(
                color: coin.marketCapChangePercentage24H > 0
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
