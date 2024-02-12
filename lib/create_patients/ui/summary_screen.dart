import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class ScatterPoint {
  final double x;
  final double y;

  ScatterPoint(this.x, this.y);
}

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.patientDetailsRoute);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          AppLocale.summary.getString(context),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all((Radius.circular(12))),
                color: Color(0xffD9D9D9),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryColor,
                ),
                indicatorPadding: const EdgeInsets.symmetric(
                    horizontal: -10, vertical: 5),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: AppLocale.oneWeek.getString(context)),
                  Tab(text: AppLocale.oneMonth.getString(context)),
                  Tab(text: AppLocale.sixMonth.getString(context)),
                  Tab(text: AppLocale.oneYear.getString(context)),
                ],
              ),
            ),

            const SizedBox(height: 20,),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocale.readiness.getString(context),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight
                              .w700),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFD32F2F),
                                Color(0xFFFFD600),
                                Color(0xFF0094FF),
                                Color(0xFF0BC612),
                              ],
                              stops: [0.0, 0.2, 0.76, 1.0],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocale.low.getString(context),
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),),
                              Text(AppLocale.high.getString(context),
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),

                        SfCartesianChart(
                          primaryXAxis: const NumericAxis(),
                          primaryYAxis: const NumericAxis(),
                          series: <ScatterSeries<ScatterPoint, double>>[
                            ScatterSeries<ScatterPoint, double>(
                              dataSource: [
                                ScatterPoint(0, 5),
                                ScatterPoint(1, 25),
                                ScatterPoint(2, 13),
                                ScatterPoint(3, 2),
                                ScatterPoint(4, 21),
                                ScatterPoint(5, 18),
                                ScatterPoint(6, 9),
                                // Add more points as needed
                              ],
                              xValueMapper: (ScatterPoint point, _) => point.x,
                              yValueMapper: (ScatterPoint point, _) => point.y,
                              pointColorMapper: (ScatterPoint point, _) =>
                              point.y < 15 ? Colors.yellow : Colors.green,
                              markerSettings: const MarkerSettings(
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),
                        Text(
                          AppLocale.resting.getString(context),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight
                              .w700),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFD32F2F),
                                Color(0xFFFFD600),
                                Color(0xFF0094FF),
                                Color(0xFF0BC612),
                              ],
                              stops: [0.0, 0.2, 0.76, 1.0],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocale.low.getString(context),
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),),
                              Text(AppLocale.high.getString(context),
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),

                        SfCartesianChart(
                          primaryXAxis: const NumericAxis(),
                          primaryYAxis: const NumericAxis(),
                          series: <ScatterSeries<ScatterPoint, double>>[
                            ScatterSeries<ScatterPoint, double>(
                              dataSource: [
                                ScatterPoint(0, 5),
                                ScatterPoint(1, 25),
                                ScatterPoint(2, 13),
                                ScatterPoint(3, 2),
                                ScatterPoint(4, 21),
                                ScatterPoint(5, 18),
                                ScatterPoint(6, 9),
                                // Add more points as needed
                              ],
                              xValueMapper: (ScatterPoint point, _) => point.x,
                              yValueMapper: (ScatterPoint point, _) => point.y,
                              pointColorMapper: (ScatterPoint point, _) =>
                              point.y < 15 ? Colors.yellow : Colors.green,
                              markerSettings: const MarkerSettings(
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),

                  //Tabs content here//

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


