import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndexPage = 1;

  List patientData = [
    {
      "patientName": "Tom Luke",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Tom Luke",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Tom Luke",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Tom Luke",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Tom Luke",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Tom Luke",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
  ];

  List patientReports = [
    {
      "image": "assets/images/img.png",
      "patientName": "Tom Robinson",
      "age": "25 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": true,
      "repData": {
        "status": "Normal",
        "bpm": "117",
        "color": Colors.green,
      },
      "reportStatus": "pending"
    },
    {
      "image": "assets/images/img.png",
      "patientName": "Tom Robinson",
      "age": "25 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": true,
      "repData": {
        "status": "Normal",
        "bpm": "117",
        "color": Colors.green,
      },
      "reportStatus": "pending"
    },
    {
      "image": "assets/images/img.png",
      "patientName": "Tom Robinson",
      "age": "25 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": true,
      "repData": {
        "status": "Normal",
        "bpm": "117",
        "color": Colors.green,
      },
      "reportStatus": "pending"
    },
    {
      "image": "assets/images/img.png",
      "patientName": "Tom Robinson",
      "age": "25 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": false,
      "repData": {
        "status": "Normal",
        "bpm": "117",
        "color": Colors.green,
      },
      "reportStatus": "pending"
    },
    {
      "image": "assets/images/img.png",
      "patientName": "Tom Robinson",
      "age": "25 years",
      "description": "Some data goes here",
      "created": "12 Mar 2024",
      "receivedReport": true,
      "repData": {
        "status": "Normal",
        "bpm": "117",
        "color": Colors.green,
      },
      "reportStatus": "pending"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi Albert Raj", style: TextStyle(color: Colors.white)),
            Text("Let's unlock your heart health journey",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
        actions: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                width: screenSize!.width,
                height: screenSize!.height / 4,
                color: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Recent reports",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: PageView.builder(
                        padEnds: false,
                        pageSnapping: true,
                        controller: PageController(viewportFraction: .85),
                        onPageChanged: (index) {
                          setState(() {
                            currentIndexPage = index;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: patientReports.length,
                        physics: const PageScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          patientReports[index]["image"]),
                                      radius: 30,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          patientReports[index]["patientName"],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          patientReports[index]["age"],
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 12),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          patientReports[index]["description"],
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 10),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "created: ${patientReports[index]["created"]}",
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  child: (patientReports[index]
                                              ["receivedReport"] ==
                                          true)
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Stack(
                                                children: [
                                                  CircularStepProgressIndicator(
                                                    totalSteps: 200,
                                                    currentStep: int.parse(
                                                        patientReports[index]
                                                            ["repData"]["bpm"]),
                                                    stepSize: 5,
                                                    selectedColor:
                                                        patientReports[index]
                                                                ["repData"]
                                                            ["color"],
                                                    unselectedColor:
                                                        Colors.grey[200],
                                                    padding: 0,
                                                    selectedStepSize: 6,
                                                    roundedCap: (_, __) => true,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      patientReports[index]
                                                          ["repData"]["bpm"],
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              patientReports[index]["repData"]
                                                  ["status"],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: patientReports[index]
                                                      ["repData"]["color"]),
                                            )
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                color: patientReports[index]
                                                    ['repData']["color"],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  patientReports[index]
                                                      ["reportStatus"],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: DotsIndicator(
                        dotsCount: 5,
                        position: currentIndexPage,
                        decorator: DotsDecorator(
                          activeColor: Colors.white,
                          color: const Color(0xFFD9D9D9),
                          size: const Size.square(9.0),
                          activeSize: const Size(30.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Patients",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: patientData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return (index + 1) == patientData.length
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.white,
                          ),
                          child: DottedBorder(
                            dashPattern: const [6, 3, 2, 3],
                            color: Colors.black,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            strokeWidth: 1,
                            child: const Center(
                                child: Text(
                              "Add New \nPatient",
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            )),
                          ))
                      : Container(
                          padding: const EdgeInsets.all(12),
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: AppColors.primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                // backgroundColor: Colors.grey,
                                backgroundImage:
                                    AssetImage(patientData[index]['image']),
                                radius: 20,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                patientData[index]['patientName']!,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                patientData[index]['age']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        );
                }),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "All reports",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Text(
                        "View all",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
