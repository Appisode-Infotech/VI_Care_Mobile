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

  Future<SummaryReportResponseModel>? _fetchSummaryReport(int tabIndex, String pId, PatientProvider patientProvider) {
    if (!_summaryReports.containsKey(tabIndex)) {
      _summaryReports[tabIndex] = patientProvider.getSummaryReport(context, pId, tabIndex + 1);
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
                            future: _fetchSummaryReport(j - 1,pId,patientProvider),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "BPM Mean",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context,
                                                  '''What is the Readyness Score?

Throughout the day, your body is exposed to a flood of constantly changinng demands of a physical, psychological and social nature. The survival and functioning of your organism is closely dependent on its ability to adopt to the demands of acute stress phases on the one hand, and on the other hand to find a relaxed state of rest after these phases have subsided so that it can regenerate.

With the autonomic nervous system(ANS), your organism has a highly effective regulatory system that is able to fulfill precisely this task autonomously (on its own) to the greatest possible extent.

The Readyness Score is a summary parameter that evaluates your body's regulatory abilities. It tells you how well your body, with the help of the autonomic nervous system , is basically able to adjust to stress and to what extent this ability is being called upon at the time of the measurement.
The Readyness Score shows you how well you can cope with your day.

What Influences your ANS and thus your Readyness Score?''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                          maximum: _calculateMaxCount(j).toDouble(),
                                        title: const AxisTitle(text: 'Days'),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'BPM'),
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
                                                  snapshot.data!
                                                      .result!['bpM_Mean']![i]),
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
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          " ARI",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context, '''
What resting heart rate is normal?

The heart rate describes the number of measured beats per minute (bpm). A difference is made between:
- Low heart rate (bradycardia)
- Normal heart rate (normofrequency)
- Increased heart rate (tachycardia)

The heart rate is changed by various influences. These are, in particular, age, physical (fitness) condition, and any illnesses.

As a simple comparison, the heart rate at physical rest is used first. This is also called the resting heart rate.
Measure heart rate only at rest to get comparable values.

The following list shows orientation values for the resting pulse rate depending on age and fitness.
                                                ''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis: NumericAxis(
                                        title: const AxisTitle(text: 'Days'),
                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'ARI'),
                                      ),
                                      series: <LineSeries<ScatterPoint,
                                          double>>[
                                        LineSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for (int i = 0;
                                                i <
                                                    snapshot.data!
                                                        .result!['ari']!.length;
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
                                          markerSettings: const MarkerSettings(
                                              isVisible: true),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          "VLF Power ms",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context,
                                                  '''Ratio of Stress towards Relaxation:

Degree of expression of the sympathetic towards the parasympathetic activation.

Normal Range: 0.7-3 (higher values are not good).''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                        title: const AxisTitle(text: 'Days'),

                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'VLF POWER ms'),

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
                                          markerSettings: const MarkerSettings(
                                              isVisible: true),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          "LF Power ms",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context,
                                                  '''Low Frequency indicates the stress state of the individual.

LF power in HRV analysis is a measure of the balance between sympathetic and parasympathetic activity in the autonomic nervous system. A higher LF power value
may indicate increased sympathetic activity, which is associated with the body's "fight or flight" response to stress. Conversely, a lower LF power value may indicate
increased parasympathetic activity, which is associated with the body's "rest and digest"
response and can be a positive indicator of heart health and overall fitness.

Normal Range: 100-500 ms² (higher values are not good).''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                        title: const AxisTitle(text: 'Days'),

                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'LF POWER ms'),
                                      ),
                                      series: <LineSeries<ScatterPoint,
                                          double>>[
                                        LineSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for (int i = 0;
                                                i <
                                                    snapshot
                                                        .data!
                                                        .result!['lF_Power_ms']!
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
                                                isVisible:true
                                              ),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          "HF Power ms",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context,
                                                  '''High Frequency indicates the state of relaxation or the regeneration capacity of the individual.

Normal Range: 100-500 ms2 (higher values are better)''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                        title: const AxisTitle(text: 'Days'),

                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'HF POWER ms'),

                                      ),
                                      series: <LineSeries<ScatterPoint,
                                          double>>[
                                        LineSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for (int i = 0;
                                                i <
                                                    snapshot
                                                        .data!
                                                        .result!['hF_Power_ms']!
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
                                                isVisible:true
                                              ),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          "Total Power",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context, '''
Total Power is the measure of the overall status of the autonomous-nervous regulatory system or general regulation ability. Higher TP values generally indicate greater heart rate variability, which is considered a positive indicator of heart health and overall fitness. Conversely, lower TP values may indicate decreased heart rate variability, which could be a sign of stress, fatigue, or other factors that affect the autonomic nervous system.

Normal Range: 1000-2000 ms² (higher values are better).
''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                        title: const AxisTitle(text: 'Days'),

                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'TOTAL POWER'),

                                      ),
                                      series: <LineSeries<ScatterPoint,
                                          double>>[
                                        LineSeries<ScatterPoint, double>(
                                          dataSource: [
                                            for (int i = 0;
                                                i <
                                                    snapshot
                                                        .data!
                                                        .result!['total_Power']!
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
                                                isVisible:true
                                              ),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          "LF to HF",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context,
                                                  '''Ratio of Stress towards Relaxation:

Degree of expression of the sympathetic towards the parasympathetic activation.
Normal Range: 0.7-3 (higher values are not good).''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                        title: const AxisTitle(text: 'Days'),

                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'LF TO HF'),

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
                                                isVisible:true
                                              ),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          "SDRR",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context,
                                                  '''SSDRR measures total heart rate variability (time-based). Higher values indicate better heart health and fitness. Lower values may suggest stress or fatigue. Normal Range: 30-200 ms.
''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                        title: const AxisTitle(text: 'Days'),

                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'SDRR'),

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
                                                isVisible:true
                                              ),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                        const Text(
                                          "RMSSDRR",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showInfoDialog(context, '''
RMSSD is a standard HRV measure analyzing RR-Interval differences.
Higher values suggest good heart health and fitness.
Lower values may indicate stress, fatigue, or other factors.
Impact of training loads and recovery can be derived from RMSSD.
Normal Range: 20-150 ms (higher values are better).
''');
                                            },
                                            child:
                                                const Icon(Icons.info_outline))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SfCartesianChart(
                                      primaryXAxis:  NumericAxis(
                                        title: const AxisTitle(text: 'Days'),

                                        maximum: _calculateMaxCount(j).toDouble(),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: const AxisTitle(text: 'RMSSDRR'),

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
                                                  snapshot.data!
                                                      .result!['rmssdrr']![i]),
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
                                                isVisible:true
                                              ),
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true,
                                            labelAlignment: ChartDataLabelAlignment.auto,
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,color: Colors.blueGrey
                                            ),
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
                                    child: Text(
                                        AppLocale.loading.getString(context)));
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
