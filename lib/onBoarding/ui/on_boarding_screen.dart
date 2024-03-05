import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:vicare/auth/auth_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.onBoardingScreenContext = context;
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
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                      const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: const Image(
                                        image: AssetImage(
                                            "assets/images/phone_case.png"),
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
                                dotsCount: 4,
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
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          border: Border.all(
                                              color: AppColors.primaryColor)),
                                      child: const Icon(Icons.g_translate)))),
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
                          AppLocale.connectMeasure.getString(context),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            AppLocale.joinHruday.getString(context),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: getPrimaryAppButton(
                              context, AppLocale.getStartedBtnTitle.getString(context), onPressed: () async{
                            Navigator.pushNamed(context, Routes.loginRoute);
                          }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                              text:  AppLocale.dntHaveAnAccount.getString(context) ,
                              style: const TextStyle(
                                color: AppColors.fontShadeColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  authProvider.getRoleMasters(context);
                                },
                              text: AppLocale.signUpNow.getString(context),
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ])),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  onLanguageChange(String languageCode) {
    localization.translate(languageCode);
  }
}
