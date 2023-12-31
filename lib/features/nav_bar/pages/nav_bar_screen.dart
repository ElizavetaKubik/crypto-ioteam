import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/core/constants/colors.dart';
import 'package:crypto_ioteam/features/home/pages/home_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final iconHeght = screenHeight * 0.035;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/1.1.png',
                height: iconHeght,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                'assets/icons/1.2.png',
                height: iconHeght,
                color: AppColors.primaryYellow,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/2.1.png',
                height: iconHeght,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                'assets/icons/2.2.png',
                height: iconHeght,
                color: AppColors.primaryYellow,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/3.1.png',
                height: iconHeght,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                'assets/icons/3.2.png',
                height: iconHeght,
                color: AppColors.primaryYellow,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/4.1.png',
                height: iconHeght,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                'assets/icons/4.2.png',
                height: iconHeght,
                color: AppColors.primaryYellow,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
