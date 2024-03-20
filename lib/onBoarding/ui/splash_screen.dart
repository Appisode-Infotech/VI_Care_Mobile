import 'dart:async';

import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  moveToCorrespondingScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (prefModel.userData == null) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
        }
      } else {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    moveToCorrespondingScreen(context);
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
          width: 140,
        ),
      ),
    );
  }
}
