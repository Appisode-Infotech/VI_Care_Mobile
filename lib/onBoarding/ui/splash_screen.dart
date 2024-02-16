import 'dart:async';

import 'package:flutter/material.dart';

import '../../network/api_calls.dart';
import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (prefModel.userData == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.onBoardingRoute, (route) => false);
      } else {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
        }
      }
    });
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
