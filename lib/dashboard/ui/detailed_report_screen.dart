
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vicare/dashboard/model/reports_detail_model.dart';
import 'package:vicare/dashboard/model/reports_processed_data_model.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';

import '../../main.dart';

class DetailedReportScreen extends StatefulWidget {
  const DetailedReportScreen({Key? key}) : super(key: key);

  @override
  State<DetailedReportScreen> createState() => _DetailedReportScreenState();
}

class _DetailedReportScreenState extends State<DetailedReportScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    int? requestDeviceDataId = arguments['requestDeviceDataId'];
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Detailed report"),
            actions: [
              IconButton(onPressed: (){
                // takeTestProvider.downloadReportPdf(snapshot.data!.result![0].url!,context);
              }, icon: const Icon(Icons.download))
            ],
          ),
          body: FutureBuilder(
            future: takeTestProvider.getReportDetails(requestDeviceDataId,context),
            builder: (BuildContext context, AsyncSnapshot<ReportsDetailModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: screenSize!.width,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: ListView.builder(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: 100,
                          height: 80,
                          color: Colors.grey.shade300,
                        );
                      },
                    ),
                  ),
                );
              }
              if(snapshot.hasData){
                ReportsProcessedDataModel processedData =  ReportsProcessedDataModel.fromJson(jsonDecode(snapshot.data!.result!.processedData!));
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(snapshot.data!.result!.processedDateTime.toString()),
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(
                                  Radius.circular(20)),
                              color: getChipColor(snapshot.data!.result!.processingStatus),
                            ),
                            child: Center(
                              child: Text(
                                snapshot.data!.result!.processingStatus==1?'New':snapshot.data!.result!.processingStatus==2?'In Progress':snapshot.data!.result!.processingStatus==3?'Success':snapshot.data!.result!.processingStatus==4?'Fail':'',
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
                      Text(processedData.toJson().toString()),
                    ],
                  )
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(child: Text("loading"));
              }
            },
          ),
        );
      },
    );
  }
  getChipColor(int? processingStatus) {
    return processingStatus==1?Colors.deepOrange:processingStatus==2?Colors.teal:processingStatus==3?Colors.green:processingStatus==4?Colors.red:Colors.black;
  }
}
