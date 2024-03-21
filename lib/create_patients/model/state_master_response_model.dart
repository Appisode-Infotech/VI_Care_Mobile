// To parse this JSON data, do
//
//     final stateMasterResponseModel = stateMasterResponseModelFromJson(jsonString);

import 'dart:convert';

StateMasterResponseModel stateMasterResponseModelFromJson(String str) => StateMasterResponseModel.fromJson(json.decode(str));

String stateMasterResponseModelToJson(StateMasterResponseModel data) => json.encode(data.toJson());

class StateMasterResponseModel {
  String? message;
  bool? isSuccess;
  PageResult? pageResult;
  List<Result>? result;
  List<String>? errors;

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
    pageResult: json["pageResult"] == null ? null : PageResult.fromJson(json["pageResult"]),
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    errors: json["errors"] == null ? [] : List<String>.from(json["errors"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "pageResult": pageResult?.toJson(),
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
  };
}

class PageResult {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  String? previousPage;
  String? nextPage;

  PageResult({
    this.currentPage,
    this.totalPages,
    this.pageSize,
    this.totalCount,
    this.hasPrevious,
    this.hasNext,
    this.previousPage,
    this.nextPage,
  });

  factory PageResult.fromJson(Map<String, dynamic> json) => PageResult(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    pageSize: json["pageSize"],
    totalCount: json["totalCount"],
    hasPrevious: json["hasPrevious"],
    hasNext: json["hasNext"],
    previousPage: json["previousPage"],
    nextPage: json["nextPage"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "pageSize": pageSize,
    "totalCount": totalCount,
    "hasPrevious": hasPrevious,
    "hasNext": hasNext,
    "previousPage": previousPage,
    "nextPage": nextPage,
  };
}

class Result {
  int? id;
  String? uniqueGuid;
  String? name;
  String? code;
  int? numericCode;
  int? countryId;
  Country? country;

  Result({
    this.id,
    this.uniqueGuid,
    this.name,
    this.code,
    this.numericCode,
    this.countryId,
    this.country,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: json["name"],
    code: json["code"],
    numericCode: json["numericCode"],
    countryId: json["countryId"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": name,
    "code": code,
    "numericCode": numericCode,
    "countryId": countryId,
    "country": country?.toJson(),
  };
}

class Country {
  int? id;
  String? uniqueGuid;
  String? name;
  String? code;
  String? twoLetterCode;
  String? threeLetterCode;
  int? numericCode;

  Country({
    this.id,
    this.uniqueGuid,
    this.name,
    this.code,
    this.twoLetterCode,
    this.threeLetterCode,
    this.numericCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: json["name"],
    code: json["code"],
    twoLetterCode: json["twoLetterCode"],
    threeLetterCode: json["threeLetterCode"],
    numericCode: json["numericCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": name,
    "code": code,
    "twoLetterCode": twoLetterCode,
    "threeLetterCode": threeLetterCode,
    "numericCode": numericCode,
  };
}
