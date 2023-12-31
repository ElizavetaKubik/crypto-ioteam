import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/features/coin/coin_screen.dart';
import 'package:crypto_ioteam/features/home/pages/home_screen.dart';
import 'package:crypto_ioteam/features/nav_bar/pages/nav_bar_screen.dart';
import 'package:crypto_ioteam/features/welcome/view/welcome_screen.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, path: '/'),
        AutoRoute(page: NavBarRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CoinRoute.page),
      ];
}
