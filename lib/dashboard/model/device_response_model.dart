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
  List<Result>? result;
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
  String? type;
  String? deviceSerialNo;
  bool? isPaired;
  int? roleId;
  Role? role;
  int? userId;
  User? user;
  int? deviceId;
  Device? device;
  String? uniqueGuid;
  int? id;

  Result({
    this.type,
    this.deviceSerialNo,
    this.isPaired,
    this.roleId,
    this.role,
    this.userId,
    this.user,
    this.deviceId,
    this.device,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    type: json["type"],
    deviceSerialNo: json["deviceSerialNo"],
    isPaired: json["isPaired"],
    roleId: json["roleId"],
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    userId: json["userId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    deviceId: json["deviceId"],
    device: json["device"] == null ? null : Device.fromJson(json["device"]),
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "deviceSerialNo": deviceSerialNo,
    "isPaired": isPaired,
    "roleId": roleId,
    "role": role?.toJson(),
    "userId": userId,
    "user": user?.toJson(),
    "deviceId": deviceId,
    "device": device?.toJson(),
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}

class Device {
  String? name;
  String? serialNumber;
  String? manufacturer;
  bool? isPaired;
  String? model;
  String? deviceKey;
  String? pairedDate;
  int? deviceStatus;
  String? description;
  String? purchaseCost;
  String? sellingCost;
  String? warrantyDuration;
  int? validity;
  int? deviceType;
  String? ipAddress;
  int? deviceCategory;
  int? allocationStatus;
  dynamic remarks;
  int? subscriberDeviceId;
  int? userId;
  dynamic user;
  int? subscriberId;
  dynamic subscriber;
  List<dynamic>? documents;
  String? uniqueGuid;
  int? id;

  Device({
    this.name,
    this.serialNumber,
    this.manufacturer,
    this.isPaired,
    this.model,
    this.deviceKey,
    this.pairedDate,
    this.deviceStatus,
    this.description,
    this.purchaseCost,
    this.sellingCost,
    this.warrantyDuration,
    this.validity,
    this.deviceType,
    this.ipAddress,
    this.deviceCategory,
    this.allocationStatus,
    this.remarks,
    this.subscriberDeviceId,
    this.userId,
    this.user,
    this.subscriberId,
    this.subscriber,
    this.documents,
    this.uniqueGuid,
    this.id,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    name: json["name"],
    serialNumber: json["serialNumber"],
    manufacturer: json["manufacturer"],
    isPaired: json["isPaired"],
    model: json["model"],
    deviceKey: json["deviceKey"],
    pairedDate: json["pairedDate"],
    deviceStatus: json["deviceStatus"],
    description: json["description"],
    purchaseCost: json["purchaseCost"].toString(),
    sellingCost: json["sellingCost"].toString(),
    warrantyDuration: json["warrantyDuration"],
    validity: json["validity"],
    deviceType: json["deviceType"],
    ipAddress: json["ipAddress"],
    deviceCategory: json["deviceCategory"],
    allocationStatus: json["allocationStatus"],
    remarks: json["remarks"],
    subscriberDeviceId: json["subscriberDeviceId"],
    userId: json["userId"],
    user: json["user"],
    subscriberId: json["subscriberId"],
    subscriber: json["subscriber"],
    documents: json["documents"] == null ? [] : List<dynamic>.from(json["documents"]!.map((x) => x)),
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "serialNumber": serialNumber,
    "manufacturer": manufacturer,
    "isPaired": isPaired,
    "model": model,
    "deviceKey": deviceKey,
    "pairedDate": pairedDate,
    "deviceStatus": deviceStatus,
    "description": description,
    "purchaseCost": purchaseCost,
    "sellingCost": sellingCost,
    "warrantyDuration": warrantyDuration,
    "validity": validity,
    "deviceType": deviceType,
    "ipAddress": ipAddress,
    "deviceCategory": deviceCategory,
    "allocationStatus": allocationStatus,
    "remarks": remarks,
    "subscriberDeviceId": subscriberDeviceId,
    "userId": userId,
    "user": user,
    "subscriberId": subscriberId,
    "subscriber": subscriber,
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
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

class User {
  String? email;
  String? contactNumber;
  dynamic type;
  int? status;
  dynamic remarks;
  dynamic token;
  String? refreshToken;
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
    this.type,
    this.status,
    this.remarks,
    this.token,
    this.refreshToken,
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
    type: json["type"],
    status: json["status"],
    remarks: json["remarks"],
    token: json["token"],
    refreshToken: json["refreshToken"],
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
    "type": type,
    "status": status,
    "remarks": remarks,
    "token": token,
    "refreshToken": refreshToken,
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
