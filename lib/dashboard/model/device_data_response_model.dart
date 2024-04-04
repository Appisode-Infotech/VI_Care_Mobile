// To parse this JSON data, do
//
//     final deviceDataResponseModel = deviceDataResponseModelFromJson(jsonString);

import 'dart:convert';

DeviceDataResponseModel deviceDataResponseModelFromJson(String str) => DeviceDataResponseModel.fromJson(json.decode(str));

String deviceDataResponseModelToJson(DeviceDataResponseModel data) => json.encode(data.toJson());

class DeviceDataResponseModel {
  Message? message;
  bool? isSuccess;
  PageResult? pageResult;
  Result? result;
  List<Message>? errors;

  DeviceDataResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory DeviceDataResponseModel.fromJson(Map<String, dynamic> json) => DeviceDataResponseModel(
    message: messageValues.map[json["message"]]!,
    isSuccess: json["isSuccess"],
    pageResult: json["pageResult"] == null ? null : PageResult.fromJson(json["pageResult"]),
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    errors: json["errors"] == null ? [] : List<Message>.from(json["errors"]!.map((x) => messageValues.map[x]!)),
  );

  Map<String, dynamic> toJson() => {
    "message": messageValues.reverse[message],
    "isSuccess": isSuccess,
    "pageResult": pageResult?.toJson(),
    "result": result?.toJson(),
    "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => messageValues.reverse[x])),
  };
}

enum Message {
  STRING
}

final messageValues = EnumValues({
  "string": Message.STRING
});

class PageResult {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  Message? previousPage;
  Message? nextPage;

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
    previousPage: messageValues.map[json["previousPage"]]!,
    nextPage: messageValues.map[json["nextPage"]]!,
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "pageSize": pageSize,
    "totalCount": totalCount,
    "hasPrevious": hasPrevious,
    "hasNext": hasNext,
    "previousPage": messageValues.reverse[previousPage],
    "nextPage": messageValues.reverse[nextPage],
  };
}

class Result {
  int? id;
  String? uniqueGuid;
  Message? details;
  DateTime? requestDateTime;
  int? processingStatus;
  DateTime? processedDate;
  Message? inputData;
  int? fileType;
  Message? durationName;
  Message? deviceSerialNo;
  Message? ipAddress;
  int? userAndDeviceId;
  String? subscriberGuid;
  int? subscriberId;
  Subscriber? subscriber;
  int? deviceId;
  Device? device;
  int? durationId;
  Duration? duration;
  int? userId;
  User? user;
  int? deviceDocumentId;
  DeviceDocument? deviceDocument;
  int? roleId;
  Role? role;
  int? individualProfileId;
  IndividualProfile? individualProfile;
  int? enterpriseProfileId;
  EnterpriseProfile? enterpriseProfile;

