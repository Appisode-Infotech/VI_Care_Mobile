// To parse this JSON data, do
//
//     final editPatientResponseModel = editPatientResponseModelFromJson(jsonString);

import 'dart:convert';

EditPatientResponseModel editPatientResponseModelFromJson(String str) =>
    EditPatientResponseModel.fromJson(json.decode(str));

String editPatientResponseModelToJson(EditPatientResponseModel data) =>
    json.encode(data.toJson());

class EditPatientResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  Result? result;
  dynamic errors;

  EditPatientResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory EditPatientResponseModel.fromJson(Map<String, dynamic> json) =>
      EditPatientResponseModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        pageResult: json["pageResult"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "pageResult": pageResult,
        "result": result?.toJson(),
        "errors": errors,
      };
}

class Result {
  String? firstName;
  String? lastName;
  String? email;
  bool? isSelf;
  int? contactId;
  Contact? contact;
  int? userId;
  dynamic user;
  int? profilePictureId;
  ProfilePicture? profilePicture;
  String? uniqueGuid;
  int? id;

  Result({
    this.firstName,
    this.lastName,
    this.email,
    this.isSelf,
    this.contactId,
    this.contact,
    this.userId,
    this.user,
    this.profilePictureId,
    this.profilePicture,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        isSelf: json["isSelf"],
        contactId: json["contactId"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        userId: json["userId"],
        user: json["user"],
        profilePictureId: json["profilePictureId"],
        profilePicture: json["profilePicture"] == null
            ? null
            : ProfilePicture.fromJson(json["profilePicture"]),
        uniqueGuid: json["uniqueGuid"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "isSelf": isSelf,
        "contactId": contactId,
        "contact": contact?.toJson(),
        "userId": userId,
        "user": user,
        "profilePictureId": profilePictureId,
        "profilePicture": profilePicture?.toJson(),
        "uniqueGuid": uniqueGuid,
        "id": id,
      };
}

class Contact {
  String? firstname;
  String? lastName;
  String? email;
  int? contactNumber;
  DateTime? doB;
  int? gender;
  dynamic bloodGroup;
  dynamic addressId;
  dynamic address;
  String? uniqueGuid;
  int? id;

  Contact({
    this.firstname,
    this.lastName,
    this.email,
    this.contactNumber,
    this.doB,
    this.gender,
    this.bloodGroup,
    this.addressId,
    this.address,
    this.uniqueGuid,
    this.id,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        firstname: json["firstname"],
        lastName: json["lastName"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        doB: json["doB"] == null ? null : DateTime.parse(json["doB"]),
        gender: json["gender"],
        bloodGroup: json["bloodGroup"],
        addressId: json["addressId"],
        address: json["address"],
        uniqueGuid: json["uniqueGuid"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastName": lastName,
        "email": email,
        "contactNumber": contactNumber,
        "doB": doB?.toIso8601String(),
        "gender": gender,
        "bloodGroup": bloodGroup,
        "addressId": addressId,
        "address": address,
        "uniqueGuid": uniqueGuid,
        "id": id,
      };
}

class ProfilePicture {
  String? name;
  dynamic type;
  String? path;
  dynamic tags;
  int? length;
  String? savedFileName;
  String? actualFileName;
  int? fileType;
  String? sthreeKey;
  String? url;
  dynamic deviceId;
  dynamic device;
  String? uniqueGuid;
  int? id;

  ProfilePicture({
    this.name,
    this.type,
    this.path,
    this.tags,
    this.length,
    this.savedFileName,
    this.actualFileName,
    this.fileType,
    this.sthreeKey,
    this.url,
    this.deviceId,
    this.device,
    this.uniqueGuid,
    this.id,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
        name: json["name"],
        type: json["type"],
        path: json["path"],
        tags: json["tags"],
        length: json["length"],
        savedFileName: json["savedFileName"],
        actualFileName: json["actualFileName"],
        fileType: json["fileType"],
        sthreeKey: json["sthreeKey"],
        url: json["url"],
        deviceId: json["deviceId"],
        device: json["device"],
        uniqueGuid: json["uniqueGuid"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "path": path,
        "tags": tags,
        "length": length,
        "savedFileName": savedFileName,
        "actualFileName": actualFileName,
        "fileType": fileType,
        "sthreeKey": sthreeKey,
        "url": url,
        "deviceId": deviceId,
        "device": device,
        "uniqueGuid": uniqueGuid,
        "id": id,
      };
}
