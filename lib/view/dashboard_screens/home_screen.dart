import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:vicare/main.dart';
import 'package:vicare/routes.dart';
import 'package:vicare/utils/appcolors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndexPage = 0;

  List patientData = [
    {"patientName": "Tom Luke", "age": "25 years","image":"assets/images/img.png"},
    {"patientName": "Tom Luke", "age": "25 years","image":"assets/images/img.png"},
    {"patientName": "Tom Luke", "age": "25 years","image":"assets/images/img.png"},
    {"patientName": "Tom Luke", "age": "25 years","image":"assets/images/img.png"},
    {"patientName": "Tom Luke", "age": "25 years","image":"assets/images/img.png"},
    {"patientName": "Tom Luke", "age": "25 years","image":"assets/images/img.png"},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            color: AppColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                top: MediaQuery.of(context).size.height / 15,
                right: 15,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Albert Raj",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Lets unlock Your Heart Health Journey",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Color(0xffd9d9d9c2),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Recent reports",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height / 1.9,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                                       reverse: false,
                              autoPlay: true,
                              autoPlayInterval:
                              const Duration(seconds: 3),
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
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        width: screenSize!.width,
                        height: screenSize!.height/6,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: DotsIndicator(
                              dotsCount: 4,
                              position: currentIndexPage,
                              decorator: DotsDecorator(
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Patients",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                      Row(
                        children: [
                          InkWell(
                              onTap:(){Navigator.pushNamed(context, Routes.myPatientsRoute);},
                              child: const Text("View all",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
                          const SizedBox(width: 5,),
                          const Icon(Icons.navigate_next)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: patientData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.grey,
                                // backgroundImage: patientData[index]['image'],
                                radius: 20,
                              ),
                              Text(
                                patientData[index]['patientName']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                patientData[index]['age']!,
                                style: const TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("All Reports",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                      Row(
                        children: [
                          InkWell(
                              onTap:(){Navigator.pushNamed(context, Routes.myPatientsRoute);},
                              child: const Text("View all",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
                          const SizedBox(width: 5,),
                          const Icon(Icons.navigate_next)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
