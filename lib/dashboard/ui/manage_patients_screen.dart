import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vicare/create_patients/model/all_patients_response_model.dart';
import 'package:vicare/create_patients/provider/patient_provider.dart';
import 'package:vicare/main.dart';

import '../../create_patients/model/all_enterprise_users_response_model.dart';
import '../../network/api_calls.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class ManagePatientsScreen extends StatefulWidget {
  const ManagePatientsScreen({super.key});

  @override
  State<ManagePatientsScreen> createState() => _ManagePatientsScreenState();
}

class _ManagePatientsScreenState extends State<ManagePatientsScreen> {

  @override
  void didChangeDependencies() {
    Provider.of<PatientProvider>(context, listen: false).getMyPatients(context);
    Provider.of<PatientProvider>(context, listen: false).getEnterpriseProfiles(context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, PatientProvider patientProvider, Widget? child) {
        patientProvider.relGetPatientContext = context;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              prefModel.userData!.roleId == 2
                  ? AppLocale.manageMembers.getString(context)
                  : prefModel.userData!.roleId == 3
                      ? AppLocale.managePatients.getString(context)
                      : prefModel.userData!.roleId == 4
                          ? AppLocale.managePlayers.getString(context)
                          : "",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 75,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: prefModel.userData!.roleId == 2
                ? FutureBuilder(
                    future: patientProvider.individualPatients,
                    builder: (BuildContext context, AsyncSnapshot<AllPatientsResponseModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            width: screenSize!.width,
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  itemCount: 9,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey.shade300,
                                    );
                                  },
                                )));
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
                            if (index == 0) {
                              return InkWell(
                                onTap: () {
                                  patientProvider.clearAddPatientForm();
                                  Navigator.pushNamed(context, Routes.addNewPatientRoute).then((value) {
                                    setState(() {
                                      patientProvider.getMyPatients(context);
                                      patientProvider.getEnterpriseProfiles(context);
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
                                                : prefModel.userData!.roleId ==
                                                        3
                                                    ? AppLocale.newPatient
                                                        .getString(context)
                                                    : prefModel.userData!
                                                                .roleId ==
                                                            4
                                                        ? AppLocale.newPlayer
                                                            .getString(context)
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
                              index = index - 1;
                              return InkWell(
                                onTap: ()  {
                                  patientProvider.getIndividualUserData(
                                      snapshot.data!.result![index].id.toString(),
                                      context);
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Text(
                                        maxLines: 1,
                                        "${snapshot.data!.result![index].firstName!} ${snapshot.data!.result![index].lastName!}",
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.white),
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
                        return const Center(child: Text("loading"));
                      }
                    },
                  )
                : FutureBuilder(
                    future: patientProvider.enterprisePatients,
                    builder: (BuildContext context,
                        AsyncSnapshot<AllEnterpriseUsersResponseModel>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            width: screenSize!.width,
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  itemCount: 9,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey.shade300,
                                    );
                                  },
                                )));
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
                            if (index == 0) {
                              return InkWell(
                                onTap: () {
                                  patientProvider.clearAddPatientForm();
                                  Navigator.pushNamed(context, Routes.addNewPatientRoute).then((value) {
                                    setState(() {
                                      patientProvider.getMyPatients(context);
                                      patientProvider.getEnterpriseProfiles(context);
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
                                                : prefModel.userData!.roleId ==
                                                        3
                                                    ? AppLocale.newPatient
                                                        .getString(context)
                                                    : prefModel.userData!
                                                                .roleId ==
                                                            4
                                                        ? AppLocale.newPlayer
                                                            .getString(context)
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
                              index = index - 1;
                              return InkWell(
                                onTap: () async {
                                  patientProvider.getEnterpriseUserData(
                                      snapshot.data!.result![index].id.toString(),
                                      context);
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          maxLines: 2,
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
                        return const Center(child: Text("loading"));
                      }
                    },
                  ),
          ),
        );
      },
    );
  }
}
