import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:vicare/auth/model/reset_password_response_model.dart';
import 'package:vicare/auth/model/send_otp_response_model.dart';
import 'package:vicare/create_patients/model/add_individual_profile_response_model.dart';
import 'package:vicare/create_patients/model/all_patients_response_model.dart';
import 'package:vicare/create_patients/model/edit_profile_response_model.dart';
import 'package:vicare/create_patients/model/enterprise_response_model.dart';
import 'package:vicare/create_patients/model/individual_response_model.dart';
import 'package:vicare/dashboard/model/add_device_response_model.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../auth/model/register_response_model.dart';
import '../auth/model/role_master_response_model.dart';
import '../create_patients/model/all_enterprise_users_response_model.dart';
import '../dashboard/model/duration_response_model.dart';
import '../main.dart';
import '../utils/url_constants.dart';

String platform = Platform.isIOS ? "IOS" : "Android";

class ApiCalls {
  Future<http.Response> hitApiPost(
      bool requiresAuth, String url, String body) async {
    return await http.post(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
      body: body,
    );
  }

  Future<http.Response> hitApiGet(bool requiresAuth, String url) async {
    return await http.get(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
    );
  }

  Future<http.Response> hitApiPut(bool requiresAuth, String url) async {
    return await http.get(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
    );
  }

  Map<String, String> getHeaders(bool isAuthEnabled) {
    var headers = <String, String>{};
    if (isAuthEnabled) {
      headers.addAll({
        "Authorization": "Bearer ${prefModel.userData!.token}",
        "Content-Type": "application/json"
      });
    } else {
      headers.addAll({"Content-Type": "application/json"});
    }
    return headers;
  }

  Future<SendOtpResponseModel> sendOtpToRegister(
      String email, BuildContext? context) async {
    http.Response response = await hitApiPost(false,
        UrlConstants.sendOtpToRegister + email, jsonEncode({"email": email}));
    if (response.statusCode == 200) {
      return SendOtpResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not send otp ${response.statusCode}";
    }
  }

  Future<RoleMasterResponseModel> getMasterRoles(BuildContext? context) async {
    http.Response response = await hitApiGet(false, UrlConstants.getRoleMaster);
    if (response.statusCode == 200) {
      return RoleMasterResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not get the roles ${response.statusCode}";
    }
  }

  Future<RegisterResponseModel> registerNewUser({
    File? profilePic,
    required String dob,
    required String fName,
    required String lName,
    required String email,
    int? gender,
    int? roleId,
    String? bloodGroup,
    required String contact,
    required String password,
    BuildContext? context,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstants.registerUser));
    request.fields['Contact.Dob'] = dob;
    request.fields['Contact.Firstname'] = fName;
    request.fields['Contact.Email'] = email;
    request.fields['Contact.Gender'] = gender.toString();
    request.fields['Contact.LastName'] = lName;
    request.fields['RoleId'] = roleId.toString();
    request.fields['Contact.BloodGroup'] = bloodGroup ?? '';
    request.fields['Contact.ContactNumber'] = contact;
    request.fields['Password'] = password;
    if (profilePic != null) {
      var picStream = http.ByteStream(profilePic.openRead());
      var length = await profilePic.length();
      var multipartFile = http.MultipartFile(
        'profilePic',
        picStream,
        length,
        filename: profilePic.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseJson = json.decode(utf8.decode(responseData));
      return RegisterResponseModel.fromJson(responseJson);
    } else if (response.statusCode == 204) {
      Navigator.pop(context!);
      showErrorToast(context, "Email or phone may exist.");
      throw "could not register ${response.statusCode}";
    } else if (response.statusCode == 400) {
      Navigator.pop(context!);
      showErrorToast(context, "Invalid data please check.");
      throw "could not register ${response.statusCode}";
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not register ${response.statusCode}";
    }
  }

