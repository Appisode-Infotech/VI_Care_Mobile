import 'package:flutter/material.dart';
import '../../create_patients/model/enterprise_response_model.dart';
import '../../create_patients/model/individual_response_model.dart';
import '../model/device_response_model.dart';
import '../model/duration_response_model.dart';

class NewTestScreen extends StatefulWidget {
  const NewTestScreen({super.key});

  @override
  State<NewTestScreen> createState() => _NewTestScreenState();
}

class _NewTestScreenState extends State<NewTestScreen> {
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
    return  Scaffold(
      appBar: AppBar(title: Text("New Test"),),
    );
  }
}
