// To parse this JSON data, do
//
//     final countryMasterResponseModel = countryMasterResponseModelFromJson(jsonString);

import 'dart:convert';

CountryMasterResponseModel countryMasterResponseModelFromJson(String str) => CountryMasterResponseModel.fromJson(json.decode(str));

String countryMasterResponseModelToJson(CountryMasterResponseModel data) => json.encode(data.toJson());

class CountryMasterResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<Result>? result;
  dynamic errors;

  CountryMasterResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory CountryMasterResponseModel.fromJson(Map<String, dynamic> json) => CountryMasterResponseModel(
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
  String? twoLetterCode;
  String? threeLetterCode;
  int? numericCode;
  String? uniqueGuid;
  int? id;

  Result({
    this.name,
    this.code,
    this.twoLetterCode,
    this.threeLetterCode,
    this.numericCode,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    code: json["code"],
    twoLetterCode: json["twoLetterCode"],
    threeLetterCode: json["threeLetterCode"],
    numericCode: json["numericCode"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "twoLetterCode": twoLetterCode,
    "threeLetterCode": threeLetterCode,
    "numericCode": numericCode,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
