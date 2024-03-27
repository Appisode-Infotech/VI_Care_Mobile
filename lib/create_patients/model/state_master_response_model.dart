// To parse this JSON data, do
//
//     final stateMasterResponseModel = stateMasterResponseModelFromJson(jsonString);

import 'dart:convert';

StateMasterResponseModel stateMasterResponseModelFromJson(String str) => StateMasterResponseModel.fromJson(json.decode(str));

String stateMasterResponseModelToJson(StateMasterResponseModel data) => json.encode(data.toJson());

class StateMasterResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<Result>? result;
  dynamic errors;

  StateMasterResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory StateMasterResponseModel.fromJson(Map<String, dynamic> json) => StateMasterResponseModel(
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
  String? name;
  String? code;
  dynamic numericCode;
  int? countryId;
  dynamic country;
  String? uniqueGuid;
  int? id;

  Result({
    this.name,
    this.code,
    this.numericCode,
    this.countryId,
    this.country,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    code: json["code"],
    numericCode: json["numericCode"],
    countryId: json["countryId"],
    country: json["country"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "numericCode": numericCode,
    "countryId": countryId,
    "country": country,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
