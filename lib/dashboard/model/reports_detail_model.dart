// To parse this JSON data, do
//
//     final reportsDetailModel = reportsDetailModelFromJson(jsonString);

import 'dart:convert';

ReportsDetailModel reportsDetailModelFromJson(String str) => ReportsDetailModel.fromJson(json.decode(str));

String reportsDetailModelToJson(ReportsDetailModel data) => json.encode(data.toJson());

class ReportsDetailModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  Result? result;
  dynamic errors;

  ReportsDetailModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory ReportsDetailModel.fromJson(Map<String, dynamic> json) => ReportsDetailModel(
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
  dynamic name;
  int? reportStatus;
  String? reportDate;
  dynamic type;
  String? processedData;
  String? requestDateTime;
  String? processedDateTime;
  int? paymentStatus;
  String? errorType;
  String? errorMessage;
  int? totalRequest;
  int? remainingRequest;
  int? consumedRequest;
  int? processingStatus;
  int? subscriberId;
  String? status;
  int? roleId;
  dynamic role;
  int? requestDeviceDataId;
  dynamic requestDeviceData;
  int? userId;
  dynamic user;
  int? individualProfileId;
  dynamic individualProfile;
  dynamic enterpriseProfileId;
  dynamic enterpriseProfile;
  String? uniqueGuid;
  int? id;

  Result({
    this.name,
    this.reportStatus,
    this.reportDate,
    this.type,
    this.processedData,
    this.requestDateTime,
    this.processedDateTime,
    this.paymentStatus,
    this.errorType,
    this.errorMessage,
    this.totalRequest,
    this.remainingRequest,
    this.consumedRequest,
    this.processingStatus,
    this.subscriberId,
    this.status,
    this.roleId,
    this.role,
    this.requestDeviceDataId,
    this.requestDeviceData,
    this.userId,
    this.user,
    this.individualProfileId,
    this.individualProfile,
    this.enterpriseProfileId,
    this.enterpriseProfile,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    reportStatus: json["reportStatus"],
    reportDate: json["reportDate"],
    type: json["type"],
    processedData: json["processedData"],
    requestDateTime: json["requestDateTime"],
    processedDateTime: json["processedDateTime"],
    paymentStatus: json["paymentStatus"],
    errorType: json["errorType"],
    errorMessage: json["errorMessage"],
    totalRequest: json["totalRequest"],
    remainingRequest: json["remainingRequest"],
    consumedRequest: json["consumedRequest"],
    processingStatus: json["processingStatus"],
    subscriberId: json["subscriberId"],
    status: json["status"],
    roleId: json["roleId"],
    role: json["role"],
    requestDeviceDataId: json["requestDeviceDataId"],
    requestDeviceData: json["requestDeviceData"],
    userId: json["userId"],
    user: json["user"],
    individualProfileId: json["individualProfileId"],
    individualProfile: json["individualProfile"],
    enterpriseProfileId: json["enterpriseProfileId"],
    enterpriseProfile: json["enterpriseProfile"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "reportStatus": reportStatus,
    "reportDate": reportDate,
    "type": type,
    "processedData": processedData,
    "requestDateTime": requestDateTime,
    "processedDateTime": processedDateTime,
    "paymentStatus": paymentStatus,
    "errorType": errorType,
    "errorMessage": errorMessage,
    "totalRequest": totalRequest,
    "remainingRequest": remainingRequest,
    "consumedRequest": consumedRequest,
    "processingStatus": processingStatus,
    "subscriberId": subscriberId,
    "status": status,
    "roleId": roleId,
    "role": role,
    "requestDeviceDataId": requestDeviceDataId,
    "requestDeviceData": requestDeviceData,
    "userId": userId,
    "user": user,
    "individualProfileId": individualProfileId,
    "individualProfile": individualProfile,
    "enterpriseProfileId": enterpriseProfileId,
    "enterpriseProfile": enterpriseProfile,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
