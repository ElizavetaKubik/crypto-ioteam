import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/core/constants/colors.dart';
import 'package:crypto_ioteam/core/util.dart';
import 'package:crypto_ioteam/features/coin/bloc/coin_details_bloc.dart';
import 'package:crypto_ioteam/features/coin/widgets/widgets.dart';
import 'package:crypto_ioteam/injection_container.dart';
import 'package:crypto_ioteam/repository/models/chart_model.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crypto_ioteam/core/constants/data.dart';

@RoutePage()
class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key, required this.coin});
  final CoinModel coin;

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  @override
  void initState() {
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  TrackballBehavior? trackballBehavior;
  int currentIndex = 0;
  int currentFormat = 0;
  double currentMinValue = 0;
  double currentMaxValue = 0;
  NumericAxis currentPrimaryYAxis = NumericAxis();

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);

    final theme = Theme.of(context);
    final CoinModel coin = widget.coin;

    return BlocProvider<CoinDetailsBloc>(
      create: (context) => sl()
        ..add(
          LoadCoinDetails(
            coinId: coin.id,
            time: AppData.intervalDurationList[currentIndex],
          ),
        ),
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                HeaderInfoWidget(
                  screenHeight,
                  screenWidth,
                  coin,
                  theme,
                ),
                const Divider(),
                CoinInfoWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  theme: theme,
                  coin: coin,
                ),
                SizedBox(height: screenHeight * 0.01),
                BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
                  builder: (context, state) {
                    if (state is CoinDetailsLoading) {
                      return SizedBox(
                        height: screenHeight * 0.4,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is CoinDetailsLoaded) {
                      currentPrimaryYAxis = NumericAxis(
                        minimum: state.minVal * 0.9,
                        maximum: state.maxVal * 1.1,
                      );

                      return SizedBox(
                        height: screenHeight * 0.4,
                        width: screenWidth,
                        child: SfCartesianChart(
                          trackballBehavior: trackballBehavior,
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePanning: true,
                            zoomMode: ZoomMode.x,
                          ),
                          series: <CandleSeries>[
                            CandleSeries<ChartModel, DateTime>(
                              enableSolidCandles: true,
                              enableTooltip: true,
                              bullColor: Colors.green,
                              bearColor: Colors.red,
                              dataSource: state.chartList,
                              xValueMapper: (ChartModel sales, _) => sales.time,
                              lowValueMapper: (ChartModel sales, _) =>
                                  sales.low,
                              highValueMapper: (ChartModel sales, _) =>
                                  sales.high,
                              openValueMapper: (ChartModel sales, _) =>
                                  sales.open,
                              closeValueMapper: (ChartModel sales, _) =>
                                  sales.close,
                              animationDuration: 1000,
                            ),
                          ],
                          primaryXAxis: DateTimeAxis(
                            dateFormat: AppData.dataFormatList[currentFormat],
                          ),
                          primaryYAxis: currentPrimaryYAxis,
                        ),
                      );
                    }
                    if (state is CoinDetailsLoadingFailure) {
                      return Center(
                        child: SizedBox(
                          height: screenHeight * 0.4,
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
                                  currentIndex = 0;
                                  currentFormat = 0;

                                  BlocProvider.of<CoinDetailsBloc>(context)
                                      .add(LoadCoinDetails(
                                    coinId: widget.coin.id,
                                    time: AppData
                                        .intervalDurationList[currentIndex],
                                  ));
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: screenHeight * 0.01),
                SizedBox(
                  height: screenHeight * 0.045,
                  child: ListView.builder(
                    itemCount: AppData.intervalSymbolList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: index == currentIndex
                            ? () {}
                            : () {
                                setState(() {
                                  currentIndex = index;
                                  currentFormat = index;

                                  var bloc =
                                      BlocProvider.of<CoinDetailsBloc>(context);
                                  bloc.add(LoadCoinDetails(
                                    coinId: coin.id,
                                    time: AppData.intervalDurationList[index],
                                  ));
                                });
                              },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01,
                              horizontal: screenWidth * 0.03,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: index == currentIndex
                                  ? AppColors.primaryYellow.withOpacity(0.3)
                                  : AppColors.primaryYellow.withOpacity(0.1),
                            ),
                            child: Text(
                              AppData.intervalSymbolList[index],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
