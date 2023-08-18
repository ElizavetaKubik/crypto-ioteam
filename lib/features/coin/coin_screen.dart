import 'package:auto_route/auto_route.dart';
import 'package:crypto_ioteam/core/constants/colors.dart';
import 'package:crypto_ioteam/features/coin/bloc/coin_details_bloc.dart';
import 'package:crypto_ioteam/injection_container.dart';
import 'package:crypto_ioteam/repository/models/chart_model.dart';
import 'package:crypto_ioteam/repository/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    currentMinValue = 0;
    currentMaxValue = 0;
    super.initState();
  }

  List<String> timeList = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<int> daysList = [1, 7, 30, 90, 180, 365];

  TrackballBehavior? trackballBehavior;
  int currentIndex = 0;
  int currentFormat = 0;
  double currentMinValue = 0;
  double currentMaxValue = 35000;
  NumericAxis currentPrimaryYAxis = NumericAxis();

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;

    final CoinModel coin = widget.coin;
    return BlocProvider<CoinDetailsBloc>(
      create: (context) => sl()..add(LoadCoinDetails(coinId: coin.id)),
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: appHeight,
            width: appWidth,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: appWidth * 0.05,
                    vertical: appHeight * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: appHeight * 0.08,
                            child: Image.network(coin.image),
                          ),
                          SizedBox(width: appWidth * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coin.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: appHeight * 0.01),
                              Text(
                                coin.symbol,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${coin.currentPrice}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: appHeight * 0.01),
                          Text(
                            '${coin.marketCapChangePercentage24H}%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: coin.marketCapChangePercentage24H > 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: appWidth * 0.05,
                    vertical: appHeight * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Low',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: appHeight * 0.01),
                          Text(
                            '\$${coin.low24H}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'High',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: appHeight * 0.01),
                          Text(
                            '\$${coin.high24H}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Vol',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: appHeight * 0.01),
                          Text(
                            '\$${coin.totalVolume}M',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: appHeight * 0.01),
                (double appHeight, double appWidth) {
                  List<DateFormat> formatList = [
                    DateFormat.Hm(),
                    DateFormat.MMMd(),
                    DateFormat.MMMd(),
                    DateFormat.MMMd(),
                    DateFormat.MMM(),
                    DateFormat.MMM(),
                  ];

                  return BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
                    builder: (context, state) {
                      if (state is CoinDetailsLoading) {
                        return SizedBox(
                          height: appHeight * 0.4,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is CoinDetailsLoaded) {
                        List<ChartModel> list = state.chartList;

                        double minVal = list.map((e) => e.low).fold(
                            double.infinity,
                            (double current, double? next) => next != null
                                ? (next < current ? next : current)
                                : current);

                        double maxVal = list.map((e) => e.high).fold(
                            double.negativeInfinity,
                            (double current, double? next) => next != null
                                ? (next > current ? next : current)
                                : current);

                        currentPrimaryYAxis = NumericAxis(
                          minimum: minVal * 0.9,
                          maximum: maxVal * 1.1,
                        );

                        return SizedBox(
                          height: appHeight * 0.4,
                          width: appWidth,
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
                                xValueMapper: (ChartModel sales, _) =>
                                    sales.time,
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
                              dateFormat: formatList[currentFormat],
                            ),
                            primaryYAxis: currentPrimaryYAxis,
                          ),
                        );
                      }
                      if (state is CoinDetailsLoadingFailure) {
                        return Center(
                          child: SizedBox(
                            height: appHeight * 0.4,
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
                                    currentIndex = 0;
                                    currentFormat = 0;

                                    BlocProvider.of<CoinDetailsBloc>(context)
                                        .add(LoadCoinDetails(
                                      coinId: widget.coin.id,
                                      time: daysList[currentIndex],
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
                  );
                }(appHeight, appWidth),
                SizedBox(height: appHeight * 0.01),
                SizedBox(
                  height: appHeight * 0.045,
                  child: ListView.builder(
                      itemCount: timeList.length,
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

                                    var bloc = BlocProvider.of<CoinDetailsBloc>(
                                        context);
                                    bloc.add(LoadCoinDetails(
                                      coinId: coin.id,
                                      time: daysList[index],
                                    ));
                                  });
                                },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: appWidth * 0.02),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: appWidth * 0.03,
                                vertical: appHeight * 0.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: index == currentIndex
                                    ? AppColors.primaryYellow.withOpacity(0.3)
                                    : AppColors.primaryYellow.withOpacity(0.1),
                              ),
                              child: Text(
                                timeList[index],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
