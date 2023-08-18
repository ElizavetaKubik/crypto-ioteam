import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/core/constants/colors.dart';
import 'package:crypto_ioteam/core/util.dart';
import 'package:crypto_ioteam/features/coin_list/bloc/coin_list_bloc.dart';
import 'package:crypto_ioteam/features/home/widgets/widgets.dart';
import 'package:crypto_ioteam/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);

    final theme = Theme.of(context);

    return BlocProvider<CoinListBloc>(
      create: (context) => sl()..add(LoadCoinList()),
      child: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightYellow,
              AppColors.primaryYellow,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderButtonsWidget(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              theme: theme,
            ),
            MainInfoWidget(
                screenWidth: screenWidth,
                theme: theme,
                screenHeight: screenHeight),
            SizedBox(height: screenHeight * 0.02),
            CoinListWidget(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                theme: theme),
          ],
        ),
      ),
    );
  }
}
