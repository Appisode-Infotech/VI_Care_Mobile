import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:vicare/dashboard/model/reports_detail_model.dart';
import 'package:vicare/dashboard/model/reports_processed_data_model.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../main.dart';
import '../../utils/app_locale.dart';

class DetailedReportScreen extends StatefulWidget {
  const DetailedReportScreen({super.key});

  @override
  State<DetailedReportScreen> createState() => _DetailedReportScreenState();
}

class _DetailedReportScreenState extends State<DetailedReportScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    int? requestDeviceDataId = arguments['requestDeviceDataId'];
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider,
          Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title:  Text(AppLocale.detailReport.getString(context)),
            actions: [
              IconButton(
                  onPressed: () {
                    takeTestProvider.downloadReportPdf(takeTestProvider.documentResp!.result![0].url!,context);
                  },
                  icon: const Icon(Icons.download))
            ],
          ),
          body: FutureBuilder(
            future:
                takeTestProvider.getReportDetails(requestDeviceDataId, context),
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
                ReportsProcessedDataModel processedData = ReportsProcessedDataModel.fromJson(jsonDecode(snapshot.data!.result![0].processedData!));
                List additionalInfo = [
                  {
                    "name":"RMSSD",
                    "value":processedData.rmssdrr
                  },
                  {
                    "name":"SDRR",
                    "value":processedData.sdrr
                  },
                  {
                    "name":"TP(ms)",
                    "value":processedData.totalPower
                  },
                  {
                    "name":"LF(ms)",
                    "value":processedData.lfPowerMs
                  },
                  {
                    "name":"HF(ms)",
                    "value":processedData.hfPowerMs
                  },
                  {
                    "name":"LF/HF",
                    "value":processedData.lFtoHf
                  },
                  {
                    "name":"Breath < 9",
                    "value":processedData.breathRateLess9Possible
                  },
                ];
                return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          AppLocale.patientDetails.getString(context),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${AppLocale.name.getString(context)}: ${takeTestProvider.reportUserData!.firstName} ${takeTestProvider.reportUserData!.lastName}"),
                        // Text("Age : ${calculateAge(takeTestProvider.reportUserData!.doB!)}"),
                        // Text("Gender : ${takeTestProvider.reportUserData!.gender.toString()}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "${AppLocale.reportDate.getString(context)} : ${parseDate(snapshot.data!.result![0].processedDateTime.toString())}"),
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
                         Text(
                          AppLocale.readiness.getString(context),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: screenSize?.width,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: const BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      processedData.rrTotal!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                               Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocale.testGoesHere.getString(context),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                   AppLocale.testGoesHereDesc.getString(context),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                         Text(
                          AppLocale.restingHeartRate.getString(context),
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
                                value: 80,
                                onChanged: (value) {},
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocale.low.getString(context),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    AppLocale.high.getString(context),
                                    style: const TextStyle(
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
                         Text(
                          AppLocale.bodyMindBalance.getString(context),
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
                         Text(
                          AppLocale.heartRhythmDiagram.getString(context),
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
                         Text(
                          AppLocale.additionalPara.getString(context),
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
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${additionalInfo[index]['name']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "${additionalInfo[index]['value']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                )
                              ],
                            );
                          },
                        ),
                         Text(
                          AppLocale.weightBMI.getString(context),
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
                                value: 80,
                                onChanged: (value) {},
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocale.low.getString(context),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    AppLocale.high.getString(context),
                                    style: const TextStyle(
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.primaryColor
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('KG',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
                                  Text('Weight',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('CM',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
                                  Text('Height',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('0',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
                                  Text('BMI',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          AppLocale.results.getString(context),
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
                return  Center(child: Text(AppLocale.loading.getString(context)));
              }
            },
          ),
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
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(dateOfBirth);
    int ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  parseDate(String timestampString) {
    DateTime parsedDateTime = DateTime.parse(timestampString);
    return DateFormat('dd-MM-yyyy hh:mm aa').format(parsedDateTime);
  }
}
