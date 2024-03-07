// To parse this JSON data, do
//
//     final allPatientsResponseModel = allPatientsResponseModelFromJson(jsonString);

import 'dart:convert';

AllPatientsResponseModel allPatientsResponseModelFromJson(String str) => AllPatientsResponseModel.fromJson(json.decode(str));

String allPatientsResponseModelToJson(AllPatientsResponseModel data) => json.encode(data.toJson());

class AllPatientsResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<Result>? result;
  dynamic errors;

  AllPatientsResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory AllPatientsResponseModel.fromJson(Map<String, dynamic> json) => AllPatientsResponseModel(
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
  String? firstName;
  String? lastName;
  String? email;
  bool? isSelf;
  int? contactId;
  Contact? contact;
  int? userId;
  User? user;
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
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    userId: json["userId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
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
    "user": user?.toJson(),
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
  String? contactNumber;
  DateTime? doB;
  int? gender;
  String? bloodGroup;
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

class User {
  String? email;
  String? contactNumber;
  String? passwordHash;
  String? passwordSalt;
  dynamic type;
  int? status;
  dynamic remarks;
  dynamic token;
  int? contactId;
  Contact? contact;
  int? roleId;
  dynamic role;
  int? profilePictureId;
  ProfilePicture? profilePicture;
  dynamic enterpriseId;
  dynamic enterprise;
  dynamic enterpriseUserId;
  dynamic enterpriseUser;
  dynamic individualProfileId;
  String? uniqueGuid;
  int? id;

  User({
    this.email,
    this.contactNumber,
    this.passwordHash,
    this.passwordSalt,
    this.type,
    this.status,
    this.remarks,
    this.token,
    this.contactId,
    this.contact,
    this.roleId,
    this.role,
    this.profilePictureId,
    this.profilePicture,
    this.enterpriseId,
    this.enterprise,
    this.enterpriseUserId,
    this.enterpriseUser,
    this.individualProfileId,
    this.uniqueGuid,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    contactNumber: json["contactNumber"],
    passwordHash: json["passwordHash"],
    passwordSalt: json["passwordSalt"],
    type: json["type"],
    status: json["status"],
    remarks: json["remarks"],
    token: json["token"],
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    roleId: json["roleId"],
    role: json["role"],
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
    enterpriseId: json["enterpriseId"],
    enterprise: json["enterprise"],
    enterpriseUserId: json["enterpriseUserId"],
    enterpriseUser: json["enterpriseUser"],
    individualProfileId: json["individualProfileId"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "contactNumber": contactNumber,
    "passwordHash": passwordHash,
    "passwordSalt": passwordSalt,
    "type": type,
    "status": status,
    "remarks": remarks,
    "token": token,
    "contactId": contactId,
    "contact": contact?.toJson(),
    "roleId": roleId,
    "role": role,
    "profilePictureId": profilePictureId,
    "profilePicture": profilePicture?.toJson(),
    "enterpriseId": enterpriseId,
    "enterprise": enterprise,
    "enterpriseUserId": enterpriseUserId,
    "enterpriseUser": enterpriseUser,
    "individualProfileId": individualProfileId,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
