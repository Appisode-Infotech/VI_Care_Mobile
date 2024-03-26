// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  String? message;
  bool? isSuccess;
  PageResult? pageResult;
  UserData? result;
  List<String>? errors;

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
    pageResult: json["pageResult"] == null ? null : PageResult.fromJson(json["pageResult"]),
    result: json["result"] == null ? null : UserData.fromJson(json["result"]),
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

class UserData {
  int? id;
  String? uniqueGuid;
  String? email;
  String? contactNumber;
  String? passwordHash;
  String? passwordSalt;
  String? type;
  int? status;
  String? remarks;
  String? token;
  int? contactId;
  Contact? contact;
  int? roleId;
  Role? role;
  int? profilePictureId;
  ProfilePicture? profilePicture;
  int? enterpriseId;
  Enterprise? enterprise;
  int? enterpriseUserId;
  EnterpriseUser? enterpriseUser;
  int? individualProfileId;

  UserData({
    this.id,
    this.uniqueGuid,
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
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
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
    enterprise: json["enterprise"] == null ? null : Enterprise.fromJson(json["enterprise"]),
    enterpriseUserId: json["enterpriseUserId"],
    enterpriseUser: json["enterpriseUser"] == null ? null : EnterpriseUser.fromJson(json["enterpriseUser"]),
    individualProfileId: json["individualProfileId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
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
    "enterprise": enterprise?.toJson(),
    "enterpriseUserId": enterpriseUserId,
    "enterpriseUser": enterpriseUser?.toJson(),
    "individualProfileId": individualProfileId,
  };
}

class Contact {
  int? id;
  String? uniqueGuid;
  String? firstname;
  String? lastName;
  String? email;
  String? contactNumber;
  DateTime? doB;
  int? gender;
  String? bloodGroup;
  int? addressId;
  Address? address;

  Contact({
    this.id,
    this.uniqueGuid,
    this.firstname,
    this.lastName,
    this.email,
    this.contactNumber,
    this.doB,
    this.gender,
    this.bloodGroup,
    this.addressId,
    this.address,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    firstname: json["firstname"],
    lastName: json["lastName"],
    email: json["email"],
    contactNumber: json["contactNumber"],
    doB: json["doB"] == null ? null : DateTime.parse(json["doB"]),
    gender: json["gender"],
    bloodGroup: json["bloodGroup"],
    addressId: json["addressId"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "firstname": firstname,
    "lastName": lastName,
    "email": email,
    "contactNumber": contactNumber,
    "doB": doB?.toIso8601String(),
    "gender": gender,
    "bloodGroup": bloodGroup,
    "addressId": addressId,
    "address": address?.toJson(),
  };
}

class Address {
  int? id;
  String? uniqueGuid;
  String? street;
  String? area;
  String? landmark;
  String? city;
  String? pinCode;
  String? longitude;
  String? latitude;
  int? stateId;
  State? state;

  Address({
    this.id,
    this.uniqueGuid,
    this.street,
    this.area,
    this.landmark,
    this.city,
    this.pinCode,
    this.longitude,
    this.latitude,
    this.stateId,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    street: json["street"],
    area: json["area"],
    landmark: json["landmark"],
    city: json["city"],
    pinCode: json["pinCode"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    stateId: json["stateId"],
    state: json["state"] == null ? null : State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "street": street,
    "area": area,
    "landmark": landmark,
    "city": city,
    "pinCode": pinCode,
    "longitude": longitude,
    "latitude": latitude,
    "stateId": stateId,
    "state": state?.toJson(),
  };
}

class State {
  int? id;
  String? uniqueGuid;
  String? name;
  String? code;
  int? numericCode;
  int? countryId;
  Country? country;

  State({
    this.id,
    this.uniqueGuid,
    this.name,
    this.code,
    this.numericCode,
    this.countryId,
    this.country,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: json["name"],
    code: json["code"],
    numericCode: json["numericCode"],
    countryId: json["countryId"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": name,
    "code": code,
    "numericCode": numericCode,
    "countryId": countryId,
    "country": country?.toJson(),
  };
}

class Country {
  int? id;
  String? uniqueGuid;
  String? name;
  String? code;
  String? twoLetterCode;
  String? threeLetterCode;
  int? numericCode;

  Country({
    this.id,
    this.uniqueGuid,
    this.name,
    this.code,
    this.twoLetterCode,
    this.threeLetterCode,
    this.numericCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: json["name"],
    code: json["code"],
    twoLetterCode: json["twoLetterCode"],
    threeLetterCode: json["threeLetterCode"],
    numericCode: json["numericCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": name,
    "code": code,
    "twoLetterCode": twoLetterCode,
    "threeLetterCode": threeLetterCode,
    "numericCode": numericCode,
  };
}

class Enterprise {
  int? id;
  String? uniqueGuid;
  String? name;
  String? spocName;
  String? contactNumber;
  String? gstNumber;
  int? contactId;
  Contact? contact;
  List<EnterpriseUser>? enterpriseUser;

  Enterprise({
    this.id,
    this.uniqueGuid,
    this.name,
    this.spocName,
    this.contactNumber,
    this.gstNumber,
    this.contactId,
    this.contact,
    this.enterpriseUser,
  });

  factory Enterprise.fromJson(Map<String, dynamic> json) => Enterprise(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: json["name"],
    spocName: json["spocName"],
    contactNumber: json["contactNumber"],
    gstNumber: json["gstNumber"],
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    enterpriseUser: json["enterpriseUser"] == null ? [] : List<EnterpriseUser>.from(json["enterpriseUser"]!.map((x) => EnterpriseUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": name,
    "spocName": spocName,
    "contactNumber": contactNumber,
    "gstNumber": gstNumber,
    "contactId": contactId,
    "contact": contact?.toJson(),
    "enterpriseUser": enterpriseUser == null ? [] : List<dynamic>.from(enterpriseUser!.map((x) => x.toJson())),
  };
}

class EnterpriseUser {
  int? id;
  String? uniqueGuid;
  String? name;
  String? designation;
  int? roleId;
  Role? role;
  int? contactId;
  Contact? contact;
  int? enterpriseId;
  int? profilePictureId;
  ProfilePicture? profilePicture;
  List<EnterpriseProfile>? enterpriseProfile;

  EnterpriseUser({
    this.id,
    this.uniqueGuid,
    this.name,
    this.designation,
    this.roleId,
    this.role,
    this.contactId,
    this.contact,
    this.enterpriseId,
    this.profilePictureId,
    this.profilePicture,
    this.enterpriseProfile,
  });

  factory EnterpriseUser.fromJson(Map<String, dynamic> json) => EnterpriseUser(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: json["name"],
    designation: json["designation"],
    roleId: json["roleId"],
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    enterpriseId: json["enterpriseId"],
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
    enterpriseProfile: json["enterpriseProfile"] == null ? [] : List<EnterpriseProfile>.from(json["enterpriseProfile"]!.map((x) => EnterpriseProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": name,
    "designation": designation,
    "roleId": roleId,
    "role": role?.toJson(),
    "contactId": contactId,
    "contact": contact?.toJson(),
    "enterpriseId": enterpriseId,
    "profilePictureId": profilePictureId,
    "profilePicture": profilePicture?.toJson(),
    "enterpriseProfile": enterpriseProfile == null ? [] : List<dynamic>.from(enterpriseProfile!.map((x) => x.toJson())),
  };
}

class EnterpriseProfile {
  int? id;
  String? uniqueGuid;
  String? firstName;
  String? lastName;
  String? emailId;
  int? contactId;
  Contact? contact;
  int? profilePictureId;
  ProfilePicture? profilePicture;
  int? enterpriseUserId;

  EnterpriseProfile({
    this.id,
    this.uniqueGuid,
    this.firstName,
    this.lastName,
    this.emailId,
    this.contactId,
    this.contact,
    this.profilePictureId,
    this.profilePicture,
    this.enterpriseUserId,
  });

  factory EnterpriseProfile.fromJson(Map<String, dynamic> json) => EnterpriseProfile(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
    enterpriseUserId: json["enterpriseUserId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "firstName": firstName,
    "lastName": lastName,
    "emailId": emailId,
    "contactId": contactId,
    "contact": contact?.toJson(),
    "profilePictureId": profilePictureId,
    "profilePicture": profilePicture?.toJson(),
    "enterpriseUserId": enterpriseUserId,
  };
}

class ProfilePicture {
  int? id;
  String? uniqueGuid;
  String? name;
  String? type;
  String? path;
  String? tags;
  int? length;
  String? savedFileName;
  String? actualFileName;
  int? fileType;
  String? sthreeKey;
  String? url;
  int? deviceId;

  ProfilePicture({
    this.id,
    this.uniqueGuid,
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
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
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
  };
}

class Role {
  int? id;
  String? uniqueGuid;
  String? name;
  int? maximumMembers;
  String? profileName;
  bool? isAdmin;

  Role({
    this.id,
    this.uniqueGuid,
    this.name,
    this.maximumMembers,
    this.profileName,
    this.isAdmin,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: json["name"],
    maximumMembers: json["maximumMembers"],
    profileName: json["profileName"],
    isAdmin: json["isAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": name,
    "maximumMembers": maximumMembers,
    "profileName": profileName,
    "isAdmin": isAdmin,
  };
}
