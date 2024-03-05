import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vicare/dashboard/provider/devices_provider.dart';
import 'package:vicare/database/app_pref.dart';
import 'package:vicare/network/api_calls.dart';

import '../../main.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../model/duration_response_model.dart';

class DurationScreen extends StatefulWidget {
  const DurationScreen({super.key});

  @override
  State<DurationScreen> createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, DeviceProvider deviceProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocale.duration.getString(context),
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
          body: FutureBuilder(
            future: deviceProvider.getAllDuration(),
            builder: (BuildContext context,
                AsyncSnapshot<DurationResponseModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: screenSize!.width,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          height: 100,
                          width: screenSize!.width,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          height: 100,
                          width: screenSize!.width,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          height: 100,
                          width: screenSize!.width,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                return ListView.separated(
                    itemCount: snapshot.data!.result!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            prefModel.selectedDuration =
                                snapshot.data!.result![index];
                            AppPref.setPref(prefModel);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: prefModel.selectedDuration == null
                                      ? Colors.white
                                      : prefModel.selectedDuration!.id ==
                                              snapshot.data!.result![index].id
                                          ? AppColors.primaryColor
                                          : Colors.white),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.result![index].name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "${snapshot.data!.result![index].durationInMinutes!} ${AppLocale.minutes.getString(context)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider());
                    });
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
}
