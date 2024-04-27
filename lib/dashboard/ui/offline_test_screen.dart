import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';

import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';

class OfflineTestScreen extends StatefulWidget {
  const OfflineTestScreen({super.key});

  @override
  State<OfflineTestScreen> createState() => _OfflineTestScreenState();
}

class _OfflineTestScreenState extends State<OfflineTestScreen> {
  @override
  Widget build(BuildContext context) {
    PrefModel offlinePrefModel = AppPref.getPref();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocale.offlineTests.getString(context),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: offlinePrefModel.offlineSavedTests!.isNotEmpty
              ? ListView.builder(
                  itemCount: offlinePrefModel.offlineSavedTests!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: screenSize!.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // CircleAvatar(
                              //   backgroundImage:
                              //       AssetImage(offlineTestData[index]["image"]),
                              //   radius: 30,
                              // ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: screenSize!.width - 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (offlinePrefModel.offlineSavedTests![index].individualPatientData!=null && offlinePrefModel.offlineSavedTests![index].enterprisePatientData!=null)?
                                    Column(
                                      children: [
                                        offlinePrefModel.offlineSavedTests![index].myRoleId==2?Text("${offlinePrefModel.offlineSavedTests![index].individualPatientData!.result!.firstName!} ${offlinePrefModel.offlineSavedTests![index].individualPatientData!.result!.lastName!}"):
                                        Text("${offlinePrefModel.offlineSavedTests![index].enterprisePatientData!.result!.firstName!} ${offlinePrefModel.offlineSavedTests![index].enterprisePatientData!.result!.lastName!}"),
                                      ],
                                    ):Center(child: Column(
                                      children: [
                                         Text(AppLocale.noProfileLinked.getString(context)),
                                        TextButton(onPressed: (){}, child: const Text("Link now"))
                                      ],
                                    ),),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${AppLocale.created.getString(context)}: ${offlinePrefModel.offlineSavedTests![index].created}",
                                      style: const TextStyle(
                                          color: AppColors.fontShadeColor,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.refresh_outlined,
                                            color: AppColors.primaryColor,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            AppLocale.retryUpload
                                                .getString(context),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: AppColors.primaryColor),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            offlinePrefModel.offlineSavedTests!.removeAt(index);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                            Text(
                                              AppLocale.delete
                                                  .getString(context),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                    ])
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
                )
              :  Center(
                  child: Text(
                    AppLocale.noSavedYet.getString(context),
                    style: TextStyle(
                        fontSize: 18, color: AppColors.fontShadeColor),
                  ),
                ),
        ));
  }

}
