// To parse this JSON data, do
//
//     final enterpriseResponseModel = enterpriseResponseModelFromJson(jsonString);

import 'dart:convert';

EnterpriseResponseModel enterpriseResponseModelFromJson(String str) => EnterpriseResponseModel.fromJson(json.decode(str));

String enterpriseResponseModelToJson(EnterpriseResponseModel data) => json.encode(data.toJson());

class EnterpriseResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  Result? result;
  dynamic errors;

  EnterpriseResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory EnterpriseResponseModel.fromJson(Map<String, dynamic> json) => EnterpriseResponseModel(
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
  String? firstName;
  String? lastName;
  String? emailId;
  int? contactId;
  dynamic contact;
  int? profilePictureId;
  dynamic profilePicture;
  int? enterpriseUserId;
  String? uniqueGuid;
  int? id;

  Result({
    this.firstName,
    this.lastName,
    this.emailId,
    this.contactId,
    this.contact,
    this.profilePictureId,
    this.profilePicture,
    this.enterpriseUserId,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    contactId: json["contactId"],
    contact: json["contact"],
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"],
    enterpriseUserId: json["enterpriseUserId"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "emailId": emailId,
    "contactId": contactId,
    "contact": contact,
    "profilePictureId": profilePictureId,
    "profilePicture": profilePicture,
    "enterpriseUserId": enterpriseUserId,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
