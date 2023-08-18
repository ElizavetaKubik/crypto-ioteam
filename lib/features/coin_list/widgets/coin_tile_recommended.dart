import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/config/routes/router.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinTileRecommended extends StatelessWidget {
  const CoinTileRecommended({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: appWidth * 0.03, vertical: appHeight * 0.02),
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(CoinRoute(coin: coin));
        },
        child: Container(
          padding: EdgeInsets.only(
            left: appWidth * 0.03,
            right: appWidth * 0.05,
            top: appHeight * 0.02,
            bottom: appHeight * 0.02,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          height: appHeight * 0.03,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: appHeight * 0.035,
                child: Image.network(
                  coin.image,
                ),
              ),
              SizedBox(height: appHeight * 0.02),
              Text(
                coin.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: appHeight * 0.01),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
