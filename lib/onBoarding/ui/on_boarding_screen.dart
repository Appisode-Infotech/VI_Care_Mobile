import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../main.dart';
import '../../utils/app_buttons.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndexPage = 0;

  List onBoardingTiles = [
    {
      "image": "assets/images/phone_case.png",
      "heading": "1. Connect, Measure \nand Thrive!",
      "description":
          "Join Hrudayin for a heart-healthy journey. \nConnect your device, measure your \nheart rate, and thrive with \npersonalized insights!"
    },
    {
      "image": "assets/images/phone_case.png",
      "heading": "2. Connect, Measure \nand Thrive!",
      "description":
          "Join Hrudayin for a heart-healthy journey. \nConnect your device, measure your \nheart rate, and thrive with \npersonalized insights!"
    },
    {
      "image": "assets/images/phone_case.png",
      "heading": "3. Connect, Measure \nand Thrive!",
      "description":
          "Join Hrudayin for a heart-healthy journey. \nConnect your device, measure your \nheart rate, and thrive with \npersonalized insights!"
    },
    {
      "image": "assets/images/phone_case.png",
      "heading": "4. Connect, Measure \nand Thrive!",
      "description":
          "Join Hrudayin for a heart-healthy journey. \nConnect your device, measure your \nheart rate, and thrive with \npersonalized insights!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SizedBox(
              width: screenSize!.width,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: screenSize!.width,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          height: screenSize!.height / 1.9,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndexPage = index;
                            });
                          },
                        ),
                        itemCount: onBoardingTiles.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image(
                                image: AssetImage(
                                    onBoardingTiles[itemIndex]['image']),
                              ));
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: DotsIndicator(
                        dotsCount: onBoardingTiles.length,
                        position: currentIndexPage,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 20,
                      child: GestureDetector(
                          onTap: () async {
                            await showLanguageBottomSheet(context,onLanguageChange);
                          },
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: Icon(Icons.g_translate)))),
                ],
              ),
            )),
            Container(
              width: screenSize!.width,
              height: screenSize!.height / 2.5,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 5, offset: Offset(4, 4)),
              ], color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      onBoardingTiles[currentIndexPage]['heading'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      onBoardingTiles[currentIndexPage]['description'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: getPrimaryAppButton(
                          context, AppLocale.getStartedBtnTitle.getString(context), onPressed: () {
                        Navigator.pushNamed(context, Routes.loginRoute);
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                        text: "Don't have an account ?",
                        style: TextStyle(
                          color: AppColors.fontShadeColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, Routes.registerRoute);
                          },
                        text: " Sign Up Now",
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  onLanguageChange(String languageCode) {
    localization.translate(languageCode);
  }
}
