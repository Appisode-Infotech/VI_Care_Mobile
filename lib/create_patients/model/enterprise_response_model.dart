// To parse this JSON data, do
//
//     final enterpriseResponseModel = enterpriseResponseModelFromJson(jsonString);

import 'dart:convert';

EnterpriseResponseModel enterpriseResponseModelFromJson(String str) => EnterpriseResponseModel.fromJson(json.decode(str));

String enterpriseResponseModelToJson(EnterpriseResponseModel data) => json.encode(data.toJson());

class EnterpriseResponseModel {
  String? message;
  bool? isSuccess;
  dynamic pageResult;
  Result? result;
  dynamic errors;

  EnterpriseResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory EnterpriseResponseModel.fromJson(Map<String, dynamic> json) => EnterpriseResponseModel(
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
  String? emailId;
  String?height;
  String?weight;
  int? contactId;
  Contact? contact;
  int? profilePictureId;
  ProfilePicture? profilePicture;
  int? enterpriseUserId;
  String? uniqueGuid;
  int? id;

  Result({
    this.firstName,
    this.lastName,
    this.emailId,
    this.height,
    this.weight,
    this.contactId,
    this.contact,
    this.profilePictureId,
    this.profilePicture,
    this.enterpriseUserId,
    this.uniqueGuid,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    height: json["height"]?.toString(),
    weight: json["weight"]?.toString(),
    contactId: json["contactId"],
    contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
    enterpriseUserId: json["enterpriseUserId"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "emailId": emailId,
    "height": height?.toString(),
    "weight": weight?.toString(),
    "contactId": contactId,
    "contact": contact?.toJson(),
    "profilePictureId": profilePictureId,
    "profilePicture": profilePicture?.toJson(),
    "enterpriseUserId": enterpriseUserId,
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
  int?countryId;
  Country? country;
  int? stateId;
  States? state;
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
    this.countryId,
    this.country,
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
    countryId: json["countryId"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    stateId: json["stateId"],
    state: json["state"] == null ? null : States.fromJson(json["state"]),
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
    "countryId": countryId,
    "country": country?.toJson(),
    "stateId": stateId,
    "state": state?.toJson(),
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}

class Country {
  String? name;
  String? code;
  String? twoLetterCode;
  String? threeLetterCode;
  int? numericCode;
  String? uniqueGuid;
  int? id;

  Country({
    this.name,
    this.code,
    this.twoLetterCode,
    this.threeLetterCode,
    this.numericCode,
    this.uniqueGuid,
    this.id,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    code: json["code"],
    twoLetterCode: json["twoLetterCode"],
    threeLetterCode: json["threeLetterCode"],
    numericCode: json["numericCode"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "twoLetterCode": twoLetterCode,
    "threeLetterCode": threeLetterCode,
    "numericCode": numericCode,
    "uniqueGuid": uniqueGuid,
    "id": id,
  };
}

class States {
  String? name;
  String? code;
  int? numericCode;
  int? countryId;
  dynamic country;
  String? uniqueGuid;
  int? id;

  States({
    this.name,
    this.code,
    this.numericCode,
    this.countryId,
    this.country,
    this.uniqueGuid,
    this.id,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
    name: json["name"],
    code: json["code"],
    numericCode: json["numericCode"],
    countryId: json["countryId"],
    country: json["country"],
    uniqueGuid: json["uniqueGuid"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "numericCode": numericCode,
    "countryId": countryId,
    "country": country,
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
