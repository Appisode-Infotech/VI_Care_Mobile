import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/create_patients/provider/patient_provider.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';

import '../../dashboard/model/device_response_model.dart';
import '../../dashboard/provider/devices_provider.dart';
import '../../main.dart';
import '../../utils/app_buttons.dart';
import '../../utils/routes.dart';
import '../model/dashboard_count_response_model.dart';
import '../model/enterprise_response_model.dart';
import '../model/individual_response_model.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  IndividualResponseModel? individualPatientData;
  EnterpriseResponseModel? enterprisePatientData;
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
  ];
  String? pId;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    pId = arguments['id'].toString();
    return Consumer(
      builder: (BuildContext context, PatientProvider patientProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              prefModel.userData!.roleId == 2
                  ? AppLocale.memberDetails.getString(context)
                  : prefModel.userData!.roleId == 3
                      ? AppLocale.patientDetails.getString(context)
                      : prefModel.userData!.roleId == 4
                          ? AppLocale.playerDetails.getString(context)
                          : "",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 75,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              GestureDetector(
                onTap: () async {
                  await patientProvider.getStateMaster(context);
                  if (prefModel.userData!.roleId == 2 &&
                      individualPatientData?.result != null) {
                    patientProvider.prefillEditPatientDetails(
                        context, individualPatientData, enterprisePatientData);
                  }
                  if (prefModel.userData!.roleId == 3 &&
                      enterprisePatientData?.result != null) {
                    patientProvider.prefillEditPatientDetails(
                        context, individualPatientData, enterprisePatientData);
                  }
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.primaryColor,
                      size: 20,
                    )),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: prefModel.userData!.roleId == 2
                ? FutureBuilder(
                    future: patientProvider.getIndividualUserData(pId),
                    builder: (BuildContext context,
                        AsyncSnapshot<IndividualResponseModel> snapshot) {
                      if (snapshot.hasData) {
                        individualPatientData = snapshot.data;
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: screenSize!.width,
                              height: screenSize!.height / 2.4,
                              color: AppColors.primaryColor,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      snapshot.data!.result!.profilePicture!
                                                  .url !=
                                              null
                                          ? CircleAvatar(
                                              radius: 40,
                                              backgroundColor: Colors.grey,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!.result!
                                                      .profilePicture!.url!
                                                      .toString()))
                                          : const CircleAvatar(
                                              radius: 22,
                                              backgroundColor: Colors.grey,
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                            ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.summaryRoute,
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data!.result!.firstName} ${snapshot.data!.result!.lastName}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "${patientProvider.calculateAge(snapshot.data!.result!.contact!.doB.toString())} Years",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              snapshot.data!.result!.contact!
                                                          .gender ==
                                                      1
                                                  ? "Male"
                                                  : snapshot
                                                              .data!
                                                              .result!
                                                              .contact!
                                                              .gender ==
                                                          2
                                                      ? "Female"
                                                      : "Do not wish to specify",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              AppLocale.viewCompleteDetails
                                                  .getString(context),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      Colors.white),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 12),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xffdbeeee),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Text(
                                                  AppLocale.viewSummary
                                                      .getString(context),
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder(
                                    future: patientProvider
                                        .getCounts(snapshot.data!.result!.id!),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                DashboardCountResponseModel>
                                            countSnapshot) {
                                      if(countSnapshot.hasData){
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 15,
                                                      right: 10,
                                                      top: 10,
                                                      bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(12)),
                                                    color: Colors.white,
                                                  ),
                                                  height: 100,
                                                  width: screenSize!.width / 4,
                                                  child: Text(
                                                    parseDate(
                                                        countSnapshot.data!.result!
                                                            .lastTested!),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  AppLocale.lastTested
                                                      .getString(context),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                  const EdgeInsets.all(12),
                                                  decoration: const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(12)),
                                                    color: Colors.white,
                                                  ),
                                                  height: 100,
                                                  width: screenSize!.width / 4,
                                                  child: Center(
                                                      child: Text(
                                                        countSnapshot.data!.result!
                                                            .totalTests!.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  AppLocale.totalTested
                                                      .getString(context),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                  const EdgeInsets.all(12),
                                                  decoration: const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(12)),
                                                    color: Colors.white,
                                                  ),
                                                  height: 100,
                                                  width: screenSize!.width / 4,
                                                  child: Center(
                                                      child: Text(
                                                        countSnapshot.data!.result!
                                                            .reportsCount!.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  AppLocale.reports
                                                      .getString(context),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                )
                                              ],
                                            ),
                                          ],
                                        );
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
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Consumer(
                                    builder: (BuildContext context,
                                        DeviceProvider deviceProvider,
                                        Widget? child) {
                                      return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: AppColors.primaryColor,
                                          ),
                                          width: screenSize!.width,
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width:
                                                      screenSize!.width * 0.6,
                                                  child: Text(
                                                    "${AppLocale.startNewScan.getString(context)} ${snapshot.data!.result!.firstName} ${snapshot.data!.result!.lastName}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () async {
                                                  showLoaderDialog(context);
                                                  DeviceResponseModel
                                                      myDevices =
                                                      await deviceProvider
                                                          .getMyDevices();
                                                  Navigator.pop(context);
                                                  if (myDevices
                                                      .result!.isEmpty) {
                                                    showErrorToast(context,
                                                        myDevices.message!);
                                                  } else {
                                                    Navigator.pushNamed(context,
                                                        Routes.takeTestRoute,
                                                        arguments: {
                                                          'individualPatientData':
                                                              snapshot.data!,
                                                          'deviceData':
                                                              myDevices
                                                                  .result![0]
                                                        });
                                                  }
                                                },
                                                child: Container(
                                                    height: 50,
                                                    width: screenSize!.width *
                                                        0.2,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12)),
                                                            color:
                                                                Colors.white),
                                                    child: Center(
                                                      child: Text(
                                                        AppLocale.start
                                                            .getString(context),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ));
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocale.reports.getString(context),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.reportsRoute);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocale.viewAll
                                                  .getString(context),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Icon(Icons.navigate_next)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    itemCount: patientReports.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.grey,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      patientReports[index]
                                                          ["image"]),
                                                  radius: 30,
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      patientReports[index]
                                                          ["patientName"],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      patientReports[index]
                                                          ["age"],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      patientReports[index]
                                                          ["description"],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      "created: ${patientReports[index]["created"]}",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: (patientReports[index]
                                                          ["receivedReport"] ==
                                                      true)
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                                            [
                                                                            "repData"]
                                                                        [
                                                                        "bpm"]),
                                                                stepSize: 5,
                                                                selectedColor:
                                                                    patientReports[index]
                                                                            [
                                                                            "repData"]
                                                                        [
                                                                        "color"],
                                                                unselectedColor:
                                                                    Colors.grey[
                                                                        200],
                                                                padding: 0,
                                                                selectedStepSize:
                                                                    6,
                                                                roundedCap:
                                                                    (_, __) =>
                                                                        true,
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  patientReports[
                                                                          index]
                                                                      [
                                                                      "repData"]["bpm"],
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          patientReports[index]
                                                                  ["repData"]
                                                              ["status"],
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: patientReports[
                                                                          index]
                                                                      [
                                                                      "repData"]
                                                                  ["color"]),
                                                        )
                                                      ],
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                            color: patientReports[
                                                                        index]
                                                                    ['repData']
                                                                ["color"],
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              patientReports[
                                                                      index][
                                                                  "reportStatus"],
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
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
                : FutureBuilder(
                    future: patientProvider.getEnterpriseUserData(pId),
                    builder: (BuildContext context,
                        AsyncSnapshot<EnterpriseResponseModel> snapshot) {
                      enterprisePatientData = snapshot.data;
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            width: screenSize!.width,
                            height: screenSize!.height / 2.4,
                            color: AppColors.primaryColor,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.result!.profilePicture!.url
                                          .toString()),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.summaryRoute,
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data!.result!.firstName} ${snapshot.data!.result!.lastName}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "${patientProvider.calculateAge(snapshot.data!.result!.contact!.doB.toString())} Years",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            snapshot.data!.result!.contact!
                                                        .gender ==
                                                    1
                                                ? "Male"
                                                : snapshot.data!.result!
                                                            .contact!.gender ==
                                                        2
                                                    ? "Female"
                                                    : "Do not wish to specify",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            AppLocale.viewCompleteDetails
                                                .getString(context),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.white),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18,
                                                      vertical: 12),
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffdbeeee),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Text(
                                                AppLocale.viewSummary
                                                    .getString(context),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                FutureBuilder(
                                  future: patientProvider
                                      .getCounts(snapshot.data!.result!.id!),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<
                                          DashboardCountResponseModel>
                                      countSnapshot) {
                                    if(countSnapshot.hasData){
                                      return Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 10,
                                                    top: 10,
                                                    bottom: 10),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(12)),
                                                  color: Colors.white,
                                                ),
                                                height: 100,
                                                width: screenSize!.width / 4,
                                                child: Text(
                                                  parseDate(
                                                      countSnapshot.data!.result!
                                                          .lastTested!),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppLocale.lastTested
                                                    .getString(context),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    overflow:
                                                    TextOverflow.ellipsis),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                padding:
                                                const EdgeInsets.all(12),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(12)),
                                                  color: Colors.white,
                                                ),
                                                height: 100,
                                                width: screenSize!.width / 4,
                                                child: Center(
                                                    child: Text(
                                                      countSnapshot.data!.result!
                                                          .totalTests!.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppLocale.totalTested
                                                    .getString(context),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    overflow:
                                                    TextOverflow.ellipsis),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                padding:
                                                const EdgeInsets.all(12),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(12)),
                                                  color: Colors.white,
                                                ),
                                                height: 100,
                                                width: screenSize!.width / 4,
                                                child: Center(
                                                    child: Text(
                                                      countSnapshot.data!.result!
                                                          .reportsCount!.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppLocale.reports
                                                    .getString(context),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    overflow:
                                                    TextOverflow.ellipsis),
                                              )
                                            ],
                                          ),
                                        ],
                                      );
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Column(
                              children: [
                                Consumer(
                                  builder: (BuildContext context,
                                      DeviceProvider deviceProvider,
                                      Widget? child) {
                                    return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color: AppColors.primaryColor,
                                        ),
                                        width: screenSize!.width,
                                        height: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: screenSize!.width * 0.6,
                                                child: Text(
                                                  "${AppLocale.startNewScan.getString(context)} ${snapshot.data!.result!.firstName} ${snapshot.data!.result!.lastName}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )),
                                            const SizedBox(width: 5),
                                            GestureDetector(
                                              onTap: () async {
                                                showLoaderDialog(context);
                                                DeviceResponseModel myDevices =
                                                    await deviceProvider
                                                        .getMyDevices();
                                                Navigator.pop(context);
                                                if (myDevices.result!.isEmpty) {
                                                  showErrorToast(context,
                                                      myDevices.message!);
                                                } else {
                                                  Navigator.pushNamed(context,
                                                      Routes.takeTestRoute,
                                                      arguments: {
                                                        'enterprisePatientData':
                                                            snapshot.data!,
                                                        'deviceData':
                                                            myDevices.result![0]
                                                      });
                                                }
                                              },
                                              child: Container(
                                                  height: 50,
                                                  width:
                                                      screenSize!.width * 0.2,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                          color: Colors.white),
                                                  child: Center(
                                                    child: Text(
                                                      AppLocale.start
                                                          .getString(context),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )),
                                            )
                                          ],
                                        ));
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocale.reports.getString(context),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.reportsRoute);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            AppLocale.viewAll
                                                .getString(context),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Icon(Icons.navigate_next)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                  itemCount: patientReports.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2,
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    patientReports[index]
                                                        ["image"]),
                                                radius: 30,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    patientReports[index]
                                                        ["patientName"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    patientReports[index]
                                                        ["age"],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    patientReports[index]
                                                        ["description"],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "created: ${patientReports[index]["created"]}",
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: (patientReports[index]
                                                        ["receivedReport"] ==
                                                    true)
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Stack(
                                                          children: [
                                                            CircularStepProgressIndicator(
                                                              totalSteps: 200,
                                                              currentStep: int.parse(
                                                                  patientReports[
                                                                              index]
                                                                          [
                                                                          "repData"]
                                                                      ["bpm"]),
                                                              stepSize: 5,
                                                              selectedColor:
                                                                  patientReports[
                                                                              index]
                                                                          [
                                                                          "repData"]
                                                                      ["color"],
                                                              unselectedColor:
                                                                  Colors.grey[
                                                                      200],
                                                              padding: 0,
                                                              selectedStepSize:
                                                                  6,
                                                              roundedCap:
                                                                  (_, __) =>
                                                                      true,
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                patientReports[
                                                                            index]
                                                                        [
                                                                        "repData"]
                                                                    ["bpm"],
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        patientReports[index]
                                                                ["repData"]
                                                            ["status"],
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: patientReports[
                                                                        index]
                                                                    ["repData"]
                                                                ["color"]),
                                                      )
                                                    ],
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                          color: patientReports[
                                                                      index]
                                                                  ['repData']
                                                              ["color"],
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            patientReports[
                                                                    index][
                                                                "reportStatus"],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
  parseDate(String timestampString){
    DateTime parsedDateTime = DateTime.parse(timestampString);
    return DateFormat('dd\nMMM\nyyyy').format(parsedDateTime);
  }
}
