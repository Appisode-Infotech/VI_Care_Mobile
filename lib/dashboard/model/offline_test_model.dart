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
  int? myUserId;
  int? myRoleId;
  List<int>? bpmList;
  List<int>? rrIntervalList;
  int? scanDuration;
  String? scanDurationName;
  String? deviceName;
  String? deviceId;
  int? userAndDeviceId;
  int? selectedDurationId;
  EnterpriseResponseModel? enterprisePatientData;
  IndividualResponseModel? individualPatientData;
  DateTime? created;

  OfflineTestModel({
    this.myUserId,
    this.myRoleId,
    this.bpmList,
    this.rrIntervalList,
    this.scanDuration,
    this.scanDurationName,
    this.deviceName,
    this.deviceId,
    this.userAndDeviceId,
    this.selectedDurationId,
    this.enterprisePatientData,
    this.individualPatientData,
    this.created,
  });

  factory OfflineTestModel.fromJson(Map<String, dynamic> json) =>
      OfflineTestModel(
        myUserId: json["myUserId"],
        myRoleId: json["MyRoleId"],
        bpmList: json["bpmList"] == null
            ? []
            : List<int>.from(json["bpmList"]!.map((x) => x)),
        rrIntervalList: json["rrIntervalList"] == null
            ? []
            : List<int>.from(json["rrIntervalList"]!.map((x) => x)),
        scanDuration: json["scanDuration"],
        scanDurationName: json["scanDurationName"],
        deviceName: json["deviceName"],
        deviceId: json["deviceId"],
        userAndDeviceId: json["userAndDeviceId"],
        selectedDurationId: json["selectedDurationId"],
        enterprisePatientData: json["enterprisePatientData"] == null
            ? null
            : EnterpriseResponseModel.fromJson(json["enterprisePatientData"]),
        individualPatientData: json["individualPatientData"] == null
            ? null
            : IndividualResponseModel.fromJson(json["individualPatientData"]),
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "myUserId": myUserId,
        "MyRoleId": myRoleId,
        "bpmList":
            bpmList == null ? [] : List<dynamic>.from(bpmList!.map((x) => x)),
        "rrIntervalList": rrIntervalList == null
            ? []
            : List<dynamic>.from(rrIntervalList!.map((x) => x)),
        "scanDuration": scanDuration,
        "scanDurationName": scanDurationName,
        "deviceName": deviceName,
        "deviceId": deviceId,
        "userAndDeviceId": userAndDeviceId,
        "selectedDurationId": selectedDurationId,
        "enterprisePatientData": enterprisePatientData?.toJson(),
        "individualPatientData": individualPatientData?.toJson(),
        "created": created?.toIso8601String(),
      };
}