  Future<RegisterResponseModel> loginUser(
      String email, String password, BuildContext buildContext) async {
    http.Response response = await hitApiPost(false, UrlConstants.loginUser,
        jsonEncode({"email": email.trim(), 'password': password}));
    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(buildContext);
      showErrorToast(buildContext, "Something went wrong");
      throw "could not login ${response.statusCode}";
    }
  }

  Future<SendOtpResponseModel> sendOtpToResetPassword(
      String email, BuildContext buildContext) async {
    http.Response response = await hitApiPost(
        false,
        UrlConstants.sendOtpToResetPassword + email,
        jsonEncode({"email": email}));
    if (response.statusCode == 200) {
      return SendOtpResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(buildContext);
      showErrorToast(buildContext, "Something went wrong");
      throw "could not sent otp ${response.statusCode}";
    }
  }

  Future<AddIndividualProfileResponseModel> addIndividualProfile(
      String dob,
      String mobile,
      String email,
      String fName,
      String lName,
      String address,
      String gender,
      File? selectedImage,
      BuildContext? context,
      String bloodGroup) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.addIndividualProfile));
    request.fields['IsSelf'] = false.toString();
    request.fields['Contact.Dob'] = dob;
    request.fields['Contact.Firstname'] = fName;
    request.fields['Contact.Email'] = email;
    request.fields['Contact.Gender'] = gender.toString();
    request.fields['Contact.LastName'] = lName;
    request.fields['Contact.ContactNumber'] = mobile;
    request.fields['Contact.BloodGroup'] = bloodGroup.toString();
    request.fields['UserId'] = prefModel.userData!.id.toString();
    if (selectedImage != null) {
      var picStream = http.ByteStream(selectedImage.openRead());
      var length = await selectedImage.length();
      var multipartFile = http.MultipartFile(
        'uploadedFile',
        picStream,
        length,
        filename: selectedImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    request.headers.addAll({
      "Authorization": "Bearer ${prefModel.userData!.token}",
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseJson = json.decode(utf8.decode(responseData));
      return AddIndividualProfileResponseModel.fromJson(responseJson);
    } else if (response.statusCode == 401) {
      Navigator.pop(context!);
      showErrorToast(context, "Unauthorized");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 204) {
      Navigator.pop(context!);
      showErrorToast(context, "Email or phone may exist.");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 400) {
      Navigator.pop(context!);
      showErrorToast(context, "Invalid data please check.");
      throw "could not add the profile ${response.statusCode}";
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not add the profile ${response.statusCode}";
    }
  }

  Future<AddIndividualProfileResponseModel> addEnterpriseProfile(
      String dob,
      String mobile,
      String email,
      String fName,
      String lName,
      String address,
      String gender,
      File? selectedImage,
      BuildContext? context,
      String bloodGroup) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.addEnterpriseProfile));
    request.fields['Contact.Dob'] = dob;
    request.fields['Contact.Firstname'] = fName;
    request.fields['Contact.Email'] = email;
    request.fields['Contact.Gender'] = gender.toString();
    request.fields['Contact.LastName'] = lName;
    request.fields['Contact.ContactNumber'] = mobile;
    request.fields['Contact.BloodGroup'] = bloodGroup;
    request.fields['EnterpriseUserId'] =
        prefModel.userData!.enterpriseUserId.toString();
    if (selectedImage != null) {
      var picStream = http.ByteStream(selectedImage.openRead());
      var length = await selectedImage.length();
      var multipartFile = http.MultipartFile(
        'uploadedFile',
        picStream,
        length,
        filename: selectedImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    request.headers.addAll({
      "Authorization": "Bearer ${prefModel.userData!.token}",
    });

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    if (response.statusCode == 200) {
      return AddIndividualProfileResponseModel.fromJson(responseJson);
    } else if (response.statusCode == 401) {
      Navigator.pop(context!);
      showErrorToast(context, "Unauthorized");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 204) {
      Navigator.pop(context!);
      showErrorToast(context, "Email or phone may exist.");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 400) {
      Navigator.pop(context!);
      showErrorToast(context, "Invalid data please check.");
      throw "could not add the profile ${response.statusCode}";
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not add the profile ${response.statusCode}";
    }
  }

  resetPassword(
      String email, String password, BuildContext buildContext) async {
    http.Response response = await hitApiPost(false, UrlConstants.resetPassword,
        jsonEncode({"Email": email, "NewPassword": password}));
    if (response.statusCode == 200) {
      return ResetPasswordResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(buildContext);
      showErrorToast(buildContext, "Something went wrong");
      throw "could not reset password ${response.statusCode}";
    }
  }

  Future<AddIndividualProfileResponseModel> editPatient(
    String dob,
    String mobile,
    String email,
    String fName,
    String lName,
    String address,
    String gender,
    File? patientPic,
    BuildContext? context,
    String bloodGroup,
    String userID,
    String contactId,
    String id,
  ) async {
    var request = http.MultipartRequest(
        'PUT', Uri.parse(UrlConstants.addIndividualProfile));
    request.fields['Contact.Dob'] = dob;
    request.fields['Contact.ContactNumber'] = mobile;
    request.fields['Contact.Email'] = email;
    request.fields['Contact.Firstname'] = fName;
    request.fields['Contact.LastName'] = lName;
    request.fields['Contact.Gender'] = gender;
    request.fields['UserId'] = userID;
    request.fields['Id'] = id;
    request.fields['Contact.Id'] = contactId;
    request.fields['Contact.BloodGroup'] = bloodGroup;
    if (patientPic != null) {
      var picStream = http.ByteStream(patientPic.openRead());
      var length = await patientPic.length();
      var multipartFile = http.MultipartFile(
        'uploadedFile',
        picStream,
        length,
        filename: patientPic.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    request.headers.addAll({
      "Authorization": "Bearer ${prefModel.userData!.token}",
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseJson = json.decode(utf8.decode(responseData));
      return AddIndividualProfileResponseModel.fromJson(responseJson);
    } else if (response.statusCode == 401) {
      Navigator.pop(context!);
      showErrorToast(context, "Unauthorized");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 204) {
      Navigator.pop(context!);
      showErrorToast(context, "Email or phone may exist.");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 405) {
      Navigator.pop(context!);
      showErrorToast(context, "Invalid data please check.");
      throw "could not add the profile ${response.statusCode}";
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not add the profile ${response.statusCode}";
    }
  }

  Future<AddIndividualProfileResponseModel> editEnterprise(
      String email,
      String fName,
      String lName,
      String dob,
      String address,
      String mobile,
      String gender,
      File? patientPic,
      BuildContext? context,
      String bloodGroup,
      String eUserId,
      String id,
      String contactId) async {
    var request = http.MultipartRequest(
        'PUT', Uri.parse(UrlConstants.addEnterpriseProfile));
    request.fields['Contact.Dob'] = dob;
    request.fields['Contact.Firstname'] = fName;
    request.fields['Contact.Email'] = email;
    request.fields['Contact.Gender'] = gender.toString();
    request.fields['Contact.LastName'] = lName;
    request.fields['Contact.ContactNumber'] = mobile;
    request.fields['EnterpriseUserId'] = eUserId;
    request.fields['Contact.BloodGroup'] = bloodGroup;
    request.fields['Id'] = id;
    request.fields['Contact.Id'] = contactId;
    if (patientPic != null) {
      var picStream = http.ByteStream(patientPic.openRead());
      var length = await patientPic.length();
      var multipartFile = http.MultipartFile(
        'uploadedFile',
        picStream,
        length,
        filename: patientPic.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    request.headers.addAll({
      "Authorization": "Bearer ${prefModel.userData!.token}",
    });
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    if (response.statusCode == 200) {
      return AddIndividualProfileResponseModel.fromJson(responseJson);
    } else if (response.statusCode == 401) {
      Navigator.pop(context!);
      showErrorToast(context, "Unauthorized");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 204) {
      Navigator.pop(context!);
      showErrorToast(context, "Email or phone may exist.");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 405) {
      Navigator.pop(context!);
      showErrorToast(context, "Invalid data please check.");
      throw "could not add the profile ${response.statusCode}";
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not add the profile ${response.statusCode}";
    }
  }

  Future<AllPatientsResponseModel> getMyIndividualUsers(
      BuildContext context) async {
    http.Response response = await hitApiGet(true,
        "${UrlConstants.getIndividualProfiles}/GetAllByUserId${prefModel.userData!.id}");
    if (response.statusCode == 200) {
      return AllPatientsResponseModel.fromJson(json.decode(response.body));
    } else {
      showErrorToast(context, "Something went wrong");
      throw "could not fetch data ${response.statusCode}";
    }
  }

  Future<AllEnterpriseUsersResponseModel> getMyEnterpriseUsers(
      BuildContext context) async {
    http.Response response = await hitApiGet(true,
        "${UrlConstants.getEnterpriseProfiles}/GetAllByUserId${prefModel.userData!.enterpriseUserId}");
    if (response.statusCode == 200) {
      return AllEnterpriseUsersResponseModel.fromJson(
          json.decode(response.body));
    } else {
      showErrorToast(context, "Something went wrong");
      throw "could not fetch EnterPrise ${response.statusCode}";
    }
  }

  Future<IndividualResponseModel> getIndividualUserData(
      String? pId, BuildContext context) async {
    http.Response response =
        await hitApiGet(true, "${UrlConstants.getIndividualProfiles}/${pId}");
    if (response.statusCode == 200) {
      return IndividualResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      showErrorToast(context, "Something went wrong");
      throw "could not fetch Data ${response.statusCode}";
    }
  }

  Future<EnterpriseResponseModel> getEnterpriseUserData(
      String? eId, BuildContext context) async {
    http.Response response =
        await hitApiGet(true, "${UrlConstants.getEnterpriseProfiles}/${eId}");
    if (response.statusCode == 200) {
      return EnterpriseResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      showErrorToast(context, "Something went wrong");
      throw "could not fetch Data ${response.statusCode}";
    }
  }

  Future<AddDeviceResponseModel> addDevice(
      String type, String serialNo, BuildContext context) async {
    http.Response response = await hitApiPost(
        true,
        "${UrlConstants.userAndDevice}",
        jsonEncode({
          "type": type,
          "deviceSerialNo": serialNo,
          "roleId": prefModel.userData!.roleId,
          "userId": prefModel.userData!.id
        }));
    if (response.statusCode == 200) {
      return AddDeviceResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      Navigator.pop(context);
      showErrorToast(context, "Unauthorized");
      throw "could not add the device ${response.statusCode}";
    } else {
      Navigator.pop(context);
      showErrorToast(context, "Something went wrong");
      throw "could not add the device ${response.statusCode}";
    }
  }

  Future<DurationResponseModel> getAllDurations() async {
    http.Response response =
        await hitApiGet(true, UrlConstants.getAllDurations);
    if (response.statusCode == 200) {
      return DurationResponseModel.fromJson(json.decode(response.body));
    } else {
      throw "could not get the roles ${response.statusCode}";
    }
  }

  Future<File?> downloadImageAndReturnFilePath(String imageUrl) async {
    try {
      // Fetch the image data
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Create a temporary file
        File tempFile = File(
            '${Directory.systemTemp.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Write the image data to the temporary file
        await tempFile.writeAsBytes(response.bodyBytes);

        // Return the path to the temporary file
        return tempFile;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<EditProfileResponseModel> editIndividualProfile(
      String fName,
      String lName,
      String mobile,
      String bloodGroup,
      String gender,
      String dob,
      File? profilePic,
      BuildContext? context,
      int? id,
      int? contactId) async {
    var request =
        http.MultipartRequest('PUT', Uri.parse(UrlConstants.updateProfile));
    request.fields['Firstname'] = fName;
    request.fields['LastName'] = lName;
    request.fields['BloodGroup'] = bloodGroup;
    request.fields['Gender'] = gender;
    request.fields['Dob'] = dob;
    if (profilePic != null) {
      var picStream = http.ByteStream(profilePic.openRead());
      var length = await profilePic.length();
      var multipartFile = http.MultipartFile(
        'profilePic',
        picStream,
        length,
        filename: profilePic.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    request.headers.addAll({
      "Authorization": "Bearer ${prefModel.userData!.token}",
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseJson = json.decode(utf8.decode(responseData));
      return EditProfileResponseModel.fromJson(responseJson);
    } else if (response.statusCode == 401) {
      Navigator.pop(context!);
      showErrorToast(context, "Unauthorized");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 204) {
      Navigator.pop(context!);
      showErrorToast(context, "Email or phone may exist.");
      throw "could not add the profile ${response.statusCode}";
    } else if (response.statusCode == 405) {
      Navigator.pop(context!);
      showErrorToast(context, "Invalid data please check.");
      throw "could not add the profile ${response.statusCode}";
    } else {
      Navigator.pop(context!);
      showErrorToast(context, "Something went wrong");
      throw "could not add the profile ${response.statusCode}";
    }
  }

  Future<SendOtpResponseModel> sendOtpToChangePassword(
      String? email, BuildContext context, bool newPassword) async {
    http.Response response = await hitApiPost(
        false,
        UrlConstants.sendOtpToResetPassword +
            prefModel.userData!.email.toString(),
        jsonEncode({"email": email}));
    if (response.statusCode == 200) {
      return SendOtpResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      showErrorToast(context, "Something went wrong");
      throw "could not sent otp ${response.statusCode}";
    }
  }

  Future<ResetPasswordResponseModel> resetNewPassword(
      bool password, String? changePswEmail, BuildContext context) async {
    http.Response response = await hitApiPost(false, UrlConstants.resetPassword,
        jsonEncode({"Email": changePswEmail, "NewPassword": password}));
    if (response.statusCode == 200) {
      return ResetPasswordResponseModel.fromJson(json.decode(response.body));
    } else {
      showErrorToast(context, "Something went wrong");
      throw "could not reset password ${response.statusCode}";
    }
  }
}
