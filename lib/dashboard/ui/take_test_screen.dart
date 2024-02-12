import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../utils/app_locale.dart';

class TakeTestScreen extends StatefulWidget {
  const TakeTestScreen({Key? key}) : super(key: key);

  @override
  State<TakeTestScreen> createState() => _TakeTestScreenState();
}

class _TakeTestScreenState extends State<TakeTestScreen> {
  late Timer _timer;
  int _secondsRemaining = 240;
  bool _isTimerRunning = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          _isTimerRunning = false;
        }
      });
    });
  }

  void _handleStartButtonClick() {
    setState(() {
      if (!_isTimerRunning) {
        _isTimerRunning = true;
        _startTimer();
      } else {
        _timer.cancel();
        _isTimerRunning = false;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (_secondsRemaining % 240) ~/ 60;
    int seconds = _secondsRemaining % 60;
    double percentFilled = (240 - _secondsRemaining) / 240.0;

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
                  '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
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
              onTap: _handleStartButtonClick,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: Colors.blue.shade300,
                ),
                child: Text(
                  _isTimerRunning
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
