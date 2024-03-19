import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/main.dart';
import 'package:vicare/network/api_calls.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class TakeTestScreen extends StatefulWidget {
  const TakeTestScreen({super.key});

  @override
  State<TakeTestScreen> createState() => _TakeTestScreenState();
}

class _TakeTestScreenState extends State<TakeTestScreen> {
  Timer? timer;
  int secondsRemaining = 0;
  bool isTimerRunning = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          isTimerRunning = false;
        }
      });
    });
  }

  Future<void> handleStartButtonClick(BuildContext context) async {
    if (!isTimerRunning) {
      isTimerRunning = true;
      startTimer();
    } else {
      bool userWantsToAbort = await showStopTestWarningDialog(context);
      if (userWantsToAbort) {
        timer!.cancel();
        secondsRemaining =
            (prefModel.selectedDuration!.durationInMinutes!) * 60;
        isTimerRunning = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (prefModel.selectedDuration != null) {
      secondsRemaining = (prefModel.selectedDuration!.durationInMinutes!) * 60;
    }
  }

  @override
  void dispose() {
    if(timer!=null){
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    Provider.of<TakeTestProvider>(context, listen: false)
        .listenToConnectedDevice();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocale.takeTest.getString(context),
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
          body: takeTestProvider.bluetoothStatus
              ? takeTestProvider.isConnected
                  ? prefModel.selectedDuration != null
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: screenSize!.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: AppColors.primaryColor),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: screenSize!.width * 0.6,
                                        child: Text(
                                          "Connected to : ${takeTestProvider.connectedDevice!.name}",
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          takeTestProvider.disconnect(context);
                                        },
                                        child: const Text(
                                              "Disconnect",
                                              style: TextStyle(
                                                  color: AppColors.scaffoldColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                      )
                                    ],
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 15.0,
                                  percent: ((prefModel.selectedDuration!
                                                      .durationInMinutes! *
                                                  60 -
                                              secondsRemaining) /
                                          (prefModel.selectedDuration!
                                                  .durationInMinutes! *
                                              60))
                                      .clamp(0.0, 1.0),
                                  center: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${(secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(secondsRemaining % 60).toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Navigator.pushNamed(context,
                                                      Routes.durationsRoute)
                                                  .then((value) {
                                                setState(() {
                                                  if (prefModel
                                                          .selectedDuration !=
                                                      null) {
                                                    secondsRemaining = (prefModel
                                                            .selectedDuration!
                                                            .durationInMinutes!) *
                                                        60;
                                                  }
                                                });
                                              });
                                            });
                                          },
                                          child: const Icon(
                                            Icons.timer_outlined,
                                            color: AppColors.primaryColor,
                                          ))
                                    ],
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: AppColors.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${takeTestProvider.heartRate.toString()} BPM',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  handleStartButtonClick(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    color: Colors.blue.shade300,
                                  ),
                                  child: Text(
                                    isTimerRunning
                                        ? AppLocale.stop.getString(context)
                                        : AppLocale.start.getString(context),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: AppColors.primaryColor,
                              ),
                              width: screenSize!.width,
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: screenSize!.width * 0.5,
                                      child: Text(
                                        AppLocale.chooseDurationMessage
                                            .getString(context),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.durationsRoute);
                                    },
                                    child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            color: Colors.white),
                                        child: Center(
                                          child: Text(
                                            AppLocale.chooseDuration
                                                .getString(context),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  )
                                ],
                              )),
                        )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: AppColors.primaryColor,
                          ),
                          width: screenSize!.width,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: screenSize!.width * 0.6,
                                  child: Text(
                                    AppLocale.noConnectedDevice
                                        .getString(context),
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.bluetoothScanRoute);
                                },
                                child: Container(
                                    width: screenSize!.width * 0.25,
                                    height: 50,
                                    padding: const EdgeInsets.all(12),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Colors.white),
                                    child: Center(
                                      child: Text(
                                        AppLocale.connect.getString(context),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              )
                            ],
                          )),
                    )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: AppColors.primaryColor,
                      ),
                      width: screenSize!.width,
                      height: 100,
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          AppLocale.bluetoothIsOff.getString(context),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
        );
      },
    );
  }
}
