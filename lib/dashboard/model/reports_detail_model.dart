// To parse this JSON data, do
//
//     final reportsDetailModel = reportsDetailModelFromJson(jsonString);

import 'dart:convert';

ReportsDetailModel reportsDetailModelFromJson(String str) => ReportsDetailModel.fromJson(json.decode(str));

String reportsDetailModelToJson(ReportsDetailModel data) => json.encode(data.toJson());

class ReportsDetailModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  List<Result>? result;
  dynamic errors;

  ReportsDetailModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory ReportsDetailModel.fromJson(Map<String, dynamic> json) => ReportsDetailModel(
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
  dynamic name;
  int? reportStatus;
  String? reportDate;
  dynamic type;
  String? processedData;
  String? requestDateTime;
  String? processedDateTime;
  int? paymentStatus;
  String? errorType;
  String? errorMessage;
  int? totalRequest;
  int? remainingRequest;
  int? consumedRequest;
  int? processingStatus;
  int? subscriberId;
  String? status;
  int? roleId;
  Role? role;
  int? requestDeviceDataId;
  dynamic requestDeviceData;
  int? userId;
  User? user;
  int? individualProfileId;
  IndividualProfile? individualProfile;
  dynamic enterpriseProfileId;
  dynamic enterpriseProfile;
  String? uniqueGuid;
  int? id;

  Result({
    this.name,
    this.reportStatus,
    this.reportDate,
    this.type,
    this.processedData,
    this.requestDateTime,
    this.processedDateTime,
    this.paymentStatus,
    this.errorType,
    this.errorMessage,
    this.totalRequest,
    this.remainingRequest,
    this.consumedRequest,
    this.processingStatus,
    this.subscriberId,
    this.status,
    this.roleId,
    this.role,
    this.requestDeviceDataId,
    this.requestDeviceData,
    this.userId,
    this.user,
    this.individualProfileId,
    this.individualProfile,
    this.enterpriseProfileId,
    this.enterpriseProfile,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    reportStatus: json["reportStatus"],
    reportDate: json["reportDate"],
    type: json["type"],
    processedData: json["processedData"],
    requestDateTime: json["requestDateTime"],
    processedDateTime: json["processedDateTime"],
    paymentStatus: json["paymentStatus"],
    errorType: json["errorType"],
    errorMessage: json["errorMessage"],
    totalRequest: json["totalRequest"],
    remainingRequest: json["remainingRequest"],
    consumedRequest: json["consumedRequest"],
    processingStatus: json["processingStatus"],
    subscriberId: json["subscriberId"],
    status: json["status"],
    roleId: json["roleId"],
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    requestDeviceDataId: json["requestDeviceDataId"],
    requestDeviceData: json["requestDeviceData"],
    userId: json["userId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    individualProfileId: json["individualProfileId"],
    individualProfile: json["individualProfile"] == null ? null : IndividualProfile.fromJson(json["individualProfile"]),
    enterpriseProfileId: json["enterpriseProfileId"],
    enterpriseProfile: json["enterpriseProfile"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "reportStatus": reportStatus,
    "reportDate": reportDate,
    "type": type,
    "processedData": processedData,
    "requestDateTime": requestDateTime,
    "processedDateTime": processedDateTime,
    "paymentStatus": paymentStatus,
    "errorType": errorType,
    "errorMessage": errorMessage,
    "totalRequest": totalRequest,
    "remainingRequest": remainingRequest,
    "consumedRequest": consumedRequest,
    "processingStatus": processingStatus,
    "subscriberId": subscriberId,
    "status": status,
    "roleId": roleId,
    "role": role?.toJson(),
    "requestDeviceDataId": requestDeviceDataId,
    "requestDeviceData": requestDeviceData,
    "userId": userId,
    "user": user?.toJson(),
    "individualProfileId": individualProfileId,
    "individualProfile": individualProfile?.toJson(),
    "enterpriseProfileId": enterpriseProfileId,
    "enterpriseProfile": enterpriseProfile,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}

class IndividualProfile {
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

  IndividualProfile({
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

  factory IndividualProfile.fromJson(Map<String, dynamic> json) => IndividualProfile(
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
  String? firstName;
  String? lastName;
  String? email;
  String? contactNumber;
  String? doB;
  int? gender;
  String? bloodGroup;
  int? addressId;
  Address? address;
  String? uniqueGuid;
  int? id;

  Contact({
    this.firstName,
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
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    contactNumber: json["contactNumber"],
    doB: json["doB"],
    gender: json["gender"],
    bloodGroup: json["bloodGroup"],
    addressId: json["addressId"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "contactNumber": contactNumber,
    "doB": doB,
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
  Role? role;
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
