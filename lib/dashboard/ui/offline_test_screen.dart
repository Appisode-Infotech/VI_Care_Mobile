import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';

class OfflineTestScreen extends StatefulWidget {
  const OfflineTestScreen({super.key});

  @override
  State<OfflineTestScreen> createState() => _OfflineTestScreenState();
}

class _OfflineTestScreenState extends State<OfflineTestScreen> {

  List offlineTestData=[
    {
      "image":"assets/images/img_1.png",
      "patientName": "Meena",
      "age": "25 years",
      "created": "12 Mar 2024",
    },
    {
      "image":"assets/images/img.png",
      "patientName": "Tom robbinson",
      "age": "27 years",
      "created": "25 Mar 2024",
    },
  ];

  void deleteItem(int index) {
    setState(() {
      offlineTestData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text(AppLocale.offlineTests.getString(context), style: const TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 75,
        leading: IconButton(icon: const Icon(Icons.arrow_back,color: Colors.white,), onPressed: () { Navigator.pop(context); },),
      ),

      body:Padding(
        padding:const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: offlineTestData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius:
                      BorderRadius.all(Radius.circular(12)),
                      color: Colors.white),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            offlineTestData[index]["image"]),
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
                            offlineTestData[index]["patientName"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            offlineTestData[index]["age"],
                            style: const TextStyle(
                                color: AppColors.fontShadeColor, fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "created: ${offlineTestData[index]["created"]}",
                            style: const TextStyle(
                                color: AppColors.fontShadeColor, fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                             Row(
                              children:[
                                 Row(
                                  children: [
                                    const Icon(Icons.refresh_outlined,color: AppColors.primaryColor,size: 18,),
                                    const SizedBox(width: 3,),
                                    Text(AppLocale.retryUpload.getString(context),style: const TextStyle(fontSize: 12,color: AppColors.primaryColor),)
                                  ],
                                ),
                                const SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: (){
                                    deleteItem(index);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.delete_outline,color: Colors.red,size: 18,),
                                      Text(AppLocale.delete.getString(context),style: const TextStyle(fontSize: 12,color: Colors.red),)
                                  ],
                                  ),
                                ),
                            ]
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
              ],
            );
          },
        ),
      )
    );
  }
}
