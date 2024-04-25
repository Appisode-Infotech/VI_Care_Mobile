// To parse this JSON data, do
//
//     final offlineTestModel = offlineTestModelFromJson(jsonString);

import 'dart:convert';

import '../../create_patients/model/enterprise_response_model.dart';
import '../../create_patients/model/individual_response_model.dart';

OfflineTestModel offlineTestModelFromJson(String str) =>
    OfflineTestModel.fromJson(json.decode(str));

String offlineTestModelToJson(OfflineTestModel data) =>
    json.encode(data.toJson());

class OfflineTestModel {
  int? myRoleId;
  List<int>? bpmList;
  List<int>? rrIntervalList;
  int? scanDuration;
  String? deviceName;
  String? deviceId;
  EnterpriseResponseModel? enterprisePatientData;
  IndividualResponseModel? individualPatientData;
  DateTime? created;


  OfflineTestModel({
    this.myRoleId,
    this.bpmList,
    this.rrIntervalList,
    this.scanDuration,
    this.deviceName,
    this.deviceId,
    this.enterprisePatientData,
    this.individualPatientData,
    this.created,
  });

  factory OfflineTestModel.fromJson(Map<String, dynamic> json) =>
      OfflineTestModel(
        myRoleId: json["MyRoleId"],
        bpmList: json["bpmList"] == null
            ? []
            : List<int>.from(json["bpmList"]!.map((x) => x)),
        rrIntervalList: json["rrIntervalList"] == null
            ? []
            : List<int>.from(
                json["rrIntervalList"]!.map((x) => x)),
        scanDuration: json["scanDuration"],
        deviceName: json["deviceName"],
        deviceId: json["deviceId"],
        enterprisePatientData: json["enterprisePatientData"]== null ? null :EnterpriseResponseModel.fromJson(json["enterprisePatientData"]),
        individualPatientData: json["individualPatientData"]== null ? null :IndividualResponseModel.fromJson(json["individualPatientData"]),
        created: json["created"] == null ? null : DateTime.parse(json["created"]),

      );

  Map<String, dynamic> toJson() => {
        "MyRoleId": myRoleId,
        "bpmList":
            bpmList == null ? [] : List<dynamic>.from(bpmList!.map((x) => x)),
        "rrIntervalList": rrIntervalList == null
            ? []
            : List<dynamic>.from(rrIntervalList!.map((x) => x)),
        "scanDuration": scanDuration,
        "deviceName": deviceName,
        "deviceId": deviceId,
        "enterprisePatientData": enterprisePatientData?.toJson(),
        "individualPatientData": individualPatientData?.toJson(),
    "created": created?.toIso8601String(),

  };
}
