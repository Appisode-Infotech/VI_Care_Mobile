import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/routes.dart';

import '../../main.dart';
import '../../utils/app_locale.dart';
import '../model/my_reports_response_model.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? reportTime = 'All Time';
  String? reportStatus = 'All Reports';

  bool isLoadEligible = true;

  Future<MyReportsResponseModel>? reportsData;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    String patientId = arguments['patientId'].toString();
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocale.allReports.getString(context),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 75,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: connected
              ? Consumer(
                  builder: (BuildContext context,
                      TakeTestProvider takeTestProvider, Widget? child) {
                    if (isLoadEligible) {
                      reportsData = takeTestProvider.getMyReportsWithFilter(
                          reportTime, reportStatus,patientId,context);
                      isLoadEligible = false;
                    }
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primaryColor,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 20,
                                      ),
                                    ),
                                    dropdownColor: AppColors.primaryColor,
                                    value: reportTime,
                                    onChanged: (String? value) {
                                      isLoadEligible = true;
                                      setState(() {
                                        reportTime = value!;
                                      });
                                    },
                                    items: <String>[
                                      "All Time",
                                      "This Week",
                                      "This Month",
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    hint: const Text(
                                      "All Time",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.primaryColor,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 20,
                                      ),
                                    ),
                                    dropdownColor: AppColors.primaryColor,
                                    value: reportStatus,
                                    onChanged: (String? value) {
                                      isLoadEligible = true;
                                      setState(() {
                                        reportStatus = value!;
                                      });
                                    },
                                    items: <String>[
                                      "All Reports",
                                      "In Progress",
                                      "Success",
                                      "Fail",
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    hint: Text(
                                      AppLocale.allReports.getString(context),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder(
                              future: takeTestProvider.getMyReportsWithFilter(reportTime, reportStatus,patientId,context),
                              builder: (BuildContext context,
                                  AsyncSnapshot<MyReportsResponseModel>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    width: screenSize!.width,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      enabled: true,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        itemCount: 4,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
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
                                  return snapshot.data!.result!.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: snapshot.data!.result!.length,
                                          itemBuilder: (listContext, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (snapshot
                                                        .data!
                                                        .result![index]
                                                        .processingStatus ==
                                                    3) {
                                                  Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .detailedReportRoute,
                                                      arguments: {
                                                        "requestDeviceDataId":
                                                            snapshot
                                                                .data!
                                                                .result![index]
                                                                .id,
                                                      });
                                                } else if (snapshot
                                                        .data!
                                                        .result![index]
                                                        .processingStatus ==
                                                    2) {
                                                  showErrorToast(context,
                                                     AppLocale.reportProcessing.getString(context));
                                                } else {
                                                  showErrorToast(
                                                      context,
                                                      AppLocale.reportsFailed
                                                          .getString(context));
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 2,
                                                          color: Colors.grey,
                                                          offset: Offset(1, 1),
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage: snapshot
                                                                          .data!
                                                                          .result![
                                                                              index]
                                                                          .roleId ==
                                                                      2
                                                                  ? NetworkImage(snapshot
                                                                          .data!
                                                                          .result![
                                                                              index]
                                                                          .individualProfile!
                                                                          .profilePicture
                                                                          ?.url ??
                                                                      '')
                                                                  : NetworkImage(snapshot
                                                                          .data!
                                                                          .result![
                                                                              index]
                                                                          .enterpriseProfile!
                                                                          .profilePicture
                                                                          ?.url ??
                                                                      ''),
                                                              radius: 30,
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .shade400,
                                                              child: (snapshot.data!.result![index].roleId ==
                                                                              2 &&
                                                                          snapshot.data!.result![index].individualProfile!.profilePicture ==
                                                                              null) ||
                                                                      (snapshot.data!.result![index].roleId !=
                                                                              2 &&
                                                                          snapshot.data!.result![index].enterpriseProfile!.profilePicture ==
                                                                              null)
                                                                  ? const Icon(
                                                                      Icons
                                                                          .person,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .white)
                                                                  : null,
                                                            ),
                                                            const SizedBox(
                                                                width: 20),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: screenSize!
                                                                          .width /
                                                                      3,
                                                                  child: Text(
                                                                    snapshot.data!.result![index].roleId ==
                                                                            2
                                                                        ? "${snapshot.data!.result![index].individualProfile!.firstName!} ${snapshot.data!.result![index].individualProfile!.lastName!}"
                                                                        : snapshot.data!.result![index].enterpriseProfile!.firstName! +
                                                                            " " +
                                                                            snapshot.data!.result![index].enterpriseProfile!.lastName!,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                    "${snapshot.data!.result![index].durationName!} Test"),
                                                                Text(
                                                                  "${parseDate(snapshot.data!.result![index].requestDateTime!)}",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          child: Column(
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
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                                  ),
                                                                  color: getChipColor(snapshot
                                                                      .data!
                                                                      .result![
                                                                          index]
                                                                      .processingStatus),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    snapshot.data!.result![index].processingStatus ==
                                                                            1
                                                                        ? AppLocale
                                                                            .newReport
                                                                            .getString(
                                                                                context)
                                                                        : snapshot.data!.result![index].processingStatus ==
                                                                                2
                                                                            ? AppLocale.inProgress.getString(context)
                                                                            : snapshot.data!.result![index].processingStatus == 3
                                                                                ? AppLocale.successReport.getString(context)
                                                                                : snapshot.data!.result![index].processingStatus == 4
                                                                                    ? AppLocale.failReport.getString(context)
                                                                                    : '',
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10,
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
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : RefreshIndicator(
                                          onRefresh: () async {
                                            setState(() {});
                                          },
                                          child: SingleChildScrollView(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            child: SizedBox(
                                              height: screenSize!.height * .5,
                                              child: Center(
                                                child: Text(AppLocale
                                                    .noReportFound
                                                    .getString(context)),
                                              ),
                                            ),
                                          ),
                                        );
                                }
                                if (snapshot.hasError) {
                                  if (snapshot.error == 'No internet connection') {
                                    return Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.wifi_off,
                                            size: 80,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            AppLocale.noInternet.getString(context),
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            AppLocale.checkInternet.getString(context),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.grey.shade500),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: Text(AppLocale.loading.getString(context)),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
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
                       Text(
                        AppLocale.noInternet.getString(context),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocale.checkInternet.getString(context),
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
  }

  int calculateAge(String dateOfBirthString) {
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString).toLocal();
    DateTime currentDate = DateTime.now().toLocal();
    Duration difference = currentDate.difference(dateOfBirth);
    int ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  String parseDate(String timestampString) {
    DateTime parsedDateTime = DateTime.parse(timestampString).toLocal();
    return DateFormat('MMM/dd/yyyy hh:mm aa').format(parsedDateTime);
  }

  Color getChipColor(int? processingStatus) {
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
}
