// To parse this JSON data, do
//
//     final patientReportsResponseModel = patientReportsResponseModelFromJson(jsonString);

import 'dart:convert';

PatientReportsResponseModel patientReportsResponseModelFromJson(String str) => PatientReportsResponseModel.fromJson(json.decode(str));

String patientReportsResponseModelToJson(PatientReportsResponseModel data) => json.encode(data.toJson());

class PatientReportsResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<Result>? result;
  dynamic errors;

  PatientReportsResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory PatientReportsResponseModel.fromJson(Map<String, dynamic> json) => PatientReportsResponseModel(
    message: json["message"],
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
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
  User? user;
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
    user: json["user"] == null ? null : User.fromJson(json["user"]),
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
    "user": user?.toJson(),
    "individualProfileId": individualProfileId,
    "individualProfile": individualProfile,
    "enterpriseProfileId": enterpriseProfileId,
    "enterpriseProfile": enterpriseProfile,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}

class User {
  String? email;
  String? contactNumber;
  String? passwordHash;
  String? passwordSalt;
  dynamic type;
  int? status;
  dynamic remarks;
  dynamic token;
  int? contactId;
  dynamic contact;
  int? roleId;
  dynamic role;
  int? profilePictureId;
  dynamic profilePicture;
  dynamic enterpriseId;
  dynamic enterprise;
  dynamic enterpriseUserId;
  dynamic enterpriseUser;
  dynamic individualProfileId;
  String? uniqueGuid;
  int? id;

  User({
    this.email,
    this.contactNumber,
    this.passwordHash,
    this.passwordSalt,
    this.type,
    this.status,
    this.remarks,
    this.token,
    this.contactId,
    this.contact,
    this.roleId,
    this.role,
    this.profilePictureId,
    this.profilePicture,
    this.enterpriseId,
    this.enterprise,
    this.enterpriseUserId,
    this.enterpriseUser,
    this.individualProfileId,
    this.uniqueGuid,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    contactNumber: json["contactNumber"],
    passwordHash: json["passwordHash"],
    passwordSalt: json["passwordSalt"],
    type: json["type"],
    status: json["status"],
    remarks: json["remarks"],
    token: json["token"],
    contactId: json["contactId"],
    contact: json["contact"],
    roleId: json["roleId"],
    role: json["role"],
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"],
    enterpriseId: json["enterpriseId"],
    enterprise: json["enterprise"],
    enterpriseUserId: json["enterpriseUserId"],
    enterpriseUser: json["enterpriseUser"],
    individualProfileId: json["individualProfileId"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "contactNumber": contactNumber,
    "passwordHash": passwordHash,
    "passwordSalt": passwordSalt,
    "type": type,
    "status": status,
    "remarks": remarks,
    "token": token,
    "contactId": contactId,
    "contact": contact,
    "roleId": roleId,
    "role": role,
    "profilePictureId": profilePictureId,
    "profilePicture": profilePicture,
    "enterpriseId": enterpriseId,
    "enterprise": enterprise,
    "enterpriseUserId": enterpriseUserId,
    "enterpriseUser": enterpriseUser,
    "individualProfileId": individualProfileId,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
