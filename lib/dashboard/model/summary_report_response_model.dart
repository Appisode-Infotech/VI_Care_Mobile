// To parse this JSON data, do
//
//     final summaryReportResponseModel = summaryReportResponseModelFromJson(jsonString);

import 'dart:convert';

SummaryReportResponseModel summaryReportResponseModelFromJson(String str) => SummaryReportResponseModel.fromJson(json.decode(str));

String summaryReportResponseModelToJson(SummaryReportResponseModel data) => json.encode(data.toJson());

class SummaryReportResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  Map<String, List<double>>? result;
  dynamic errors;

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
    pageResult: json["pageResult"],
    result: Map.from(json["result"]!).map((k, v) => MapEntry<String, List<double>>(k, List<double>.from(v.map((x) => x?.toDouble())))),
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "pageResult": pageResult,
    "result": Map.from(result!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "errors": errors,
  };
}
