// To parse this JSON data, do
//
//     final resetPasswordResponseModel = resetPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordResponseModel resetPasswordResponseModelFromJson(String str) =>
    ResetPasswordResponseModel.fromJson(json.decode(str));

String resetPasswordResponseModelToJson(ResetPasswordResponseModel data) =>
    json.encode(data.toJson());

class ResetPasswordResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  bool? result;
  dynamic errors;

  ResetPasswordResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponseModel(
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
