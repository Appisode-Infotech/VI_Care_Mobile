// To parse this JSON data, do
//
//     final durationResponseModel = durationResponseModelFromJson(jsonString);

import 'dart:convert';

DurationResponseModel durationResponseModelFromJson(String str) =>
    DurationResponseModel.fromJson(json.decode(str));

String durationResponseModelToJson(DurationResponseModel data) =>
    json.encode(data.toJson());

class DurationResponseModel {
  String? message;
  bool? isSuccess;
  PageResult? pageResult;
  List<Duration>? result;
  List<String>? errors;

  DurationResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory DurationResponseModel.fromJson(Map<String, dynamic> json) =>
      DurationResponseModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        pageResult: json["pageResult"] == null
            ? null
            : PageResult.fromJson(json["pageResult"]),
        result: json["result"] == null
            ? []
            : List<Duration>.from(
                json["result"]!.map((x) => Duration.fromJson(x))),
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "pageResult": pageResult?.toJson(),
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
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

class Duration {
  int? id;
  String? uniqueGuid;
  String? name;
  int? durationInMinutes;
  String? type;

  Duration({
    this.id,
    this.uniqueGuid,
    this.name,
    this.durationInMinutes,
    this.type,
  });

  factory Duration.fromJson(Map<String, dynamic> json) => Duration(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        name: json["name"],
        durationInMinutes: json["durationInMinutes"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueGuid": uniqueGuid,
        "name": name,
        "durationInMinutes": durationInMinutes,
        "type": type,
      };
}
