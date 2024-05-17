import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:vicare/dashboard/model/reports_detail_model.dart';
import 'package:vicare/dashboard/model/reports_processed_data_model.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../main.dart';

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
                ReportsProcessedDataModel processedData =
                    ReportsProcessedDataModel.fromJson(
                        jsonDecode(snapshot.data!.result![0].processedData!));
                List additionalInfo = [
                  {"name": "RMSSDRR", "value": processedData.rmssdrr},
                  {"name": "SDRR", "value": processedData.sdrr},
                  {"name": "TP", "value": processedData.totalPower},
                  {"name": "VLF", "value": processedData.vlfPowerMs},
                  {"name": "LF", "value": processedData.lfPowerMs},
                  {"name": "HF", "value": processedData.hfPowerMs},
                  {"name": "LF/HF", "value": processedData.lFtoHf},
                  {"name": "Total Power", "value": processedData.totalPower},
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
                        FittedBox(
                          child: Container(
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
                                        double.parse(processedData.ari!)
                                            .toStringAsFixed(0),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Text goes here",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Text goes here for description",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
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
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                value: 80,
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('KG',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Text('Weight',
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
                                  Text('CM',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Text('Height',
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
                                  Text('0',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Text('BMI',
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
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString).toLocal();
    DateTime currentDate = DateTime.now().toLocal();
    Duration difference = currentDate.difference(dateOfBirth);
    int ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  parseDate(String timestampString) {
    DateTime parsedDateTime = DateTime.parse(timestampString).toLocal();
    return DateFormat('dd-MM-yyyy hh:mm aa').format(parsedDateTime);
  }
}
