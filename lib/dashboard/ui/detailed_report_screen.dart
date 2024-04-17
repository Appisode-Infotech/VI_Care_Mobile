
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';

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
    String? title = arguments['processedData'];
    int? requestDeviceDataId = arguments['requestDeviceDataId'];
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Detailed report"),
            actions: [
              IconButton(onPressed: (){
                takeTestProvider.getReportPdf(requestDeviceDataId,context);
              }, icon: const Icon(Icons.download))
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Text(title!),
            ),
          ),
        );
      },
    );
  }
}
