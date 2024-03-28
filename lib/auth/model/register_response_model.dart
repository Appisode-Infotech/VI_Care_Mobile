// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  UserData? result;
  dynamic errors;

  RegisterResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    message: json["message"],
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"],
    result: json["result"] == null ? null : UserData.fromJson(json["result"]),
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

class UserData {
  String? email;
  String? contactNumber;
  String? passwordHash;
  String? passwordSalt;
  dynamic type;
  int? status;
  dynamic remarks;
  String? token;
  int? contactId;
  Contact? contact;
  int? roleId;
  Role? role;
  int? profilePictureId;
  ProfilePicture? profilePicture;
  dynamic enterpriseId;
  dynamic enterprise;
  dynamic enterpriseUserId;
  dynamic enterpriseUser;
  int? individualProfileId;
  String? uniqueGuid;
  int? id;

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
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
    "role": role?.toJson(),
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

class Contact {
  String? firstname;
  String? lastName;
  String? email;
  String? contactNumber;
  DateTime? doB;
  int? gender;
  String? bloodGroup;
  int? addressId;
  Address? address;
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
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
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
    "address": address?.toJson(),
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}

class Address {
  String? street;
  String? area;
  String? landmark;
  String? city;
  String? pinCode;
  dynamic longitude;
  dynamic latitude;
  int? stateId;
  dynamic state;
  String? uniqueGuid;
  int? id;

  Address({
    this.street,
    this.area,
    this.landmark,
    this.city,
    this.pinCode,
    this.longitude,
    this.latitude,
    this.stateId,
    this.state,
    this.uniqueGuid,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"],
    area: json["area"],
    landmark: json["landmark"],
    city: json["city"],
    pinCode: json["pinCode"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    stateId: json["stateId"],
    state: json["state"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "area": area,
    "landmark": landmark,
    "city": city,
    "pinCode": pinCode,
    "longitude": longitude,
    "latitude": latitude,
    "stateId": stateId,
    "state": state,
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
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}

class Role {
  String? name;
  dynamic maximumMembers;
  dynamic profileName;
  bool? isAdmin;
  String? uniqueGuid;
  int? id;

  Role({
    this.name,
    this.maximumMembers,
    this.profileName,
    this.isAdmin,
    this.uniqueGuid,
    this.id,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    name: json["name"],
    maximumMembers: json["maximumMembers"],
    profileName: json["profileName"],
    isAdmin: json["isAdmin"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "maximumMembers": maximumMembers,
    "profileName": profileName,
    "isAdmin": isAdmin,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}
