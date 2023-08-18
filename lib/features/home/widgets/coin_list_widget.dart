import 'package:crypto_ioteam/features/coin_list/bloc/coin_list_bloc.dart';
import 'package:crypto_ioteam/features/coin_list/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinListWidget extends StatelessWidget {
  const CoinListWidget({
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
    return Container(
      height: screenHeight * 0.7,
      width: screenWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey.shade200,
            spreadRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
              bottom: screenHeight * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assets',
                  style: theme.textTheme.headlineMedium,
                ),
                const Icon(Icons.add),
              ],
            ),
          ),
          BlocBuilder<CoinListBloc, CoinListState>(
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
                        Text(
                          'Something went wrong',
                          style: theme.textTheme.headlineMedium,
                        ),
                        Text(
                          'Please try againg later',
                          style: theme.textTheme.labelMedium,
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
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CoinTile(coin: state.coinList[index]);
                          }),
                      SizedBox(height: screenHeight * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08),
                        child: Row(
                          children: [
                            Text(
                              'Recommended to Buy',
                              style: theme.textTheme.displaySmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      CoinListRecomWidget(state),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Expanded CoinListRecomWidget(CoinListLoaded state) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: SizedBox(
          width: screenWidth,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.coinList.length,
            itemBuilder: (context, index) {
              return CoinTileRecommended(
                coin: state.coinList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
