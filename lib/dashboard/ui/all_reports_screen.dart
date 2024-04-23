

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/routes.dart';

import '../../main.dart';
import '../../utils/app_locale.dart';
import '../model/my_reports_response_model.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? allTime;
  String? allReport;


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
      body: Consumer(
        builder: (BuildContext context, TakeTestProvider takeTestProvider , Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: Center(
                //         child: DropdownButtonFormField<String>(
                //           decoration: InputDecoration(
                //             filled: true,
                //             fillColor: AppColors.primaryColor,
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(30.0),
                //               borderSide: BorderSide.none,
                //             ),
                //             contentPadding: const EdgeInsets.symmetric(
                //                 vertical: 10.0, horizontal: 20),
                //           ),
                //           dropdownColor: AppColors.primaryColor,
                //           value: allTime,
                //           onChanged: (String? value) {
                //             setState(() {
                //               allTime = value!;
                //             });
                //           },
                //           items: <String>[
                //             AppLocale.allTime.getString(context),
                //             AppLocale.yesterday.getString(context),
                //             AppLocale.today.getString(context)
                //           ].map<DropdownMenuItem<String>>((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(
                //                 value,
                //                 style: const TextStyle(
                //                     color: Colors.white, fontSize: 15),
                //               ),
                //             );
                //           }).toList(),
                //           icon: const Icon(
                //             Icons.arrow_drop_down,
                //             color: Colors.white,
                //           ),
                //           hint: Text(
                //             AppLocale.allTime.getString(context),
                //             style:
                //             const TextStyle(color: Colors.white, fontSize: 15),
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     Expanded(
                //       child: Center(
                //         child: DropdownButtonFormField<String>(
                //           decoration: InputDecoration(
                //             filled: true,
                //             fillColor: AppColors.primaryColor,
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(30.0),
                //               borderSide: BorderSide.none,
                //             ),
                //             contentPadding: const EdgeInsets.symmetric(
                //                 vertical: 10.0, horizontal: 20),
                //           ),
                //           dropdownColor: AppColors.primaryColor,
                //           value: allReport,
                //           onChanged: (String? value) {
                //             setState(() {
                //               allReport = value!;
                //             });
                //           },
                //           items: <String>[
                //             AppLocale.allReports.getString(context),
                //             AppLocale.moderate.getString(context),
                //             AppLocale.normal.getString(context)
                //           ].map<DropdownMenuItem<String>>((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(
                //                 value,
                //                 style: const TextStyle(
                //                     color: Colors.white, fontSize: 15),
                //               ),
                //             );
                //           }).toList(),
                //           icon: const Icon(
                //             Icons.arrow_drop_down,
                //             color: Colors.white,
                //           ),
                //           hint: Text(
                //             AppLocale.allReports.getString(context),
                //             style:
                //             const TextStyle(color: Colors.white, fontSize: 15),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                FutureBuilder(
                  future: takeTestProvider.getMyReports(),
                  builder: (BuildContext context, AsyncSnapshot<MyReportsResponseModel> snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SizedBox(
                        width: screenSize!.width,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10),
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
                    if(snapshot.hasData){
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.result!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, Routes.detailedReportRoute,arguments: {
                                  "requestDeviceDataId":snapshot.data!.result![index].id,
                                });
                              },
                              child: Column(
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
                                              backgroundImage: snapshot.data!.result![index].roleId==2?NetworkImage(snapshot.data!.result![index].individualProfile!.profilePicture!=null?snapshot.data!.result![index].individualProfile!.profilePicture!.url!:'')
                                                  :NetworkImage(snapshot.data!.result![index].enterpriseProfile!.profilePicture!=null?snapshot.data!.result![index].enterpriseProfile!['profilePicture']!['url']!:''),
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
                                                  snapshot.data!.result![index].roleId==2?
                                                  "${snapshot.data!.result![index].individualProfile!.firstName!} ${snapshot.data!.result![index].individualProfile!.lastName!}"
                                                      :snapshot.data!.result![index].enterpriseProfile!.firstName! + " " +snapshot.data!.result![index].enterpriseProfile!.lastName!,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  snapshot.data!.result![index].roleId==2?
                                                  "${calculateAge(snapshot.data!.result![index].individualProfile!.contact!.doB!)} Years":
                                                  "${calculateAge(snapshot.data!.result![index].enterpriseProfile!.contact!.doB!)} Years",
                                                  style: const TextStyle(
                                                      color: Colors.black, fontSize: 12),
                                                ),
                                                // const SizedBox(height: 5),
                                                // Text(
                                                //   patientReports[index]["description"],
                                                //   style: const TextStyle(
                                                //       color: Colors.black, fontSize: 12),
                                                // ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "${parseDate(snapshot.data!.result![index].requestDateTime!)}",
                                                  style: const TextStyle(
                                                      color: Colors.black, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child:
                                          // (patientReports[index]["receivedReport"] == true)
                                          //     ? Column(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment.center,
                                          //   children: [
                                          //     SizedBox(
                                          //       width: 50,
                                          //       height: 50,
                                          //       child: Stack(
                                          //         children: [
                                          //           CircularStepProgressIndicator(
                                          //             totalSteps: 200,
                                          //             currentStep: int.parse(
                                          //                 patientReports[index]
                                          //                 ["repData"]["bpm"]),
                                          //             stepSize: 5,
                                          //             selectedColor:
                                          //             patientReports[index]
                                          //             ["repData"]["color"],
                                          //             unselectedColor:
                                          //             Colors.grey[200],
                                          //             padding: 0,
                                          //             selectedStepSize: 6,
                                          //             roundedCap: (_, __) => true,
                                          //           ),
                                          //           Center(
                                          //             child: Text(
                                          //               patientReports[index]
                                          //               ["repData"]["bpm"],
                                          //               style: const TextStyle(
                                          //                 color: Colors.black,
                                          //                 fontWeight: FontWeight.bold,
                                          //                 fontSize: 10,
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     const SizedBox(height: 10),
                                          //     Text(
                                          //       patientReports[index]["repData"]
                                          //       ["status"],
                                          //       style: TextStyle(
                                          //           fontSize: 12,
                                          //           color: patientReports[index]
                                          //           ["repData"]["color"]),
                                          //     )
                                          //   ],
                                          // )
                                          //     :
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width / 5,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                                  color: getChipColor(snapshot.data!.result![index].processingStatus),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    snapshot.data!.result![index].processingStatus==1?'New':snapshot.data!.result![index].processingStatus==2?'In Progress':snapshot.data!.result![index].processingStatus==3?'Success':snapshot.data!.result![index].processingStatus==4?'Fail':'',
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
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  int calculateAge(String dateOfBirthString) {
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(dateOfBirth);
    int ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  parseDate(String timestampString){
    DateTime parsedDateTime = DateTime.parse(timestampString);
    return DateFormat('dd-MM-yyyy hh:mm aa').format(parsedDateTime);
  }

  getChipColor(int? processingStatus) {
    return processingStatus==1?Colors.deepOrange:processingStatus==2?Colors.teal:processingStatus==3?Colors.green:processingStatus==4?Colors.red:Colors.black;
  }
}