  Result({
    this.id,
    this.uniqueGuid,
    this.details,
    this.requestDateTime,
    this.processingStatus,
    this.processedDate,
    this.inputData,
    this.fileType,
    this.durationName,
    this.deviceSerialNo,
    this.ipAddress,
    this.userAndDeviceId,
    this.subscriberGuid,
    this.subscriberId,
    this.subscriber,
    this.deviceId,
    this.device,
    this.durationId,
    this.duration,
    this.userId,
    this.user,
    this.deviceDocumentId,
    this.deviceDocument,
    this.roleId,
    this.role,
    this.individualProfileId,
    this.individualProfile,
    this.enterpriseProfileId,
    this.enterpriseProfile,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    details: messageValues.map[json["details"]]!,
    requestDateTime: json["requestDateTime"] == null ? null : DateTime.parse(json["requestDateTime"]),
    processingStatus: json["processingStatus"],
    processedDate: json["processedDate"] == null ? null : DateTime.parse(json["processedDate"]),
    inputData: messageValues.map[json["inputData"]]!,
    fileType: json["fileType"],
    durationName: messageValues.map[json["durationName"]]!,
    deviceSerialNo: messageValues.map[json["deviceSerialNo"]]!,
    ipAddress: messageValues.map[json["ipAddress"]]!,
    userAndDeviceId: json["userAndDeviceId"],
    subscriberGuid: json["subscriberGuid"],
    subscriberId: json["subscriberId"],
    subscriber: json["subscriber"] == null ? null : Subscriber.fromJson(json["subscriber"]),
    deviceId: json["deviceId"],
    device: json["device"] == null ? null : Device.fromJson(json["device"]),
    durationId: json["durationId"],
    duration: json["duration"] == null ? null : Duration.fromJson(json["duration"]),
    userId: json["userId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    deviceDocumentId: json["deviceDocumentId"],
    deviceDocument: json["deviceDocument"] == null ? null : DeviceDocument.fromJson(json["deviceDocument"]),
    roleId: json["roleId"],
    role: json["role"] == null ? null : Role.fromJson(json["role"]),
    individualProfileId: json["individualProfileId"],
    individualProfile: json["individualProfile"] == null ? null : IndividualProfile.fromJson(json["individualProfile"]),
    enterpriseProfileId: json["enterpriseProfileId"],
    enterpriseProfile: json["enterpriseProfile"] == null ? null : EnterpriseProfile.fromJson(json["enterpriseProfile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "details": messageValues.reverse[details],
    "requestDateTime": requestDateTime?.toIso8601String(),
    "processingStatus": processingStatus,
    "processedDate": processedDate?.toIso8601String(),
    "inputData": messageValues.reverse[inputData],
    "fileType": fileType,
    "durationName": messageValues.reverse[durationName],
    "deviceSerialNo": messageValues.reverse[deviceSerialNo],
    "ipAddress": messageValues.reverse[ipAddress],
    "userAndDeviceId": userAndDeviceId,
    "subscriberGuid": subscriberGuid,
    "subscriberId": subscriberId,
    "subscriber": subscriber?.toJson(),
    "deviceId": deviceId,
    "device": device?.toJson(),
    "durationId": durationId,
    "duration": duration?.toJson(),
    "userId": userId,
    "user": user?.toJson(),
    "deviceDocumentId": deviceDocumentId,
    "deviceDocument": deviceDocument?.toJson(),
    "roleId": roleId,
    "role": role?.toJson(),
    "individualProfileId": individualProfileId,
    "individualProfile": individualProfile?.toJson(),
    "enterpriseProfileId": enterpriseProfileId,
    "enterpriseProfile": enterpriseProfile?.toJson(),
  };
}

class Device {
  int? id;
  String? uniqueGuid;
  Message? name;
  Message? serialNumber;
  Message? manufacturer;
  bool? isPaired;
  DateTime? pairedDate;
  int? deviceStatus;
  Message? description;
  int? purchaseCost;
  int? sellingCost;
  int? warrantyDuration;
  int? validity;
  int? deviceType;
  Message? ipAddress;
  int? allocationStatus;
  Message? remarks;
  int? subscriberDeviceId;
  int? userId;
  User? user;
  int? subscriberId;
  Subscriber? subscriber;

  Device({
    this.id,
    this.uniqueGuid,
    this.name,
    this.serialNumber,
    this.manufacturer,
    this.isPaired,
    this.pairedDate,
    this.deviceStatus,
    this.description,
    this.purchaseCost,
    this.sellingCost,
    this.warrantyDuration,
    this.validity,
    this.deviceType,
    this.ipAddress,
    this.allocationStatus,
    this.remarks,
    this.subscriberDeviceId,
    this.userId,
    this.user,
    this.subscriberId,
    this.subscriber,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: messageValues.map[json["name"]]!,
    serialNumber: messageValues.map[json["serialNumber"]]!,
    manufacturer: messageValues.map[json["manufacturer"]]!,
    isPaired: json["isPaired"],
    pairedDate: json["pairedDate"] == null ? null : DateTime.parse(json["pairedDate"]),
    deviceStatus: json["deviceStatus"],
    description: messageValues.map[json["description"]]!,
    purchaseCost: json["purchaseCost"],
    sellingCost: json["sellingCost"],
    warrantyDuration: json["warrantyDuration"],
    validity: json["validity"],
    deviceType: json["deviceType"],
    ipAddress: messageValues.map[json["ipAddress"]]!,
    allocationStatus: json["allocationStatus"],
    remarks: messageValues.map[json["remarks"]]!,
    subscriberDeviceId: json["subscriberDeviceId"],
    userId: json["userId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    subscriberId: json["subscriberId"],
    subscriber: json["subscriber"] == null ? null : Subscriber.fromJson(json["subscriber"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "serialNumber": messageValues.reverse[serialNumber],
    "manufacturer": messageValues.reverse[manufacturer],
    "isPaired": isPaired,
    "pairedDate": pairedDate?.toIso8601String(),
    "deviceStatus": deviceStatus,
    "description": messageValues.reverse[description],
    "purchaseCost": purchaseCost,
    "sellingCost": sellingCost,
    "warrantyDuration": warrantyDuration,
    "validity": validity,
    "deviceType": deviceType,
    "ipAddress": messageValues.reverse[ipAddress],
    "allocationStatus": allocationStatus,
    "remarks": messageValues.reverse[remarks],
    "subscriberDeviceId": subscriberDeviceId,
    "userId": userId,
    "user": user?.toJson(),
    "subscriberId": subscriberId,
    "subscriber": subscriber?.toJson(),
  };
}

class Subscriber {
  int? id;
  String? uniqueGuid;
  Message? companyName;
  Message? displayName;
  Message? email;
  Message? contactNumber;
  Message? contactPersonName;
  Message? address;
  Message? subscriberEngineGuid;
  Message? gstNumber;

  Subscriber({
    this.id,
    this.uniqueGuid,
    this.companyName,
    this.displayName,
    this.email,
    this.contactNumber,
    this.contactPersonName,
    this.address,
    this.subscriberEngineGuid,
    this.gstNumber,
  });

  factory Subscriber.fromJson(Map<String, dynamic> json) => Subscriber(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    companyName: messageValues.map[json["companyName"]]!,
    displayName: messageValues.map[json["displayName"]]!,
    email: messageValues.map[json["email"]]!,
    contactNumber: messageValues.map[json["contactNumber"]]!,
    contactPersonName: messageValues.map[json["contactPersonName"]]!,
    address: messageValues.map[json["address"]]!,
    subscriberEngineGuid: messageValues.map[json["subscriberEngineGuid"]]!,
    gstNumber: messageValues.map[json["gstNumber"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "companyName": messageValues.reverse[companyName],
    "displayName": messageValues.reverse[displayName],
    "email": messageValues.reverse[email],
    "contactNumber": messageValues.reverse[contactNumber],
    "contactPersonName": messageValues.reverse[contactPersonName],
    "address": messageValues.reverse[address],
    "subscriberEngineGuid": messageValues.reverse[subscriberEngineGuid],
    "gstNumber": messageValues.reverse[gstNumber],
  };
}

class User {
  int? id;
  String? uniqueGuid;
  Message? email;
  Message? contactNumber;
  Message? passwordHash;
  Message? passwordSalt;
  Message? type;
  int? status;
  Message? remarks;
  Message? token;
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    email: messageValues.map[json["email"]]!,
    contactNumber: messageValues.map[json["contactNumber"]]!,
    passwordHash: messageValues.map[json["passwordHash"]]!,
    passwordSalt: messageValues.map[json["passwordSalt"]]!,
    type: messageValues.map[json["type"]]!,
    status: json["status"],
    remarks: messageValues.map[json["remarks"]]!,
    token: messageValues.map[json["token"]]!,
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
    "email": messageValues.reverse[email],
    "contactNumber": messageValues.reverse[contactNumber],
    "passwordHash": messageValues.reverse[passwordHash],
    "passwordSalt": messageValues.reverse[passwordSalt],
    "type": messageValues.reverse[type],
    "status": status,
    "remarks": messageValues.reverse[remarks],
    "token": messageValues.reverse[token],
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
  Message? firstname;
  Message? lastName;
  Message? email;
  Message? contactNumber;
  DateTime? doB;
  int? gender;
  Message? bloodGroup;
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
    firstname: messageValues.map[json["firstname"]]!,
    lastName: messageValues.map[json["lastName"]]!,
    email: messageValues.map[json["email"]]!,
    contactNumber: messageValues.map[json["contactNumber"]]!,
    doB: json["doB"] == null ? null : DateTime.parse(json["doB"]),
    gender: json["gender"],
    bloodGroup: messageValues.map[json["bloodGroup"]]!,
    addressId: json["addressId"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "firstname": messageValues.reverse[firstname],
    "lastName": messageValues.reverse[lastName],
    "email": messageValues.reverse[email],
    "contactNumber": messageValues.reverse[contactNumber],
    "doB": doB?.toIso8601String(),
    "gender": gender,
    "bloodGroup": messageValues.reverse[bloodGroup],
    "addressId": addressId,
    "address": address?.toJson(),
  };
}

class Address {
  int? id;
  String? uniqueGuid;
  Message? street;
  Message? area;
  Message? landmark;
  Message? city;
  Message? pinCode;
  Message? longitude;
  Message? latitude;
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
    street: messageValues.map[json["street"]]!,
    area: messageValues.map[json["area"]]!,
    landmark: messageValues.map[json["landmark"]]!,
    city: messageValues.map[json["city"]]!,
    pinCode: messageValues.map[json["pinCode"]]!,
    longitude: messageValues.map[json["longitude"]]!,
    latitude: messageValues.map[json["latitude"]]!,
    stateId: json["stateId"],
    state: json["state"] == null ? null : State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "street": messageValues.reverse[street],
    "area": messageValues.reverse[area],
    "landmark": messageValues.reverse[landmark],
    "city": messageValues.reverse[city],
    "pinCode": messageValues.reverse[pinCode],
    "longitude": messageValues.reverse[longitude],
    "latitude": messageValues.reverse[latitude],
    "stateId": stateId,
    "state": state?.toJson(),
  };
}

class State {
  int? id;
  String? uniqueGuid;
  Message? name;
  Message? code;
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
    name: messageValues.map[json["name"]]!,
    code: messageValues.map[json["code"]]!,
    numericCode: json["numericCode"],
    countryId: json["countryId"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "code": messageValues.reverse[code],
    "numericCode": numericCode,
    "countryId": countryId,
    "country": country?.toJson(),
  };
}

class Country {
  int? id;
  String? uniqueGuid;
  Message? name;
  Message? code;
  Message? twoLetterCode;
  Message? threeLetterCode;
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
    name: messageValues.map[json["name"]]!,
    code: messageValues.map[json["code"]]!,
    twoLetterCode: messageValues.map[json["twoLetterCode"]]!,
    threeLetterCode: messageValues.map[json["threeLetterCode"]]!,
    numericCode: json["numericCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "code": messageValues.reverse[code],
    "twoLetterCode": messageValues.reverse[twoLetterCode],
    "threeLetterCode": messageValues.reverse[threeLetterCode],
    "numericCode": numericCode,
  };
}

class Enterprise {
  int? id;
  String? uniqueGuid;
  Message? name;
  Message? spocName;
  Message? contactNumber;
  Message? gstNumber;
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
    name: messageValues.map[json["name"]]!,
    spocName: messageValues.map[json["spocName"]]!,
    contactNumber: messageValues.map[json["contactNumber"]]!,
    gstNumber: messageValues.map[json["gstNumber"]]!,
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    enterpriseUser: json["enterpriseUser"] == null ? [] : List<EnterpriseUser>.from(json["enterpriseUser"]!.map((x) => EnterpriseUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "spocName": messageValues.reverse[spocName],
    "contactNumber": messageValues.reverse[contactNumber],
    "gstNumber": messageValues.reverse[gstNumber],
    "contactId": contactId,
    "contact": contact?.toJson(),
    "enterpriseUser": enterpriseUser == null ? [] : List<dynamic>.from(enterpriseUser!.map((x) => x.toJson())),
  };
}

class EnterpriseUser {
  int? id;
  String? uniqueGuid;
  Message? name;
  Message? designation;
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
    name: messageValues.map[json["name"]]!,
    designation: messageValues.map[json["designation"]]!,
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
    "name": messageValues.reverse[name],
    "designation": messageValues.reverse[designation],
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
  Message? firstName;
  Message? lastName;
  Message? emailId;
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
    firstName: messageValues.map[json["firstName"]]!,
    lastName: messageValues.map[json["lastName"]]!,
    emailId: messageValues.map[json["emailId"]]!,
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
    enterpriseUserId: json["enterpriseUserId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "firstName": messageValues.reverse[firstName],
    "lastName": messageValues.reverse[lastName],
    "emailId": messageValues.reverse[emailId],
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
  Message? name;
  Message? type;
  Message? path;
  Message? tags;
  int? length;
  Message? savedFileName;
  Message? actualFileName;
  int? fileType;
  Message? sthreeKey;
  Message? url;
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
    name: messageValues.map[json["name"]]!,
    type: messageValues.map[json["type"]]!,
    path: messageValues.map[json["path"]]!,
    tags: messageValues.map[json["tags"]]!,
    length: json["length"],
    savedFileName: messageValues.map[json["savedFileName"]]!,
    actualFileName: messageValues.map[json["actualFileName"]]!,
    fileType: json["fileType"],
    sthreeKey: messageValues.map[json["sthreeKey"]]!,
    url: messageValues.map[json["url"]]!,
    deviceId: json["deviceId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "type": messageValues.reverse[type],
    "path": messageValues.reverse[path],
    "tags": messageValues.reverse[tags],
    "length": length,
    "savedFileName": messageValues.reverse[savedFileName],
    "actualFileName": messageValues.reverse[actualFileName],
    "fileType": fileType,
    "sthreeKey": messageValues.reverse[sthreeKey],
    "url": messageValues.reverse[url],
    "deviceId": deviceId,
  };
}

class Role {
  int? id;
  String? uniqueGuid;
  Message? name;
  int? maximumMembers;
  Message? profileName;
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
    name: messageValues.map[json["name"]]!,
    maximumMembers: json["maximumMembers"],
    profileName: messageValues.map[json["profileName"]]!,
    isAdmin: json["isAdmin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "maximumMembers": maximumMembers,
    "profileName": messageValues.reverse[profileName],
    "isAdmin": isAdmin,
  };
}

class DeviceDocument {
  int? id;
  String? uniqueGuid;
  Message? name;
  Message? path;
  Message? tags;
  Message? source;
  int? length;
  Message? savedFilename;
  Message? actualFilename;
  Message? url;
  Message? sthreeKey;
  int? fileType;

  DeviceDocument({
    this.id,
    this.uniqueGuid,
    this.name,
    this.path,
    this.tags,
    this.source,
    this.length,
    this.savedFilename,
    this.actualFilename,
    this.url,
    this.sthreeKey,
    this.fileType,
  });

  factory DeviceDocument.fromJson(Map<String, dynamic> json) => DeviceDocument(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    name: messageValues.map[json["name"]]!,
    path: messageValues.map[json["path"]]!,
    tags: messageValues.map[json["tags"]]!,
    source: messageValues.map[json["source"]]!,
    length: json["length"],
    savedFilename: messageValues.map[json["savedFilename"]]!,
    actualFilename: messageValues.map[json["actualFilename"]]!,
    url: messageValues.map[json["url"]]!,
    sthreeKey: messageValues.map[json["sthreeKey"]]!,
    fileType: json["fileType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "path": messageValues.reverse[path],
    "tags": messageValues.reverse[tags],
    "source": messageValues.reverse[source],
    "length": length,
    "savedFilename": messageValues.reverse[savedFilename],
    "actualFilename": messageValues.reverse[actualFilename],
    "url": messageValues.reverse[url],
    "sthreeKey": messageValues.reverse[sthreeKey],
    "fileType": fileType,
  };
}

class Duration {
  int? id;
  String? uniqueGuid;
  Message? name;
  int? durationInMinutes;
  Message? type;

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
    name: messageValues.map[json["name"]]!,
    durationInMinutes: json["durationInMinutes"],
    type: messageValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "name": messageValues.reverse[name],
    "durationInMinutes": durationInMinutes,
    "type": messageValues.reverse[type],
  };
}

class IndividualProfile {
  int? id;
  String? uniqueGuid;
  Message? firstName;
  Message? lastName;
  Message? email;
  bool? isSelf;
  int? contactId;
  Contact? contact;
  int? userId;
  User? user;
  int? profilePictureId;
  ProfilePicture? profilePicture;

  IndividualProfile({
    this.id,
    this.uniqueGuid,
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
  });

  factory IndividualProfile.fromJson(Map<String, dynamic> json) => IndividualProfile(
    id: json["id"],
    uniqueGuid: json["uniqueGuid"],
    firstName: messageValues.map[json["firstName"]]!,
    lastName: messageValues.map[json["lastName"]]!,
    email: messageValues.map[json["email"]]!,
    isSelf: json["isSelf"],
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    userId: json["userId"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uniqueGuid": uniqueGuid,
    "firstName": messageValues.reverse[firstName],
    "lastName": messageValues.reverse[lastName],
    "email": messageValues.reverse[email],
    "isSelf": isSelf,
    "contactId": contactId,
    "contact": contact?.toJson(),
    "userId": userId,
    "user": user?.toJson(),
    "profilePictureId": profilePictureId,
    "profilePicture": profilePicture?.toJson(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
