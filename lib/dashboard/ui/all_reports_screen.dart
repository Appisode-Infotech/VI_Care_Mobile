import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../utils/app_locale.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? allTime;
  String? allReport;

  List patientReports = [
    {
      "image": "assets/images/img.png",
      "patientName": "Tom Robinson",
      "age": "25 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": true,
      "repData": {
        "status": "Normal",
        "bpm": "117",
        "color": Colors.green,
      },
      "reportStatus": "pending"
    },
    {
      "image": "assets/images/img.png",
      "patientName": "Mary Jane",
      "age": "22 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": true,
      "repData": {"status": "Moderate", "bpm": "123", "color": Colors.orange},
      "reportStatus": "pending"
    },
    {
      "image": "assets/images/img.png",
      "patientName": "Rama krishna",
      "age": "28 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": false,
      "repData": {
        "status": "Moderate",
        "bpm": "125",
        "color": Colors.yellow,
      },
      "reportStatus": "Pending"
    },
    {
      "image": "assets/images/img.png",
      "patientName": "Harry potter",
      "age": "21 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": false,
      "repData": {
        "status": "Moderate",
        "bpm": "125",
        "color": Colors.red,
      },
      "reportStatus": "Rejected"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocale.allReports.getString(context),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.primaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                      ),
                      dropdownColor: AppColors.primaryColor,
                      value: allTime,
                      onChanged: (String? value) {
                        setState(() {
                          allTime = value!;
                        });
                      },
                      items: <String>[
                        AppLocale.allTime.getString(context),
                        AppLocale.yesterday.getString(context),
                        AppLocale.today.getString(context)
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        );
                      }).toList(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      hint: Text(
                        AppLocale.allTime.getString(context),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Center(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.primaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                      ),
                      dropdownColor: AppColors.primaryColor,
                      value: allReport,
                      onChanged: (String? value) {
                        setState(() {
                          allReport = value!;
                        });
                      },
                      items: <String>[
                        AppLocale.allReports.getString(context),
                        AppLocale.moderate.getString(context),
                        AppLocale.normal.getString(context)
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        );
                      }).toList(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      hint: Text(
                        AppLocale.allReports.getString(context),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: patientReports.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey,
                                offset: Offset(1, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      patientReports[index]["image"]),
                                  radius: 30,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patientReports[index]["patientName"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      patientReports[index]["age"],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      patientReports[index]["description"],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "created: ${patientReports[index]["created"]}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              child: (patientReports[index]["receivedReport"] ==
                                      true)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Stack(
                                            children: [
                                              CircularStepProgressIndicator(
                                                totalSteps: 200,
                                                currentStep: int.parse(
                                                    patientReports[index]
                                                        ["repData"]["bpm"]),
                                                stepSize: 5,
                                                selectedColor:
                                                    patientReports[index]
                                                        ["repData"]["color"],
                                                unselectedColor:
                                                    Colors.grey[200],
                                                padding: 0,
                                                selectedStepSize: 6,
                                                roundedCap: (_, __) => true,
                                              ),
                                              Center(
                                                child: Text(
                                                  patientReports[index]
                                                      ["repData"]["bpm"],
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          patientReports[index]["repData"]
                                              ["status"],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: patientReports[index]
                                                  ["repData"]["color"]),
                                        )
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            color: patientReports[index]
                                                ['repData']["color"],
                                          ),
                                          child: Center(
                                            child: Text(
                                              patientReports[index]
                                                  ["reportStatus"],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
