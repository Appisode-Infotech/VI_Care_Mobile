import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class ManagePatientsScreen extends StatefulWidget {
  const ManagePatientsScreen({super.key});

  @override
  State<ManagePatientsScreen> createState() => _ManagePatientsScreenState();
}

class _ManagePatientsScreenState extends State<ManagePatientsScreen> {

  List patientData = [
    {
      "patientName": "Tom Luke",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Rhea",
      "age": "25 years",
      "image": "assets/images/img_1.png"
    },
    {
      "patientName": "Don dhalim",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Kiran deva",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Smitha",
      "age": "25 years",
      "image": "assets/images/img_1.png"
    },
    {
      "patientName": "Avinash",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
    {
      "patientName": "Varshini",
      "age": "25 years",
      "image": "assets/images/img_1.png"
    },
    {
      "patientName": "John sully",
      "age": "25 years",
      "image": "assets/images/img.png"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.managePatients.getString(context), style: const TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: Column(
          children: [
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: patientData.length + 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.addNewPatientRoute);
                    },
                    child:DottedBorder(
                    dashPattern: const [2,2],
                    color: Colors.black,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    strokeWidth: 1,
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.add),
                            Text(
                              AppLocale.newPatient.getString(context),
                              style: const TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  );
                } else {
                  final dataIndex = index - 1;
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.patientDetailsRoute);
                      },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
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
                            backgroundImage: AssetImage(patientData[dataIndex]['image']),
                            radius: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            patientData[dataIndex]['patientName']!,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            patientData[dataIndex]['age']!,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
