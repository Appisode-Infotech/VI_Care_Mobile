
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';

import '../../main.dart';
import '../model/detailed_report_ddf_model.dart';

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
        return FutureBuilder(
          future: takeTestProvider.getReportDetails(requestDeviceDataId,context),
          builder: (BuildContext context, AsyncSnapshot<DetailedReportPdfModel> snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(),
                body: SizedBox(
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
                ),
              );
            }
            if(snapshot.hasData){
              return Scaffold(
                appBar: AppBar(
                  title: Text("Detailed report"),
                  actions: [
                    IconButton(onPressed: (){
                      takeTestProvider.downloadReportPdf(snapshot.data!.result![0].url!,context);
                    }, icon: const Icon(Icons.download))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Text(snapshot.data!.toJson().toString()),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              return Scaffold(body: const Center(child: Text("loading")));
            }
          },
        );
      },
    );
  }
}
