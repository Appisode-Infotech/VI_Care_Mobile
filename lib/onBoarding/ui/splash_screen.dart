
import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  moveToNextPage(BuildContext context){
    Timer(const Duration(seconds: 3),(){
      Navigator.pushNamedAndRemoveUntil(context, Routes.onBoardingRoute, (route) => false);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    moveToNextPage(context);
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'), width: 140,
        ),
      ),
    );
  }
}
