// To parse this JSON data, do
//
//     final roleMasterResponseModel = roleMasterResponseModelFromJson(jsonString);

import 'dart:convert';

RoleMasterResponseModel roleMasterResponseModelFromJson(String str) =>
    RoleMasterResponseModel.fromJson(json.decode(str));

String roleMasterResponseModelToJson(RoleMasterResponseModel data) =>
    json.encode(data.toJson());

class RoleMasterResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<Result>? result;
  dynamic errors;

  RoleMasterResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory RoleMasterResponseModel.fromJson(Map<String, dynamic> json) =>
      RoleMasterResponseModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        pageResult: json["pageResult"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "pageResult": pageResult,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "errors": errors,
      };
}

class Result {
  String? name;
  dynamic maximumMembers;
  dynamic profileName;
  String? uniqueGuid;
  int? id;

  Result({
    this.name,
    this.maximumMembers,
    this.profileName,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        maximumMembers: json["maximumMembers"],
        profileName: json["profileName"],
        uniqueGuid: json["uniqueGuid"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "maximumMembers": maximumMembers,
        "profileName": profileName,
        "uniqueGuid": uniqueGuid,
        "id": id,
      };
}
