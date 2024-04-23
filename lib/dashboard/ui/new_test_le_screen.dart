import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/provider/new_test_le_provider.dart';
import '../../create_patients/model/enterprise_response_model.dart';
import '../../create_patients/model/individual_response_model.dart';
import '../model/device_response_model.dart';
import '../model/duration_response_model.dart';

class NewTestLeScreen extends StatefulWidget {
  const NewTestLeScreen({super.key});

  @override
  State<NewTestLeScreen> createState() => _NewTestLeScreenState();
}

class _NewTestLeScreenState extends State<NewTestLeScreen> {
  EnterpriseResponseModel? enterprisePatientData;
  IndividualResponseModel? individualPatientData;
  Device? selectedDevice;
  DurationClass? selectedDuration;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    enterprisePatientData = arguments['enterprisePatientData'];
    individualPatientData = arguments['individualPatientData'];
    selectedDevice = arguments['selectedDevice'];
    selectedDuration = arguments['selectedDuration'];
    return  Consumer(
      builder: (BuildContext context, NewTestLeProvider newTestLeProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: Text("New Test"),),
          body: Text(newTestLeProvider.flutterBlue.state.toString()),
        );
      },
    );
  }
}
