// To parse this JSON data, do
//
//     final deviceResponseModel = deviceResponseModelFromJson(jsonString);

import 'dart:convert';

DeviceResponseModel deviceResponseModelFromJson(String str) => DeviceResponseModel.fromJson(json.decode(str));

String deviceResponseModelToJson(DeviceResponseModel data) => json.encode(data.toJson());

class DeviceResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  Result? result;
  dynamic errors;

  DeviceResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory DeviceResponseModel.fromJson(Map<String, dynamic> json) => DeviceResponseModel(
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
  User? user;
  List<Device>? devices;

  Result({
    this.user,
    this.devices,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    devices: json["devices"] == null ? [] : List<Device>.from(json["devices"]!.map((x) => Device.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "devices": devices == null ? [] : List<dynamic>.from(devices!.map((x) => x.toJson())),
  };
}

class Device {
  String? name;
  String? serialNumber;
  String? manufacturer;
  bool? isPaired;
  dynamic model;
  String? pairedDate;
  String? deviceKey;
  int? deviceStatus;
  String? description;
  double? purchaseCost;
  double? sellingCost;
  String? warrantyDuration;
  int? validity;
  int? deviceType;
  String? ipAddress;
  int? allocationStatus;
  int? deviceCategory;
  String? remarks;
  int? subscriberDeviceId;
  int? userId;
  int? subscriberId;
  String? uniqueGuid;
  int? id;

  Device({
    this.name,
    this.serialNumber,
    this.manufacturer,
    this.isPaired,
    this.model,
    this.pairedDate,
    this.deviceKey,
    this.deviceStatus,
    this.description,
    this.purchaseCost,
    this.sellingCost,
    this.warrantyDuration,
    this.validity,
    this.deviceType,
    this.ipAddress,
    this.allocationStatus,
    this.deviceCategory,
    this.remarks,
    this.subscriberDeviceId,
    this.userId,
    this.subscriberId,
    this.uniqueGuid,
    this.id,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    name: json["name"],
    serialNumber: json["serialNumber"],
    manufacturer: json["manufacturer"],
    isPaired: json["isPaired"],
    model: json["model"],
    pairedDate: json["pairedDate"],
    deviceKey: json["deviceKey"],
    deviceStatus: json["deviceStatus"],
    description: json["description"],
    purchaseCost: json["purchaseCost"].toDouble(),
    sellingCost: json["sellingCost"].toDouble(),
    warrantyDuration: json["warrantyDuration"],
    validity: json["validity"],
    deviceType: json["deviceType"],
    ipAddress: json["ipAddress"],
    allocationStatus: json["allocationStatus"],
    deviceCategory: json["deviceCategory"],
    remarks: json["remarks"],
    subscriberDeviceId: json["subscriberDeviceId"],
    userId: json["userId"],
    subscriberId: json["subscriberId"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "serialNumber": serialNumber,
    "manufacturer": manufacturer,
    "isPaired": isPaired,
    "model": model,
    "pairedDate": pairedDate,
    "deviceKey": deviceKey,
    "deviceStatus": deviceStatus,
    "description": description,
    "purchaseCost": purchaseCost,
    "sellingCost": sellingCost,
    "warrantyDuration": warrantyDuration,
    "validity": validity,
    "deviceType": deviceType,
    "ipAddress": ipAddress,
    "allocationStatus": allocationStatus,
    "deviceCategory": deviceCategory,
    "remarks": remarks,
    "subscriberDeviceId": subscriberDeviceId,
    "userId": userId,
    "subscriberId": subscriberId,
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
  dynamic profilePicture;
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
    profilePicture: json["profilePicture"],
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
    "profilePicture": profilePicture,
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
  String? doB;
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
    doB: json["doB"],
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
