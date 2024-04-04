// To parse this JSON data, do
//
//     final offlineTestModel = offlineTestModelFromJson(jsonString);

import 'dart:convert';

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
  String? patientFirstName;
  String? patientlastName;
  String? patientProfilePic;
  int? patientId;
  DateTime? created;


  OfflineTestModel({
    this.myRoleId,
    this.bpmList,
    this.rrIntervalList,
    this.scanDuration,
    this.deviceName,
    this.deviceId,
    this.patientFirstName,
    this.patientlastName,
    this.patientProfilePic,
    this.patientId,
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
        patientFirstName: json["patientFirstName"],
        patientlastName: json["patientlastName"],
        patientProfilePic: json["patientProfilePic"],
        patientId: json["patientId"],
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
        "patientFirstName": patientFirstName,
        "patientlastName": patientlastName,
        "patientProfilePic": patientProfilePic,
        "patientId": patientId,
    "created": created?.toIso8601String(),

  };
}
