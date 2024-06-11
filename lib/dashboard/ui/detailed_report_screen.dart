import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:vicare/dashboard/model/reports_detail_model.dart';
import 'package:vicare/dashboard/model/reports_processed_data_model.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';

import '../../main.dart';
import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';

class DetailedReportScreen extends StatefulWidget {
  const DetailedReportScreen({super.key});

  @override
  State<DetailedReportScreen> createState() => _DetailedReportScreenState();
}

class _DetailedReportScreenState extends State<DetailedReportScreen> {
  Future<ReportsDetailModel>? reportDetails;
  bool isFirstLoading = true;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    int? requestDeviceDataId = arguments['requestDeviceDataId'];
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider,
          Widget? child) {
        if (isFirstLoading) {
          reportDetails =
              takeTestProvider.getReportDetails(requestDeviceDataId, context);
          isFirstLoading = false;
        }
        return OfflineBuilder(
          connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Detailed report"),
              actions: [
                IconButton(
                    onPressed: () {
                      takeTestProvider.downloadReportPdf(
                          takeTestProvider.documentResp!.result![0].url!,
                          context);
                    },
                    icon: const Icon(Icons.download))
              ],
            ),
            body: connected?FutureBuilder(
              future: reportDetails,
              builder: (BuildContext context,
                  AsyncSnapshot<ReportsDetailModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: screenSize!.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: 100,
                            height: 80,
                            color: Colors.grey.shade300,
                          );
                        },
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  ReportsProcessedDataModel processedData =
                      ReportsProcessedDataModel.fromJson(
                          jsonDecode(snapshot.data!.result![0].processedData!));
                  List additionalInfo = [
                    {
                      "name": "RMSSDRR",
                      "value": processedData.rmssdrr,
                      "description":
                          '''RMSSD is a standard HRV measure analyzing RR-Interval differences.
          Higher values suggest good heart health and fitness.
          
          Lower values may indicate stress, fatigue, or other factors.
          Impact of training loads and recovery can be derived from RMSSD.
          
          Normal Range: 20-150 ms (higher values are better).
            '''
                    },
                    {
                      "name": "SDRR",
                      "value": processedData.sdrr,
                      "description":
                          '''SSDRR measures total heart rate variability (time-based). Higher values indicate better heart health and fitness. Lower values may suggest stress or fatigue. Normal Range: 30-200 ms.'''
                    },
          //                   {"name": "TP", "value": processedData.totalPower,"description":'''
          // Total Power is the measure of the overall status of the autonomous-nervous regulatory system or general regulation ability. Higher TP values generally indicate greater heart rate variability, which is considered a positive indicator of heart health and overall fitness. Conversely, lower TP values may indicate decreased heart rate variability, which could be a sign of stress, fatigue, or other factors that affect the autonomic nervous system.
          //
          // Normal Range: 1000-2000 ms² (higher values are better).'''},
                    {
                      "name": "VLF",
                      "value": processedData.vlfPowerMs,
                      "description": '''Ratio of Stress towards Relaxation:
          
          Degree of expression of the sympathetic towards the parasympathetic activation.
          
          Normal Range: 0.7-3 (higher values are not good).'''
                    },
                    {
                      "name": "LF",
                      "value": processedData.lfPowerMs,
                      "description":
                          '''Low Frequency indicates the stress state of the individual.
          
          LF power in HRV analysis is a measure of the balance between sympathetic and parasympathetic activity in the autonomic nervous system. A higher LF power value
          may indicate increased sympathetic activity, which is associated with the body's "fight or flight" response to stress. Conversely, a lower LF power value may indicate
          increased parasympathetic activity, which is associated with the body's "rest and digest"
          response and can be a positive indicator of heart health and overall fitness.
          
          Normal Range: 100-500 ms² (higher values are not good).'''
                    },
                    {
                      "name": "HF",
                      "value": processedData.hfPowerMs,
                      "description":
                          '''High Frequency indicates the state of relaxation or the regeneration capacity of the individual.
          
          Normal Range: 100-500 ms2 (higher values are better)'''
                    },
                    {
                      "name": "LF/HF",
                      "value": processedData.lFtoHf,
                      "description": '''Ratio of Stress towards Relaxation:
          
          Degree of expression of the sympathetic towards the parasympathetic activation.
          Normal Range: 0.7-3 (higher values are not good).'''
                    },
                    {
                      "name": "Total Power",
                      "value": processedData.totalPower,
                      "description": '''
          Total Power is the measure of the overall status of the autonomous-nervous regulatory system or general regulation ability. Higher TP values generally indicate greater heart rate variability, which is considered a positive indicator of heart health and overall fitness. Conversely, lower TP values may indicate decreased heart rate variability, which could be a sign of stress, fatigue, or other factors that affect the autonomic nervous system.
          
          Normal Range: 1000-2000 ms² (higher values are better'''
                    },
                    // {
                    //   "name": "Breath < 9",
                    //   "value": processedData.breathRateLess9Possible
                    // },
                    //
                    // {"name": "LF Power(ms)", "value": processedData.lfPowerMs},
                    // {"name": "HF Power(ms)", "value": processedData.hfPowerMs},
                  ];
                  return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Patient details ",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "Name : ${takeTestProvider.reportUserData!['firstName']} ${takeTestProvider.reportUserData!['lastName']}"),
                          // Text("Age : ${calculateAge(takeTestProvider.reportUserData!.doB!)}"),
                          // Text("Gender : ${takeTestProvider.reportUserData!.gender.toString()}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "Report Date : ${parseDate(snapshot.data!.result![0].processedDateTime.toString())}"),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(20)),
                                  color: getChipColor(
                                      snapshot.data!.result![0].processingStatus),
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data!.result![0].processingStatus ==
                                            1
                                        ? 'New'
                                        : snapshot.data!.result![0]
                                                    .processingStatus ==
                                                2
                                            ? 'In Progress'
                                            : snapshot.data!.result![0]
                                                        .processingStatus ==
                                                    3
                                                ? 'Success'
                                                : snapshot.data!.result![0]
                                                            .processingStatus ==
                                                        4
                                                    ? 'Fail'
                                                    : '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const Text(
                            "Readiness Score ",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          // FittedBox(
                          //   child: Container(
                          //     width: screenSize?.width,
                          //     margin: const EdgeInsets.symmetric(vertical: 10),
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 10, vertical: 10),
                          //     decoration: const BoxDecoration(
                          //         color: Colors.orangeAccent,
                          //         borderRadius: BorderRadius.all(
                          //           Radius.circular(10),
                          //         )),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         CircleAvatar(
                          //             radius: 40,
                          //             backgroundColor: Colors.white,
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Text(
                          //                 double.parse(processedData.ari!)
                          //                     .toStringAsFixed(0),
                          //                 style: const TextStyle(
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 22),
                          //               ),
                          //             )),
                          //         const SizedBox(
                          //           width: 20,
                          //         ),
                          //         const Column(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               "Your Text goes here",
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.bold),
                          //             ),
                          //             Text(
                          //               "Text goes here for description",
                          //               style: TextStyle(
                          //                   fontSize: 14,
                          //                   fontWeight: FontWeight.normal),
                          //             ),
                          //           ],
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                              width: screenSize!.width,
                              height: screenSize!.width,
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                    minimum: 0,
                                    maximum: 100,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                        startValue: 0,
                                        endValue: 25,
                                        color: Colors.orange,
                                        label: 'Very Low',
                                        labelStyle: const GaugeTextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GaugeRange(
                                        startValue: 25,
                                        endValue: 50,
                                        color: Colors.yellow,
                                        label: 'Low',
                                        labelStyle: const GaugeTextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GaugeRange(
                                        startValue: 50,
                                        endValue: 75,
                                        color: Colors.blue,
                                        label: 'Moderate',
                                        labelStyle: const GaugeTextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GaugeRange(
                                        startValue: 75,
                                        endValue: 100,
                                        color: Colors.green,
                                        label: 'High',
                                        labelStyle: const GaugeTextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(
                                        value: double.parse(processedData.ari!),
                                        needleStartWidth: 1,
                                        needleEndWidth: 4,
                                        needleLength: 0.5,
                                      ),
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Text(
                                              double.parse(processedData.ari!)
                                                  .toStringAsFixed(0),
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold)),
                                          angle: 90,
                                          positionFactor: 0.5)
                                    ])
                              ])),

                          const Text(
                            "Resting Heart Rate ",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFEC631B),
                                  Color(0xFFFFD600),
                                  Color(0xFF0094FF),
                                  Color(0xFF0BC612),
                                ],
                                stops: [0.0, 0.2, 0.76, 1.0],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Stack(
                              children: [
                                SfSlider(
                                  inactiveColor: Colors.transparent,
                                  activeColor: Colors.transparent,
                                  thumbIcon: const Icon(Icons.arrow_drop_up),
                                  min: 0.0,
                                  max: 120.0,
                                  interval: 2,
                                  showTicks: false,
                                  showLabels: false,
                                  enableTooltip: true,
                                  shouldAlwaysShowTooltip: true,
                                  value: int.parse(
                                      double.parse(processedData.bpmMean!)
                                          .toStringAsFixed(0)),
                                  onChanged: (value) {},
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Low",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "High",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Body-Mind Balance",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.network(takeTestProvider
                              .documentResp!.result![3].url
                              .toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Heart Rhythm Diagram",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.network(takeTestProvider
                              .documentResp!.result![2].url
                              .toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Additional Parameters",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: additionalInfo.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(width: 1, color: Colors.grey)),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${additionalInfo[index]['name']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "${additionalInfo[index]['value']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          showInfoDialog(context,
                                              "${additionalInfo[index]['description']}");
                                        },
                                        child: const Icon(Icons.info_outline),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Text(
                            "Weight & BMI",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
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
                            child: Stack(
                              children: [
                                SfSlider(
                                  inactiveColor: Colors.transparent,
                                  activeColor: Colors.transparent,
                                  thumbIcon: const Icon(Icons.arrow_drop_up),
                                  min: 0.0,
                                  max: 100.0,
                                  interval: 2,
                                  showTicks: false,
                                  showLabels: false,
                                  enableTooltip: true,
                                  shouldAlwaysShowTooltip: true,
                                  value: takeTestProvider.reportUserData!['bmi']== null? 0
                                          : double.parse(takeTestProvider.reportUserData!['bmi']),
                                  // value: '${takeTestProvider.reportUserData!['bmi']}',
                                  onChanged: (value) {},
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Low",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "High",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: screenSize!.width,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: AppColors.primaryColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      (takeTestProvider.reportUserData!['weight'] ?? 0).toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text('Weight',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    const Text('(KGs)',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      (takeTestProvider.reportUserData!['height'] ?? 0).toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text('Height',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    const Text('(Meters)',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Text(double.parse(takeTestProvider.reportUserData!['bmi']).toStringAsFixed(2),
                                    Text(
                                        double.parse(takeTestProvider
                                                    .reportUserData!['bmi']
                                                    ?.toString() ??
                                                '0')
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    const Text('BMI',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Results",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(processedData.result!),
                        ],
                      ));
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(child: Text("loading"));
                }
              },
            )
                : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No Internet",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Please check your internet\n connection and try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          );
          },
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  getChipColor(int? processingStatus) {
    return processingStatus == 1
        ? Colors.deepOrange
        : processingStatus == 2
            ? Colors.teal
            : processingStatus == 3
                ? Colors.green
                : processingStatus == 4
                    ? Colors.red
                    : Colors.black;
  }

  int calculateAge(String dateOfBirthString) {
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString).toLocal();
    DateTime currentDate = DateTime.now().toLocal();
    Duration difference = currentDate.difference(dateOfBirth);
    int ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  parseDate(String timestampString) {
    DateTime parsedDateTime = DateTime.parse(timestampString).toLocal();
    return DateFormat('MMM/dd/yyyy hh:mm aa').format(parsedDateTime);
  }
}
