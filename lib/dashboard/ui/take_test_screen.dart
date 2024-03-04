import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vicare/network/api_calls.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../utils/app_locale.dart';

class TakeTestScreen extends StatefulWidget {

  const TakeTestScreen({super.key});

  @override
  State<TakeTestScreen> createState() => _TakeTestScreenState();
}

class _TakeTestScreenState extends State<TakeTestScreen> {
  late Timer timer;
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

  void handleStartButtonClick() {
    setState(() {
      if (!isTimerRunning) {
        isTimerRunning = true;
        startTimer();
      } else {
        timer.cancel();
        isTimerRunning = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if(prefModel.selectedDuration!=null){
      secondsRemaining = (prefModel.selectedDuration!.durationInMinutes!)*60;
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percentFilled = ((prefModel.selectedDuration!.durationInMinutes!*60) - secondsRemaining) / 480.0;

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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 15.0,
                percent: percentFilled,
                center: Text(
                  '${(secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(secondsRemaining % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "- Bpm",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: handleStartButtonClick,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: Colors.blue.shade300,
                ),
                child: Text(
                  isTimerRunning
                      ? AppLocale.stop.getString(context)
                      : AppLocale.start.getString(context),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
