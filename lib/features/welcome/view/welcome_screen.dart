import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/config/routes/router.dart';
import 'package:crypto_ioteam/core/constants/colors.dart';
import 'package:crypto_ioteam/core/util.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/welcome.gif',
                height: screenHeight * 0.5,
                width: screenHeight * 0.5,
              ),
              Column(
                children: [
                  Text(
                    'Future',
                    style: theme.textTheme.displayLarge,
                  ),
                  Text(
                    'Learn more about cryptocurrency, look to',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  Text(
                    'the future in IO Crypto (edited)',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(color: Colors.black45),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.14),
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(const NavBarRoute());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CREATE PORTFOLIO  ',
                            style: theme.textTheme.headlineMedium,
                          ),
                          const RotationTransition(
                            turns: AlwaysStoppedAnimation(310 / 360),
                            child: Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
