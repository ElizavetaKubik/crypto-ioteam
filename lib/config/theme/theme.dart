import 'package:crypto_ioteam/core/constants/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    // colorScheme: ColorScheme.fromSwatch().copyWith(
    //   onPrimary: AppColors.primaryYellow,
    //   primary: AppColors.primaryYellow,
    //   secondary: AppColors.lightYellow,
    // ),
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryYellow,
      onPrimary: AppColors.primaryYellow,
      primary: AppColors.primaryYellow,
      secondary: AppColors.lightYellow,
    ),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   foregroundColor: Colors.black,
    //   backgroundColor: Colors.yellow,
    // ),
    // scaffoldBackgroundColor: const Color.fromARGB(255, 36, 35, 35),
    // appBarTheme: const AppBarTheme(
    //   elevation: 0,
    //   backgroundColor: Color.fromARGB(255, 36, 35, 35),
    //   titleTextStyle: TextStyle(
    //     color: Colors.white,
    //     fontWeight: FontWeight.w700,
    //     fontSize: 20,
    //   ),
    // ),
    // listTileTheme: const ListTileThemeData(
    //   iconColor: Colors.white,
    // ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 45,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 30,
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),

      //   // this.headlineLarge,
      headlineMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),

      //   // TextStyle? titleLarge,
      //   // TextStyle? titleMedium,
      //   // TextStyle? titleSmall,

      //   // TextStyle? bodyLarge,
      //   // bodyMedium: const TextStyle(
      //   //   color: Colors.white,
      //   //   fontWeight: FontWeight.w500,
      //   //   fontSize: 20,
      //   // ),
      //   // TextStyle? bodySmall,

      labelLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      labelMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 18,
      ),
      labelSmall: TextStyle(
        color: Colors.black38,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),

    //useMaterial3: true,
  );
}
