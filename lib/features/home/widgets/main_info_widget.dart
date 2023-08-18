import 'package:flutter/material.dart';

class MainInfoWidget extends StatelessWidget {
  const MainInfoWidget({
    super.key,
    required this.screenWidth,
    required this.theme,
    required this.screenHeight,
  });

  final double screenWidth;
  final ThemeData theme;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.07,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ 7.987',
                style: theme.textTheme.displayMedium,
              ),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Container(
                  padding: EdgeInsets.all(
                    screenHeight * 0.01,
                  ),
                  child: Image.asset(
                    'assets/icons/5.1.png',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '+ 167% all time',
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
