
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vicare/create_patients/provider/patient_provider.dart';
import 'package:vicare/dashboard/model/summary_report_response_model.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';

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
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    String pId = arguments['pId'].toString();

    return Consumer(
      builder: (BuildContext context, PatientProvider patientProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
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
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: -10, vertical: 5),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: AppLocale.oneWeek.getString(context)),
                      Tab(text: AppLocale.oneMonth.getString(context)),
                      Tab(text: AppLocale.threeMonth.getString(context)),
                      Tab(text: AppLocale.sixMonth.getString(context)),
                      Tab(text: AppLocale.oneYear.getString(context)),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      for(int j = 1;j<6;j++ )
                        SingleChildScrollView(
                          child: FutureBuilder(
                            future: patientProvider.getSummaryReport(context,pId,j),
                            builder: (BuildContext summaryContext, AsyncSnapshot<SummaryReportResponseModel> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Lottie.asset('assets/lottie/loading.json'),
                                  ),
                                );
                              }
                              if (snapshot.hasData){
                                return  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   AppLocale.readiness.getString(context),
                                    //   style: const TextStyle(
                                    //       fontSize: 18, fontWeight: FontWeight.w700),
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Container(
                                    //   padding: const EdgeInsets.all(15),
                                    //   decoration: const BoxDecoration(
                                    //     borderRadius: BorderRadius.all(Radius.circular(12)),
                                    //     gradient: LinearGradient(
                                    //       colors: [
                                    //         Color(0xFFD32F2F),
                                    //         Color(0xFFFFD600),
                                    //         Color(0xFF0094FF),
                                    //         Color(0xFF0BC612),
                                    //       ],
                                    //       stops: [0.0, 0.2, 0.76, 1.0],
                                    //       begin: Alignment.centerLeft,
                                    //       end: Alignment.centerRight,
                                    //     ),
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text(
                                    //         AppLocale.low.getString(context),
                                    //         style: const TextStyle(
                                    //             color: Colors.white,
                                    //             fontWeight: FontWeight.w600,
                                    //             fontSize: 15),
                                    //       ),
                                    //       Text(
                                    //         AppLocale.high.getString(context),
                                    //         style: const TextStyle(
                                    //             color: Colors.white,
                                    //             fontWeight: FontWeight.w600,
                                    //             fontSize: 15),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['bpM_Mean']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['bpM_Mean']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['ari']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['ari']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['vlF_Power_ms']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['vlF_Power_ms']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['lF_Power_ms']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['lF_Power_ms']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['hF_Power_ms']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['hF_Power_ms']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['total_Power']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['total_Power']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['lFtoHF']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['lFtoHF']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['sdrr']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['sdrr']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: const NumericAxis(),
                                      primaryYAxis: const NumericAxis(),
                                      series: <ScatterSeries<ScatterPoint, double>>[
                                        ScatterSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for(int i = 0;i<snapshot.data!.result!['rmssdrr']!.length;i++)
                                              ScatterPoint(i.toDouble(), snapshot.data!.result!['rmssdrr']![i]),
                                          ],
                                          xValueMapper: (ScatterPoint point, _) => point.x,
                                          yValueMapper: (ScatterPoint point, _) => point.y,
                                          pointColorMapper: (ScatterPoint point, _) =>
                                          point.y < 15 ? Colors.yellow : Colors.green,
                                          markerSettings: const MarkerSettings(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              } else {
                                return  Center(child: Text(AppLocale.loading.getString(context)));
                              }
                            },
                          ),
                          // Content for the "One Week" tab
                        ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        );
      },
    );
  }
}