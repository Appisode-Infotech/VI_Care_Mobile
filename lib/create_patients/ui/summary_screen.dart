import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vicare/create_patients/provider/patient_provider.dart';
import 'package:vicare/dashboard/model/summary_report_response_model.dart';

import '../../utils/app_buttons.dart';
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
  Map<int, Future<SummaryReportResponseModel>> _summaryReports = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  Future<SummaryReportResponseModel>? _fetchSummaryReport(
      int tabIndex, String pId, PatientProvider patientProvider) {
    if (!_summaryReports.containsKey(tabIndex)) {
      _summaryReports[tabIndex] =
          patientProvider.getSummaryReport(context, pId, tabIndex + 1);
    }
    return _summaryReports[tabIndex];
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    String pId = arguments['pId'].toString();

    return Consumer(
      builder: (BuildContext context, PatientProvider patientProvider,
          Widget? child) {
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                        for (int j = 1; j < 6; j++)
                          SingleChildScrollView(
                            child: FutureBuilder(
                              future: _fetchSummaryReport(
                                  j - 1, pId, patientProvider),
                              builder: (BuildContext summaryContext,
                                  AsyncSnapshot<SummaryReportResponseModel>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: Lottie.asset(
                                          'assets/lottie/loading.json'),
                                    ),
                                  );
                                }
                                if (snapshot.hasData) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.bpmMean.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context,
                                                   AppLocale.bpmMeanDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title:  AxisTitle(text: AppLocale.bpm.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result!['bpM_Mean']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!.result![
                                                        'bpM_Mean']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.ari.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context, AppLocale.ariDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title:  AxisTitle(text: AppLocale.ari.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result!['ari']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                  i.toDouble(),
                                                  snapshot
                                                      .data!.result!['ari']![i],
                                                ),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [ Text(
                                            AppLocale.vlfPower.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context,
                                                    AppLocale.vlfDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title:  AxisTitle(
                                              text: AppLocale.vlfPower.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result![
                                                              'vlF_Power_ms']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!.result![
                                                        'vlF_Power_ms']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.lfPower.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context,
                                                   AppLocale.lfPowerDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title:  AxisTitle(
                                              text: AppLocale.lfPower.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result![
                                                              'lF_Power_ms']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!.result![
                                                        'lF_Power_ms']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.hfPower.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context,
                                                    AppLocale.hfPowerDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                          maximum: _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title:  AxisTitle(
                                              text: AppLocale.hfPower.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result![
                                                              'hF_Power_ms']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!.result![
                                                        'hF_Power_ms']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.totalPower.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context, AppLocale.totalPowerDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title:  AxisTitle(
                                              text: AppLocale.totalPower.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result![
                                                              'total_Power']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!.result![
                                                        'total_Power']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.lfHf.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context,
                                                    AppLocale.lfHfDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title: AxisTitle(text: AppLocale.lfHf.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result!['lFtoHF']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!
                                                        .result!['lFtoHF']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.sdrr.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context,
  AppLocale.sdrrDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.sdrrDescription.getString(context)),
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title:  AxisTitle(text: AppLocale.sdrr.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result!['sdrr']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!
                                                        .result!['sdrr']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            AppLocale.rmssdrr.getString(context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                showInfoDialog(context, AppLocale.rmssdrrDescription.getString(context));
                                              },
                                              child: const Icon(
                                                  Icons.info_outline))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SfCartesianChart(
                                        primaryXAxis: NumericAxis(
                                          title:  AxisTitle(text: AppLocale.days.getString(context)),
                                          maximum:
                                              _calculateMaxCount(j).toDouble(),
                                        ),
                                        primaryYAxis:  NumericAxis(
                                          title: AxisTitle(text: AppLocale.rmssdrr.getString(context)),
                                        ),
                                        series: <LineSeries<ScatterPoint,
                                            double>>[
                                          LineSeries<ScatterPoint, double>(
                                            dataSource: [
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data!
                                                          .result!['rmssdrr']!
                                                          .length;
                                                  i++)
                                                ScatterPoint(
                                                    i.toDouble(),
                                                    snapshot.data!.result![
                                                        'rmssdrr']![i]),
                                            ],
                                            xValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.x,
                                            yValueMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y,
                                            pointColorMapper:
                                                (ScatterPoint point, _) =>
                                                    point.y < 15
                                                        ? Colors.yellow
                                                        : Colors.green,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.auto,
                                              textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
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
                                  return Center(
                                      child: Text(AppLocale.loading
                                          .getString(context)));
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
            ));
      },
    );
  }

  int _calculateMaxCount(int period) {
    switch (period) {
      case 1: // 1 week
        return 7;
      case 2: // 1 month
        return 30;
      case 3: // 3 months
        return 90;
      case 4: // 6 months
        return 180;
      case 5: // 1 year
        return 365;
      default:
        return 7;
    }
  }
}
