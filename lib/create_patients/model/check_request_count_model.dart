// To parse this JSON data, do
//
//     final checkRequestCountModel = checkRequestCountModelFromJson(jsonString);

import 'dart:convert';

CheckRequestCountModel checkRequestCountModelFromJson(String str) => CheckRequestCountModel.fromJson(json.decode(str));

String checkRequestCountModelToJson(CheckRequestCountModel data) => json.encode(data.toJson());

class CheckRequestCountModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  bool? result;
  dynamic errors;

  CheckRequestCountModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory CheckRequestCountModel.fromJson(Map<String, dynamic> json) => CheckRequestCountModel(
    message: json["message"],
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"],
    result: json["result"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "isSuccess": isSuccess,
    "pageResult": pageResult,
    "result": result,
    "errors": errors,
  };
}
