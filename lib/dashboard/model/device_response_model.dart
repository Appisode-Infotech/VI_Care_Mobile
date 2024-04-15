// To parse this JSON data, do
//
//     final deviceResponseModel = deviceResponseModelFromJson(jsonString);

import 'dart:convert';

DeviceResponseModel deviceResponseModelFromJson(String str) => DeviceResponseModel.fromJson(json.decode(str));

String deviceResponseModelToJson(DeviceResponseModel data) => json.encode(data.toJson());

class DeviceResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<DeviceResult>? result;
  dynamic errors;

  DeviceResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory DeviceResponseModel.fromJson(Map<String, dynamic> json) => DeviceResponseModel(
    message: json["message"],
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"],
    result: json["result"] == null ? [] : List<DeviceResult>.from(json["result"]!.map((x) => DeviceResult.fromJson(x))),
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "pageResult": pageResult,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "errors": errors,
  };
}

class DeviceResult {
  int? id;
  String? deviceSerialNo;

  DeviceResult({
    this.id,
    this.deviceSerialNo,
  });

  factory DeviceResult.fromJson(Map<String, dynamic> json) => DeviceResult(
    id: json["id"],
    deviceSerialNo: json["deviceSerialNo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deviceSerialNo": deviceSerialNo,
  };
}
