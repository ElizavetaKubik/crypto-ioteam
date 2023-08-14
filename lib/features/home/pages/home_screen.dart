import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/core/constants/colors.dart';
import 'package:crypto_ioteam/features/coin_list/bloc/coin_list_bloc.dart';
import 'package:crypto_ioteam/features/coin_list/widgets/coin_tile.dart';
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
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    return BlocProvider<CoinListBloc>(
      create: (context) => sl()..add(LoadCoinList()),
      child: Container(
        height: appHeight,
        width: appWidth,
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
            _buildTopButtons(appHeight, appWidth),
            _buildValueAndIcon(appWidth, appHeight),
            _buildProfit(appWidth),
            SizedBox(height: appHeight * 0.02),
            _buildCoinListContainer(appHeight, appWidth),
          ],
        ),
      ),
    );
  }

  Container _buildCoinListContainer(double appHeight, double appWidth) {
    return Container(
      height: appHeight * 0.7,
      width: appWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: appHeight * 0.03),
          Padding(
            padding: EdgeInsets.only(
              left: appWidth * 0.08,
              right: appWidth * 0.08,
              bottom: appHeight * 0.01,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assets',
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.add),
              ],
            ),
          ),
          _buildCoinList(),
        ],
      ),
    );
  }

  BlocBuilder<CoinListBloc, CoinListState> _buildCoinList() {
    return BlocBuilder<CoinListBloc, CoinListState>(
      builder: (context, state) {
        if (state is CoinListLoading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is CoinListLoadingFailure) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 22),
                  ),
                  const Text(
                    'Please try againg later',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<CoinListBloc>(context)
                          .add(LoadCoinList());
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is CoinListLoaded) {
          return Expanded(
            child: ListView.builder(
                itemCount: state.coinList.length,
                itemBuilder: (context, index) {
                  return CoinTile(coin: state.coinList[index]);
                }),
          );
        }

        return Container();
      },
    );
  }

  Padding _buildProfit(double appWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: appWidth * 0.07),
      child: const Row(
        children: [
          Text(
            '+ 167% all time',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Padding _buildValueAndIcon(double appWidth, double appHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * 0.07,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '\$ 7.987',
            style: TextStyle(fontSize: 35),
          ),
          Container(
            height: appHeight * 0.06,
            //width: appWidth * 0.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
            ),
            child: Container(
              padding: EdgeInsets.all(
                appHeight * 0.01,
              ),
              child: Image.asset(
                'assets/icons/5.1.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildTopButtons(double appHeight, double appWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: appHeight * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: appWidth * 0.02,
              vertical: appHeight * 0.008,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Main Portfolio',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Text(
            'Top 10 coins',
            style: TextStyle(fontSize: 18),
          ),
          const Text(
            'Experimental',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
