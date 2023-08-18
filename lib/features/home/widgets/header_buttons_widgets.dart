import 'package:flutter/material.dart';

class HeaderButtonsWidget extends StatelessWidget {
  const HeaderButtonsWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.theme,
  });

  final double screenHeight;
  final double screenWidth;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        bottom: screenHeight * 0.005,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.008,
              horizontal: screenWidth * 0.02,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Main Portfolio',
              style: theme.textTheme.labelMedium,
            ),
          ),
          Text(
            'Top 10 coins',
            style: theme.textTheme.labelMedium,
          ),
          Text(
            'Experimental',
            style: theme.textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
