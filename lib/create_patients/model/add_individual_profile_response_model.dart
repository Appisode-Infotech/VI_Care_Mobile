// To parse this JSON data, do
//
//     final addIndividualProfileResponseModel = addIndividualProfileResponseModelFromJson(jsonString);

import 'dart:convert';

AddIndividualProfileResponseModel addIndividualProfileResponseModelFromJson(
        String str) =>
    AddIndividualProfileResponseModel.fromJson(json.decode(str));

String addIndividualProfileResponseModelToJson(
        AddIndividualProfileResponseModel data) =>
    json.encode(data.toJson());

class AddIndividualProfileResponseModel {
  String? message;
  bool? isSuccess;
  PageResult? pageResult;
  Result? result;
  List<String>? errors;

  AddIndividualProfileResponseModel({
    this.message,
    this.isSuccess,
    this.pageResult,
    this.result,
    this.errors,
  });

  factory AddIndividualProfileResponseModel.fromJson(
          Map<String, dynamic> json) =>
      AddIndividualProfileResponseModel(
        message: json["message"],
        isSuccess: json["isSuccess"],
        pageResult: json["pageResult"] == null
            ? null
            : PageResult.fromJson(json["pageResult"]),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        errors: json["errors"] == null
            ? []
            : List<String>.from(json["errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "pageResult": pageResult?.toJson(),
        "result": result?.toJson(),
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

class Result {
  int? id;
  String? uniqueGuid;
  String? firstName;
  String? lastName;
  String? email;
  bool? isSelf;
  String? height;
  String? weight;
  int? contactId;
  Contact? contact;
  int? userId;
  User? user;
  int? profilePictureId;
  ProfilePicture? profilePicture;

  Result({
    this.id,
    this.uniqueGuid,
    this.firstName,
    this.lastName,
    this.email,
    this.isSelf,
    this.height,
    this.weight,
    this.contactId,
    this.contact,
    this.userId,
    this.user,
    this.profilePictureId,
    this.profilePicture,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        isSelf: json["isSelf"],
        height: json["height"]?.toString(),
        weight: json["weight"]?.toString(),
        contactId: json["contactId"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        userId: json["userId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        profilePictureId: json["profilePictureId"],
        profilePicture: json["profilePicture"] == null
            ? null
            : ProfilePicture.fromJson(json["profilePicture"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueGuid": uniqueGuid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "isSelf": isSelf,
        "height":height,
        "weight":weight,
        "contactId": contactId,
        "contact": contact?.toJson(),
        "userId": userId,
        "user": user?.toJson(),
        "profilePictureId": profilePictureId,
        "profilePicture": profilePicture?.toJson(),
      };
}

class Contact {
  int? id;
  String? uniqueGuid;
  String? firstname;
  String? lastName;
  String? email;
  String? contactNumber;
  String? doB;
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
        doB: json["doB"],
        gender: json["gender"],
        bloodGroup: json["bloodGroup"],
        addressId: json["addressId"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueGuid": uniqueGuid,
        "firstname": firstname,
        "lastName": lastName,
        "email": email,
        "contactNumber": contactNumber,
        "doB": doB,
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
  States? state;

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
        state: json["state"] == null ? null : States.fromJson(json["state"]),
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

class States {
  int? id;
  String? uniqueGuid;
  String? name;
  String? code;
  int? numericCode;
  int? countryId;
  Country? country;

  States({
    this.id,
    this.uniqueGuid,
    this.name,
    this.code,
    this.numericCode,
    this.countryId,
    this.country,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        name: json["name"],
        code: json["code"],
        numericCode: json["numericCode"],
        countryId: json["countryId"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
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
  Device? device;

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
    this.device,
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
        device: json["device"] == null ? null : Device.fromJson(json["device"]),
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
        "device": device?.toJson(),
      };
}

class Device {
  int? id;
  String? uniqueGuid;
  String? name;
  String? serialNo;
  String? manufacturer;
  bool? isPaired;
  String? pairedDate;
  int? deviceStatus;
  String? description;
  int? purchaseCost;
  int? sellingCost;
  int? warrantyDuration;
  int? validity;
  String? deviceType;
  String? ipAddress;
  int? allocationStatus;
  String? remarks;
  int? subscriberDeviceId;
  int? userId;
  String? user;
  int? subscriberId;
  Subscriber? subscriber;

  Device({
    this.id,
    this.uniqueGuid,
    this.name,
    this.serialNo,
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
        name: json["name"],
        serialNo: json["serialNo"],
        manufacturer: json["manufacturer"],
        isPaired: json["isPaired"],
        pairedDate: json["pairedDate"],
        deviceStatus: json["deviceStatus"],
        description: json["description"],
        purchaseCost: json["purchaseCost"],
        sellingCost: json["sellingCost"],
        warrantyDuration: json["warrantyDuration"],
        validity: json["validity"],
        deviceType: json["deviceType"],
        ipAddress: json["ipAddress"],
        allocationStatus: json["allocationStatus"],
        remarks: json["remarks"],
        subscriberDeviceId: json["subscriberDeviceId"],
        userId: json["userId"],
        user: json["user"],
        subscriberId: json["subscriberId"],
        subscriber: json["subscriber"] == null
            ? null
            : Subscriber.fromJson(json["subscriber"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueGuid": uniqueGuid,
        "name": name,
        "serialNo": serialNo,
        "manufacturer": manufacturer,
        "isPaired": isPaired,
        "pairedDate": pairedDate,
        "deviceStatus": deviceStatus,
        "description": description,
        "purchaseCost": purchaseCost,
        "sellingCost": sellingCost,
        "warrantyDuration": warrantyDuration,
        "validity": validity,
        "deviceType": deviceType,
        "ipAddress": ipAddress,
        "allocationStatus": allocationStatus,
        "remarks": remarks,
        "subscriberDeviceId": subscriberDeviceId,
        "userId": userId,
        "user": user,
        "subscriberId": subscriberId,
        "subscriber": subscriber?.toJson(),
      };
}

class Subscriber {
  int? id;
  String? uniqueGuid;
  String? companyName;
  String? displayName;
  String? email;
  String? contactNumber;
  String? contactPersonName;
  String? address;
  int? subscriberEngineId;
  String? gstNumber;
  int? applicationId;

  Subscriber({
    this.id,
    this.uniqueGuid,
    this.companyName,
    this.displayName,
    this.email,
    this.contactNumber,
    this.contactPersonName,
    this.address,
    this.subscriberEngineId,
    this.gstNumber,
    this.applicationId,
  });

  factory Subscriber.fromJson(Map<String, dynamic> json) => Subscriber(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        companyName: json["companyName"],
        displayName: json["displayName"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        contactPersonName: json["contactPersonName"],
        address: json["address"],
        subscriberEngineId: json["subscriberEngineId"],
        gstNumber: json["gstNumber"],
        applicationId: json["applicationId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueGuid": uniqueGuid,
        "companyName": companyName,
        "displayName": displayName,
        "email": email,
        "contactNumber": contactNumber,
        "contactPersonName": contactPersonName,
        "address": address,
        "subscriberEngineId": subscriberEngineId,
        "gstNumber": gstNumber,
        "applicationId": applicationId,
      };
}

class User {
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
  UserEnterprise? enterprise;
  int? enterpriseUserId;
  EnterpriseUser? enterpriseUser;

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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        roleId: json["roleId"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        profilePictureId: json["profilePictureId"],
        profilePicture: json["profilePicture"] == null
            ? null
            : ProfilePicture.fromJson(json["profilePicture"]),
        enterpriseId: json["enterpriseId"],
        enterprise: json["enterprise"] == null
            ? null
            : UserEnterprise.fromJson(json["enterprise"]),
        enterpriseUserId: json["enterpriseUserId"],
        enterpriseUser: json["enterpriseUser"] == null
            ? null
            : EnterpriseUser.fromJson(json["enterpriseUser"]),
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
      };
}

class UserEnterprise {
  int? id;
  String? uniqueGuid;
  String? name;
  String? spocName;
  String? contactNumber;
  String? gstNumber;
  int? contactId;
  Contact? contact;
  List<EnterpriseUser>? enterpriseUser;

  UserEnterprise({
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

  factory UserEnterprise.fromJson(Map<String, dynamic> json) => UserEnterprise(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        name: json["name"],
        spocName: json["spocName"],
        contactNumber: json["contactNumber"],
        gstNumber: json["gstNumber"],
        contactId: json["contactId"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        enterpriseUser: json["enterpriseUser"] == null
            ? []
            : List<EnterpriseUser>.from(
                json["enterpriseUser"]!.map((x) => EnterpriseUser.fromJson(x))),
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
        "enterpriseUser": enterpriseUser == null
            ? []
            : List<dynamic>.from(enterpriseUser!.map((x) => x.toJson())),
      };
}

class EnterpriseUser {
  int? id;
  String? uniqueGuid;
  String? name;
  String? designation;
  int? roleId;
  Role? role;
  int? enterpriseId;
  EnterpriseUserEnterprise? enterprise;
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
    this.enterpriseId,
    this.enterprise,
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
        enterpriseId: json["enterpriseId"],
        enterprise: json["enterprise"] == null
            ? null
            : EnterpriseUserEnterprise.fromJson(json["enterprise"]),
        profilePictureId: json["profilePictureId"],
        profilePicture: json["profilePicture"] == null
            ? null
            : ProfilePicture.fromJson(json["profilePicture"]),
        enterpriseProfile: json["enterpriseProfile"] == null
            ? []
            : List<EnterpriseProfile>.from(json["enterpriseProfile"]!
                .map((x) => EnterpriseProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueGuid": uniqueGuid,
        "name": name,
        "designation": designation,
        "roleId": roleId,
        "role": role?.toJson(),
        "enterpriseId": enterpriseId,
        "enterprise": enterprise?.toJson(),
        "profilePictureId": profilePictureId,
        "profilePicture": profilePicture?.toJson(),
        "enterpriseProfile": enterpriseProfile == null
            ? []
            : List<dynamic>.from(enterpriseProfile!.map((x) => x.toJson())),
      };
}

class EnterpriseUserEnterprise {
  int? id;
  String? uniqueGuid;
  String? name;
  String? spocName;
  String? contactNumber;
  String? gstNumber;
  int? contactId;
  Contact? contact;
  List<String>? enterpriseUser;

  EnterpriseUserEnterprise({
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

  factory EnterpriseUserEnterprise.fromJson(Map<String, dynamic> json) =>
      EnterpriseUserEnterprise(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        name: json["name"],
        spocName: json["spocName"],
        contactNumber: json["contactNumber"],
        gstNumber: json["gstNumber"],
        contactId: json["contactId"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        enterpriseUser: json["enterpriseUser"] == null
            ? []
            : List<String>.from(json["enterpriseUser"]!.map((x) => x)),
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
        "enterpriseUser": enterpriseUser == null
            ? []
            : List<dynamic>.from(enterpriseUser!.map((x) => x)),
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

  factory EnterpriseProfile.fromJson(Map<String, dynamic> json) =>
      EnterpriseProfile(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailId: json["emailId"],
        contactId: json["contactId"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        profilePictureId: json["profilePictureId"],
        profilePicture: json["profilePicture"] == null
            ? null
            : ProfilePicture.fromJson(json["profilePicture"]),
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

class Role {
  int? id;
  String? uniqueGuid;
  String? name;
  int? maximumMembers;
  String? profileName;

  Role({
    this.id,
    this.uniqueGuid,
    this.name,
    this.maximumMembers,
    this.profileName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        uniqueGuid: json["uniqueGuid"],
        name: json["name"],
        maximumMembers: json["maximumMembers"],
        profileName: json["profileName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueGuid": uniqueGuid,
        "name": name,
        "maximumMembers": maximumMembers,
        "profileName": profileName,
      };
}
