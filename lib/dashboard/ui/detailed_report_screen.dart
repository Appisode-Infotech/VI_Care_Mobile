import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Detailed report"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text(title!),
        ),
      ),
    );
  }
}
