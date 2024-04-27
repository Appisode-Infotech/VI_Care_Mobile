import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/create_patients/model/all_enterprise_users_response_model.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/routes.dart';

import '../../create_patients/model/all_patients_response_model.dart';
import '../../create_patients/provider/patient_provider.dart';
import '../../utils/app_locale.dart';
import '../model/my_reports_response_model.dart';
import '../provider/take_test_provider.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) changeScreen;

  const HomeScreen({super.key, required this.changeScreen});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndexPage = 1;

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
      "image": "assets/images/img_1.png",
      "patientName": "Rhea",
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
      "patientName": "Michael",
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
      "patientName": "Rob",
      "age": "25 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": false,
      "repData": {
        "status": "Normal",
        "bpm": "117",
        "color": Colors.green,
      },
      "reportStatus": "pending"
    },
    {
      "image": "assets/images/img_1.png",
      "patientName": "Meena",
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

  @override
  void didChangeDependencies() {
    if (prefModel.userData!.roleId == 2) {
      Provider.of<PatientProvider>(context, listen: false)
          .getMyPatients(context);
    } else {
      Provider.of<PatientProvider>(context, listen: false)
          .getEnterpriseProfiles(context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(AppLocale.hi.getString(context),
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(
                  width: 8,
                ),
                Text(
                    "${prefModel.userData!.contact!.firstname} ${prefModel.userData!.contact!.lastName}",
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(AppLocale.letsUnlock.getString(context),
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                const Icon(
                  size: 27,
                  Icons.notifications,
                  color: Colors.white,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.red),
                    child: const Center(
                        child: Text(
                      "0",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                width: screenSize!.width,
                height: screenSize!.height / 4,
                color: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocale.recentReports.getString(context),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: PageView.builder(
                        padEnds: false,
                        pageSnapping: true,
                        controller: PageController(viewportFraction: .95),
                        onPageChanged: (index) {
                          setState(() {
                            currentIndexPage = index;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: patientReports.length,
                        physics: const PageScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          patientReports[index]["description"],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${AppLocale.created.getString(context)}: ${patientReports[index]["created"]}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
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
                                                                ["repData"]
                                                            ["color"],
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: DotsIndicator(
                        dotsCount: 5,
                        position: currentIndexPage,
                        decorator: DotsDecorator(
                          activeColor: Colors.white,
                          color: const Color(0xFFD9D9D9),
                          size: const Size.square(9.0),
                          activeSize: const Size(30.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    prefModel.userData!.roleId == 2
                        ? AppLocale.members.getString(context)
                        : prefModel.userData!.roleId == 3
                            ? AppLocale.patients.getString(context)
                            : prefModel.userData!.roleId == 4
                                ? AppLocale.player.getString(context)
                                : "",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      widget.changeScreen(2);
                    },
                    child: Row(
                      children: [
                        Text(
                          AppLocale.viewAll.getString(context),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(builder: (BuildContext context,
                PatientProvider patientProvider, Widget? child) {
              patientProvider.relGetPatientContext = context;
              return prefModel.userData!.roleId == 2
                  ? FutureBuilder(
                      future: patientProvider.individualPatients,
                      builder: (BuildContext context,
                          AsyncSnapshot<AllPatientsResponseModel> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: screenSize!.width,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: GridView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                itemCount: 9,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade300,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: snapshot.data!.result!.length + 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == snapshot.data!.result!.length) {
                                return InkWell(
                                  onTap: () async {
                                    showLoaderDialog(context);
                                    await patientProvider.getStateMaster(context);
                                    patientProvider.clearAddPatientForm();
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                            context, Routes.addNewPatientRoute)
                                        .then((value) {
                                      setState(() {
                                        prefModel.userData!.roleId==2?patientProvider.getMyPatients(context):
                                        patientProvider
                                            .getEnterpriseProfiles(context);
                                      });
                                      return null;
                                    });
                                  },
                                  child: DottedBorder(
                                    dashPattern: const [2, 2],
                                    color: Colors.black,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(12),
                                    strokeWidth: 1,
                                    child: Container(
                                      color: Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.add),
                                            Text(
                                              prefModel.userData!.roleId == 2
                                                  ? AppLocale.newMember
                                                      .getString(context)
                                                  : prefModel.userData!
                                                              .roleId ==
                                                          3
                                                      ? AppLocale.newPatient
                                                          .getString(context)
                                                      : prefModel.userData!
                                                                  .roleId ==
                                                              4
                                                          ? AppLocale.newPlayer
                                                              .getString(
                                                                  context)
                                                          : "",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.patientDetailsRoute,arguments: {
                                      "id":snapshot.data!.result![index].id,
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        snapshot.data!.result![index]
                                                    .profilePicture !=
                                                null
                                            ? CircleAvatar(
                                                radius: 22,
                                                backgroundColor: Colors.grey,
                                                backgroundImage: NetworkImage(
                                                  snapshot.data!.result![index]
                                                      .profilePicture!.url
                                                      .toString(),
                                                ),
                                              )
                                            : const CircleAvatar(
                                                radius: 22,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            maxLines: 1,
                                            "${snapshot.data!.result![index].firstName!} ${snapshot.data!.result![index].lastName!}",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${patientProvider.calculateAge(snapshot.data!.result![index].contact!.doB.toString())} Years",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
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
                    )
                  : FutureBuilder(
                      future: patientProvider.enterprisePatients,
                      builder: (BuildContext context,
                          AsyncSnapshot<AllEnterpriseUsersResponseModel>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: screenSize!.width,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: GridView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                itemCount: 9,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade300,
                                  );
                                },
                              ),
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: snapshot.data!.result!.length + 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == snapshot.data!.result!.length) {
                                return InkWell(
                                  onTap: () async {
                                    showLoaderDialog(context);
                                    await patientProvider.getStateMaster(context);
                                    patientProvider.clearAddPatientForm();
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                            context, Routes.addNewPatientRoute)
                                        .then((value) {
                                      setState(() {
                                        prefModel.userData!.roleId==2?patientProvider.getMyPatients(context)
                                        :patientProvider
                                            .getEnterpriseProfiles(context);
                                      });
                                      return null;
                                    });
                                  },
                                  child: DottedBorder(
                                    dashPattern: const [2, 2],
                                    color: Colors.black,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(12),
                                    strokeWidth: 1,
                                    child: Container(
                                      color: Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.add),
                                            Text(
                                              prefModel.userData!.roleId == 2
                                                  ? AppLocale.newMember
                                                      .getString(context)
                                                  : prefModel.userData!
                                                              .roleId ==
                                                          3
                                                      ? AppLocale.newPatient
                                                          .getString(context)
                                                      : prefModel.userData!
                                                                  .roleId ==
                                                              4
                                                          ? AppLocale.newPlayer
                                                              .getString(
                                                                  context)
                                                          : "",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.patientDetailsRoute,arguments: {
                                      "id":snapshot.data!.result![index].id,
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        snapshot.data!.result![index]
                                                    .profilePicture !=
                                                null
                                            ? CircleAvatar(
                                                radius: 22,
                                                backgroundColor: Colors.grey,
                                                backgroundImage: NetworkImage(
                                                  snapshot.data!.result![index]
                                                      .profilePicture!.url
                                                      .toString(),
                                                ),
                                              )
                                            : const CircleAvatar(
                                                radius: 22,
                                                backgroundColor: Colors.grey,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            maxLines: 1,
                                            "${snapshot.data!.result![index].firstName!} ${snapshot.data!.result![index].lastName!}",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${patientProvider.calculateAge(snapshot.data!.result![index].contact!.doB.toString())} Years",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
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
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocale.allReports.getString(context),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      widget.changeScreen(1);
                      // Navigator.pushNamed(context, Routes.reportsRoute);
                    },
                    child: Row(
                      children: [
                        Text(
                          AppLocale.viewAll.getString(context),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (BuildContext context, TakeTestProvider takeTestProvider, Widget? child) {
                return FutureBuilder(
                  future: takeTestProvider.getMyReports('All Time','All reports'),
                  builder: (BuildContext context, AsyncSnapshot<MyReportsResponseModel> reportsSnapshot) {
                    if (reportsSnapshot.connectionState ==
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
                    if(reportsSnapshot.hasData){
                      return ListView.builder(
                        itemCount: reportsSnapshot.data!.result!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, Routes.detailedReportRoute,arguments: {
                                "requestDeviceDataId":reportsSnapshot.data!.result![index].id,
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
                                        backgroundImage: reportsSnapshot.data!.result![index].roleId==2?NetworkImage(reportsSnapshot.data!.result![index].individualProfile!.profilePicture!=null?reportsSnapshot.data!.result![index].individualProfile!.profilePicture!.url!:'')
                                            :NetworkImage(reportsSnapshot.data!.result![index].enterpriseProfile!.profilePicture!=null?reportsSnapshot.data!.result![index].enterpriseProfile!['profilePicture']['url']:''),
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
                                            reportsSnapshot.data!.result![index].roleId==2?
                                            "${reportsSnapshot.data!.result![index].individualProfile!.firstName!} ${reportsSnapshot.data!.result![index].individualProfile!.lastName!}"
                                                :reportsSnapshot.data!.result![index].enterpriseProfile!.firstName! + " " +reportsSnapshot.data!.result![index].enterpriseProfile!.lastName!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            reportsSnapshot.data!.result![index].roleId==2?
                                            "${calculateAge(reportsSnapshot.data!.result![index].individualProfile!.contact!.doB!)}Years":
                                            "${calculateAge(reportsSnapshot.data!.result![index].enterpriseProfile!.contact!.doB!)}Years",
                                            style: const TextStyle(
                                                color: Colors.black, fontSize: 12),
                                          ),
                                          const SizedBox(height: 5),
                                          // Text(
                                          //   patientReports[index]["description"],
                                          //   style: const TextStyle(
                                          //       color: Colors.black, fontSize: 12),
                                          // ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "${parseDate(reportsSnapshot.data!.result![index].requestDateTime!)}",
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
                                            color: getChipColor(reportsSnapshot.data!.result![index].processingStatus),
                                          ),
                                          child: Center(
                                            child: Text(
                                              reportsSnapshot.data!.result![index].processingStatus==1?AppLocale.newReport.getString(context):reportsSnapshot.data!.result![index].processingStatus==2?AppLocale.inProgress.getString(context):reportsSnapshot.data!.result![index].processingStatus==3?AppLocale.successReport.getString(context):reportsSnapshot.data!.result![index].processingStatus==4?AppLocale.failReport.getString(context):'',
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
                          );
                        },
                      );
                    }
                    if (reportsSnapshot.hasError) {
                      return Center(
                        child: Text(reportsSnapshot.error.toString()),
                      );
                    } else {
                      return  Center(child: Text(AppLocale.loading.getString(context)));
                    }
                  },
                );
              },
            )
          ],
        ),
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
