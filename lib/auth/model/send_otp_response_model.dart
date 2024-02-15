// To parse this JSON data, do
//
//     final sendOtpResponseModel = sendOtpResponseModelFromJson(jsonString);

import 'dart:convert';

SendOtpResponseModel sendOtpResponseModelFromJson(String str) => SendOtpResponseModel.fromJson(json.decode(str));

String sendOtpResponseModelToJson(SendOtpResponseModel data) => json.encode(data.toJson());

class SendOtpResponseModel {
  String? message;
  bool? isSuccess;
  PageResult? pageResult;
  Result? result;
  List<String>? errors;

  SendOtpResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) => SendOtpResponseModel(
    message: json["message"],
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"] == null ? null : PageResult.fromJson(json["pageResult"]),
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    errors: json["errors"] == null ? [] : List<String>.from(json["errors"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "pageResult": pageResult?.toJson(),
    "result": result?.toJson(),
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
  String? otp;

  Result({
    this.otp,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
  };
}
