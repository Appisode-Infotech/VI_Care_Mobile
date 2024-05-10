// To parse this JSON data, do
//
//     final summaryReportResponseModel = summaryReportResponseModelFromJson(jsonString);

import 'dart:convert';

SummaryReportResponseModel summaryReportResponseModelFromJson(String str) => SummaryReportResponseModel.fromJson(json.decode(str));

String summaryReportResponseModelToJson(SummaryReportResponseModel data) => json.encode(data.toJson());

class SummaryReportResponseModel {
  String? message;
  bool? isSuccess;
  PageResult? pageResult;
  Map<String, List<double>>? result;
  List<String>? errors;

  SummaryReportResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory SummaryReportResponseModel.fromJson(Map<String, dynamic> json) => SummaryReportResponseModel(
    message: json["message"],
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"] == null ? null : PageResult.fromJson(json["pageResult"]),
    result: Map.from(json["result"]!).map((k, v) => MapEntry<String, List<double>>(k, List<double>.from(v.map((x) => x)))),
    errors: json["errors"] == null ? [] : List<String>.from(json["errors"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "pageResult": pageResult?.toJson(),
    "result": Map.from(result!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
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
