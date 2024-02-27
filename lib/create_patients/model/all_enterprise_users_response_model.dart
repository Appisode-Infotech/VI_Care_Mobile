// To parse this JSON data, do
//
//     final allEnterpriseUsersResponseModel = allEnterpriseUsersResponseModelFromJson(jsonString);

import 'dart:convert';

AllEnterpriseUsersResponseModel allEnterpriseUsersResponseModelFromJson(String str) => AllEnterpriseUsersResponseModel.fromJson(json.decode(str));

String allEnterpriseUsersResponseModelToJson(AllEnterpriseUsersResponseModel data) => json.encode(data.toJson());

class AllEnterpriseUsersResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<Result>? result;
  dynamic errors;

  AllEnterpriseUsersResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory AllEnterpriseUsersResponseModel.fromJson(Map<String, dynamic> json) => AllEnterpriseUsersResponseModel(
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
