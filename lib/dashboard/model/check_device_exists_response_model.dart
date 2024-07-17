// To parse this JSON data, do
//
//     final checkDeviceExistsResponseModel = checkDeviceExistsResponseModelFromJson(jsonString);

import 'dart:convert';

CheckDeviceExistsResponseModel checkDeviceExistsResponseModelFromJson(String str) => CheckDeviceExistsResponseModel.fromJson(json.decode(str));

String checkDeviceExistsResponseModelToJson(CheckDeviceExistsResponseModel data) => json.encode(data.toJson());

class CheckDeviceExistsResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  Result? result;
  dynamic errors;

  CheckDeviceExistsResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory CheckDeviceExistsResponseModel.fromJson(Map<String, dynamic> json) => CheckDeviceExistsResponseModel(
    message: json["message"],
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "pageResult": pageResult,
    "result": result?.toJson(),
    "errors": errors,
  };
}

class Result {
  String? name;
  String? serialNumber;
  String? manufacturer;
  bool? isPaired;
  String? model;
  String? deviceKey;
  String? pairedDate;
  int? deviceStatus;
  String? description;
  double? purchaseCost;
  double? sellingCost;
  String? warrantyDuration;
  int? validity;
  int? deviceType;
  dynamic ipAddress;
  int? deviceCategory;
  int? allocationStatus;
  dynamic remarks;
  int? subscriberDeviceId;
  int? userId;
  dynamic user;
  int? subscriberId;
  dynamic subscriber;
  List<dynamic>? documents;
  String? uniqueGuid;
  int? id;

  Result({
    this.name,
    this.serialNumber,
    this.manufacturer,
    this.isPaired,
    this.model,
    this.deviceKey,
    this.pairedDate,
    this.deviceStatus,
    this.description,
    this.purchaseCost,
    this.sellingCost,
    this.warrantyDuration,
    this.validity,
    this.deviceType,
    this.ipAddress,
    this.deviceCategory,
    this.allocationStatus,
    this.remarks,
    this.subscriberDeviceId,
    this.userId,
    this.user,
    this.subscriberId,
    this.subscriber,
    this.documents,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    serialNumber: json["serialNumber"],
    manufacturer: json["manufacturer"],
    isPaired: json["isPaired"],
    model: json["model"],
    deviceKey: json["deviceKey"],
    pairedDate: json["pairedDate"],
    deviceStatus: json["deviceStatus"],
    description: json["description"],
    purchaseCost: json["purchaseCost"].toDouble(),
    sellingCost: json["sellingCost"].toDouble(),
    warrantyDuration: json["warrantyDuration"],
    validity: json["validity"],
    deviceType: json["deviceType"],
    ipAddress: json["ipAddress"],
    deviceCategory: json["deviceCategory"],
    allocationStatus: json["allocationStatus"],
    remarks: json["remarks"],
    subscriberDeviceId: json["subscriberDeviceId"],
    userId: json["userId"],
    user: json["user"],
    subscriberId: json["subscriberId"],
    subscriber: json["subscriber"],
    documents: json["documents"] == null ? [] : List<dynamic>.from(json["documents"]!.map((x) => x)),
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "serialNumber": serialNumber,
    "manufacturer": manufacturer,
    "isPaired": isPaired,
    "model": model,
    "deviceKey": deviceKey,
    "pairedDate": pairedDate,
    "deviceStatus": deviceStatus,
    "description": description,
    "purchaseCost": purchaseCost,
    "sellingCost": sellingCost,
    "warrantyDuration": warrantyDuration,
    "validity": validity,
    "deviceType": deviceType,
    "ipAddress": ipAddress,
    "deviceCategory": deviceCategory,
    "allocationStatus": allocationStatus,
    "remarks": remarks,
    "subscriberDeviceId": subscriberDeviceId,
    "userId": userId,
    "user": user,
    "subscriberId": subscriberId,
    "subscriber": subscriber,
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
