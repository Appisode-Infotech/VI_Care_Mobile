import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:vicare/auth/model/refresh_token_response_model.dart';
import 'package:vicare/auth/model/reset_password_response_model.dart';
import 'package:vicare/auth/model/send_otp_response_model.dart';
import 'package:vicare/create_patients/model/add_individual_profile_response_model.dart';
import 'package:vicare/create_patients/model/all_patients_response_model.dart';
import 'package:vicare/create_patients/model/country_master_response_model.dart';
import 'package:vicare/create_patients/model/enterprise_response_model.dart';
import 'package:vicare/create_patients/model/individual_response_model.dart';
import 'package:vicare/create_patients/model/state_master_response_model.dart';
import 'package:vicare/dashboard/model/add_device_response_model.dart';
import 'package:vicare/dashboard/model/device_data_response_model.dart';
import 'package:vicare/dashboard/model/device_delete_response_model.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';
import 'package:vicare/dashboard/model/reports_detail_model.dart';
import 'package:vicare/database/app_pref.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../auth/model/register_response_model.dart';
import '../auth/model/role_master_response_model.dart';
import '../create_patients/model/all_enterprise_users_response_model.dart';
import '../create_patients/model/check_request_count_model.dart';
import '../create_patients/model/dashboard_count_response_model.dart';
import '../dashboard/model/detailed_report_ddf_model.dart';
import '../dashboard/model/duration_response_model.dart';
import '../dashboard/model/my_reports_response_model.dart';
import '../dashboard/model/offline_test_model.dart';
import '../dashboard/model/summary_report_response_model.dart';
import '../main.dart';
import '../utils/app_locale.dart';
import '../utils/url_constants.dart';

String platform = Platform.isIOS ? "IOS" : "Android";

class ApiCalls {
  Future<http.Response> hitApiPost(bool requiresAuth, String url, String body) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: getHeaders(requiresAuth),
        body: body,
      );

      if (response.statusCode == 401) {
        // Attempt to refresh the token
        http.Response refreshTokenResponse = await http.post(
          Uri.parse(UrlConstants.getRefreshToken),
          headers: getHeaders(false),
          body: jsonEncode({
            "token": prefModel.userData!.token.toString(),
            "refreshToken": prefModel.userData!.refreshToken.toString(),
          }),
        );

        if (refreshTokenResponse.statusCode == 200) {
          RefreshTokenResponseModel resModel = RefreshTokenResponseModel.fromJson(
            json.decode(refreshTokenResponse.body),
          );

          if (resModel.result != null) {
            // Update tokens
            prefModel.userData!.token = resModel.result!.token;
            prefModel.userData!.refreshToken = resModel.result!.refreshToken;
            await AppPref.setPref(prefModel);

            // Retry the original request with the new token
            http.Response retryResponse = await http.post(
              Uri.parse(url),
              headers: getHeaders(requiresAuth),
              body: body,
            );

            return retryResponse;
          } else {
            print("Failed to refresh token: ${resModel.message}");
            throw Exception("Failed to refresh token: ${resModel.message}");
          }
        } else {
          print("Failed to refresh token, status code: ${refreshTokenResponse.statusCode}");
          throw Exception("Failed to refresh token, status code: ${refreshTokenResponse.statusCode}");
        }
      } else {
        return response;
      }
    } catch (e) {
      print("Error during POST request: $e");
      rethrow;
    }
  }

  Future<http.Response> hitApiGet(bool requiresAuth, String url) async {
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: getHeaders(requiresAuth),
      );

      if (response.statusCode == 401) {
        // Attempt to refresh the token
        http.Response refreshTokenResponse = await http.post(
          Uri.parse(UrlConstants.getRefreshToken),
          headers: getHeaders(false),
          body: jsonEncode({
            "token": prefModel.userData!.token.toString(),
            "refreshToken": prefModel.userData!.refreshToken.toString(),
          }),
        );

        if (refreshTokenResponse.statusCode == 200) {
          RefreshTokenResponseModel resModel = RefreshTokenResponseModel.fromJson(
            json.decode(refreshTokenResponse.body),
          );

          if (resModel.result != null) {
            // Update tokens
            prefModel.userData!.token = resModel.result!.token;
            prefModel.userData!.refreshToken = resModel.result!.refreshToken;
            await AppPref.setPref(prefModel);

            // Retry the original request with the new token
            http.Response retryResponse = await http.get(
              Uri.parse(url),
              headers: getHeaders(requiresAuth),
            );

            return retryResponse;
          } else {
            print("Failed to refresh token: ${resModel.message}");
            throw Exception("Failed to refresh token: ${resModel.message}");
          }
        } else {
          print("Failed to refresh token, status code: ${refreshTokenResponse.statusCode}");
          throw Exception("Failed to refresh token, status code: ${refreshTokenResponse.statusCode}");
        }
      } else {
        return response;
      }
    } catch (e) {
      print("Error during GET request: $e");
      rethrow;
    }
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

  getRefreshToken() async {
    http.Response refreshTokenResponse = await http.post(
      Uri.parse(UrlConstants.getRefreshToken),
      headers: getHeaders(false),
      body: jsonEncode({
        "token": prefModel.userData!.token.toString(),
        "refreshToken": prefModel.userData!.refreshToken.toString()
      }),
    );
    RefreshTokenResponseModel resModel = RefreshTokenResponseModel.fromJson(
        json.decode(refreshTokenResponse.body));
    if (refreshTokenResponse.statusCode == 200 && resModel.result != null) {
      prefModel.userData!.token = resModel.result!.token;
      prefModel.userData!.refreshToken = resModel.result!.refreshToken;
      await AppPref.setPref(prefModel);
    } else {
      throw resModel.message.toString();
    }
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
    int? state,
    required String street,
    required String area,
    required String landMark,
    required String city,
    required String pinCode,
    int? country,
    required String height,
    required String weight,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstants.registerUser));
    request.fields['Contact.Dob'] = dob;
    request.fields['Contact.FirstName'] = fName;
    request.fields['Contact.LastName'] = lName;
    request.fields['Contact.Email'] = email;
    request.fields['Contact.Gender'] = gender.toString();
    request.fields['Contact.BloodGroup'] = bloodGroup ?? '';
    request.fields['RoleId'] = roleId.toString();
    request.fields['Password'] = password;
    request.fields['Contact.Address.StateId'] = state.toString();
    request.fields['Contact.ContactNumber'] = contact;
    request.fields['Contact.Address.Street'] = street;
    request.fields['Contact.Address.Area'] = area;
    request.fields['Contact.Address.Landmark'] = landMark;
    request.fields['Contact.Address.City'] = city;
    request.fields['Contact.Address.PinCode'] = pinCode;
    request.fields['Contact.Address.CountryId'] = country.toString();
    request.fields['Height'] = height;
    request.fields['Weight'] = weight;
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
    String? fcmToken =
        await FirebaseMessaging.instance.getToken(); // fcm token imp
    http.Response response = await hitApiPost(
        false,
        UrlConstants.loginUser,
        jsonEncode({
          "email": email.trim(),
          'password': password,
          'fcmToken': fcmToken
        }));
    if (response.statusCode == 200) {
      log(response.body);
      return RegisterResponseModel.fromJson
        (json.decode(response.body));
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
      String gender,
      File? selectedImage,
      BuildContext? context,
      String bloodGroup,
      String street,
      String area,
      String landMark,
      String city,
      String pinCode,
      int? stateId,
      int? selectedCountryId,
      String height,
      String weight) async {
    Future<AddIndividualProfileResponseModel> sendRequest() async {
      var request = http.MultipartRequest(
          'POST', Uri.parse(UrlConstants.addIndividualProfile));
      request.fields['IsSelf'] = false.toString();
      request.fields['Contact.Dob'] = dob;
      request.fields['Contact.ContactNumber'] = mobile;
      request.fields['Contact.Email'] = email;
      request.fields['Contact.FirstName'] = fName;
      request.fields['Contact.LastName'] = lName;
      request.fields['Contact.Gender'] = gender.toString();
      request.fields['Contact.BloodGroup'] = bloodGroup.toString();
      request.fields['Contact.Address.Street'] = street;
      request.fields['Contact.Address.Area'] = area;
      request.fields['Contact.Address.Landmark'] = landMark;
      request.fields['Contact.Address.City'] = city;
      request.fields['Contact.Address.PinCode'] = pinCode;
      request.fields['Contact.Address.StateId'] = stateId.toString();
      request.fields['Contact.Address.CountryId'] =
          selectedCountryId.toString();
      request.fields['height'] = height;
      request.fields['weight'] = weight;
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
        throw 'Unauthorized';
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

    try {
      return await sendRequest();
    } catch (e) {
      if (e == 'Unauthorized') {
        await getRefreshToken();
        return await sendRequest();
      } else {
        rethrow;
      }
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
      String bloodGroup,
      String street,
      String area,
      String landMark,
      String city,
      String pinCode,
      int? stateId,
      int? selectedCountryId,
      String height,
      String weight) async {
    Future<AddIndividualProfileResponseModel> sendRequest() async {
      var request = http.MultipartRequest(
          'POST', Uri.parse(UrlConstants.addEnterpriseProfile));
      request.fields['Contact.Dob'] = dob;
      request.fields['Contact.FirstName'] = fName;
      request.fields['Contact.Email'] = email;
      request.fields['Contact.Gender'] = gender;
      request.fields['Contact.LastName'] = lName;
      request.fields['Contact.ContactNumber'] = mobile;
      request.fields['Contact.BloodGroup'] = bloodGroup;
      request.fields['Contact.Address.Street'] = street;
      request.fields['Contact.Address.Area'] = area;
      request.fields['Contact.Address.Landmark'] = landMark;
      request.fields['Contact.Address.City'] = city;
      request.fields['Contact.Address.PinCode'] = pinCode;
      request.fields['Contact.Address.StateId'] = stateId.toString();
      request.fields['Contact.Address.CountryId'] =
          selectedCountryId.toString();
      request.fields['Height'] = height;
      request.fields['Weight'] = weight;
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
        throw 'Unauthorized';
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

    try {
      return await sendRequest();
    } catch (e) {
      if (e == 'Unauthorized') {
        await getRefreshToken();
        return await sendRequest();
      } else {
        rethrow;
      }
    }
  }

  resetPassword(
      String email, String password, BuildContext buildContext) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstants.resetPassword));
    request.fields['Email'] = email.toString();
    request.fields['NewPassword'] = password.toString();
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseJson = json.decode(utf8.decode(responseData));
      return ResetPasswordResponseModel.fromJson(responseJson);
    } else {
      Navigator.pop(buildContext);
      showErrorToast(buildContext, "Something went wrong");
      throw "could not add the profile ${response.statusCode}";
    }
  }

  Future<AddIndividualProfileResponseModel> editPatient(
      String dob,
      String mobile,
      String email,
      String fName,
      String lName,
      String gender,
      File? patientPic,
      BuildContext? context,
      String bloodGroup,
      String userID,
      String contactId,
      String id,
      String street,
      String area,
      String pinCode,
      String city,
      String landMark,
      String addressId,
      String height,
      String weight,
      String editCountryId,
      String editStateId) async {
    Future<AddIndividualProfileResponseModel> sendRequest() async {
      var request = http.MultipartRequest(
          'PUT', Uri.parse(UrlConstants.addIndividualProfile));
      request.fields['Contact.Dob'] = dob;
      request.fields['Contact.ContactNumber'] = mobile;
      request.fields['Contact.Email'] = email;
      request.fields['Contact.FirstName'] = fName;
      request.fields['Contact.LastName'] = lName;
      request.fields['Contact.Gender'] = gender.toString();
      request.fields['UserId'] = userID;
      request.fields['Id'] = id;
      request.fields['Contact.Id'] = contactId;
      request.fields['Contact.BloodGroup'] = bloodGroup;
      request.fields['Contact.Address.Street'] = street;
      request.fields['Contact.Address.Area'] = area;
      request.fields['Contact.Address.Landmark'] = landMark;
      request.fields['Contact.Address.City'] = city;
      request.fields['Height'] = height;
      request.fields['Weight'] = weight;
      request.fields['Contact.Address.PinCode'] = pinCode;
      request.fields['Contact.Address.Id'] = addressId;
      request.fields['Contact.Address.CountryId'] = editCountryId;
      request.fields['Contact.Address.StateId'] = editStateId;
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

    try {
      return await sendRequest();
    } catch (e) {
      if (e == 'Unauthorized') {
        await getRefreshToken();
        return await sendRequest();
      } else {
        rethrow;
      }
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
      String contactId,
      String street,
      String area,
      String pinCode,
      String city,
      String landMark,
      int? stateId,
      String addressId,
      int? countryId,
      String height,
      String weight) async {
    var request = http.MultipartRequest(
        'PUT', Uri.parse(UrlConstants.addEnterpriseProfile));
    request.fields['Contact.Dob'] = dob;
    request.fields['Contact.FirstName'] = fName;
    request.fields['Contact.Email'] = email;
    request.fields['Contact.Gender'] = gender.toString();
    request.fields['Contact.LastName'] = lName;
    request.fields['Contact.ContactNumber'] = mobile;
    request.fields['EnterpriseUserId'] = eUserId;
    request.fields['Contact.BloodGroup'] = bloodGroup;
    request.fields['Id'] = id;
    request.fields['Contact.Id'] = contactId;
    request.fields['Contact.Address.Street'] = street;
    request.fields['Contact.Address.Area'] = area;
    request.fields['Contact.Address.Landmark'] = landMark;
    request.fields['Contact.Address.City'] = city;
    request.fields['Contact.Address.PinCode'] = pinCode;
    request.fields['Contact.Address.StateId'] = stateId.toString();
    request.fields['Contact.Address.CountryId'] = countryId.toString();
    request.fields['Contact.Address.Id'] = addressId;
    request.fields['Height'] = height;
    request.fields['Weight'] = weight;
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
        "${UrlConstants.getIndividualProfiles}/GetAllByUserId/${prefModel.userData!.id}");
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
        "${UrlConstants.getEnterpriseProfiles}/GetAllByUserId/${prefModel.userData!.enterpriseUserId}");
    if (response.statusCode == 200) {
      return AllEnterpriseUsersResponseModel.fromJson(
          json.decode(response.body));
    } else {
      showErrorToast(context, "Something went wrong");
      throw "could not fetch EnterPrise ${response.statusCode}";
    }
  }

  Future<IndividualResponseModel> getIndividualUserData(String? pId) async {
    http.Response response =
        await hitApiGet(true, "${UrlConstants.getIndividualProfiles}/${pId}");
    if (response.statusCode == 200) {
      return IndividualResponseModel.fromJson(json.decode(response.body));
    } else {
      throw "could not fetch Data ${response.statusCode}";
    }
  }

  Future<EnterpriseResponseModel> getEnterpriseUserData(String? eId) async {
    http.Response response =
        await hitApiGet(true, "${UrlConstants.getEnterpriseProfiles}/${eId}");
    if (response.statusCode == 200) {
      return EnterpriseResponseModel.fromJson(json.decode(response.body));
    } else {
      throw "could not fetch Data ${response.statusCode}";
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

  Future<RegisterResponseModel> editProfile(
      String fName,
      String lName,
      String mobile,
      String bloodGroup,
      String gender,
      String dob,
      File? profilePic,
      BuildContext? context,
      int? userId,
      int? contactId,
      String street,
      String area,
      String city,
      String landMark,
      String pinCode,
      int? addressId,
      int? state,
      int? country,
      String height,
      String weight,
      String email) async {
    Future<RegisterResponseModel> sendRequest() async {
      var request =
          http.MultipartRequest('PUT', Uri.parse(UrlConstants.updateProfile));
      request.fields['FirstName'] = fName;
      request.fields['LastName'] = lName;
      request.fields['BloodGroup'] = bloodGroup;
      request.fields['Gender'] = gender == 'Female'
          ? '2'
          : gender == 'Male'
              ? '1'
              : '3';
      request.fields['Dob'] = dob;
      request.fields['UserId'] = userId.toString();
      request.fields['ContactId'] = contactId.toString();
      request.fields['AddressId'] = addressId.toString();
      request.fields['Address.Street'] = street;
      request.fields['Address.Area'] = area;
      request.fields['Address.Landmark'] = landMark;
      request.fields['Address.City'] = city;
      request.fields['Address.PinCode'] = pinCode;
      request.fields['Address.StateId'] = state.toString();
      request.fields['Address.CountryId'] = country.toString();
      request.fields['Height'] = height;
      request.fields['Weight'] = weight;
      request.fields['Email'] = email;
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
        return RegisterResponseModel.fromJson(responseJson);
      } else if (response.statusCode == 401) {
        Navigator.pop(context!);
        showErrorToast(context, "Unauthorized");
        throw 'Unauthorized';
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

    try {
      return await sendRequest();
    } catch (e) {
      if (e == 'Unauthorized') {
        await getRefreshToken();
        return await sendRequest();
      } else {
        rethrow;
      }
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
      String password, String? changePswEmail, BuildContext context) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstants.resetPassword));
    request.fields['Email'] = changePswEmail.toString();
    request.fields['NewPassword'] = password.toString();
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseJson = json.decode(utf8.decode(responseData));
      return ResetPasswordResponseModel.fromJson(responseJson);
    } else {
      Navigator.pop(context);
      showErrorToast(context, "Something went wrong");
      throw "could not add the profile ${response.statusCode}";
    }
  }

  Future<StateMasterResponseModel> getStateMaster(
      BuildContext context, String? uniqueGuid) async {
    http.Response response =
        await hitApiGet(false, "${UrlConstants.getStateMaster}/$uniqueGuid");
    if (response.statusCode == 200) {
      return StateMasterResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      showErrorToast(context, "Something went wrong");
      throw "could not get the states ${response.statusCode}";
    }
  }

  Future<DeviceDataResponseModel> requestDeviceData({
    required BuildContext context,
    required String details,
    required String fileType,
    String? durationName,
    required String deviceSerialNumber,
    required String ipAddress,
    required String userAndDeviceId,
    required String subscriberGuid,
    required String deviceId,
    int? durationId,
    int? userId,
    int? roleId,
    String? pId,
    required File uploadFile, required Map<String, Object?> jsonData,
  }) async {
    Future<DeviceDataResponseModel> sendRequest() async {
      var request = http.MultipartRequest(
          'POST', Uri.parse(UrlConstants.requestDeviceData));
      request.fields['Details'] = details;
      request.fields['FileType'] = fileType;
      request.fields['DurationName'] = durationName!;
      request.fields['DeviceSerialNo'] = deviceSerialNumber;
      request.fields['IPAddress'] = ipAddress;
      request.fields['UserAndDeviceId'] = userAndDeviceId;
      request.fields['SubscriberGuid'] = subscriberGuid;
      request.fields['DeviceId'] = deviceId;
      request.fields['DurationId'] = durationId.toString();
      request.fields['UserId'] = userId.toString();
      request.fields['RoleId'] = roleId.toString();
      if (prefModel.userData!.roleId == 2) {
        request.fields['IndividualProfileId'] = pId.toString();
      } else {
        request.fields['EnterpriseProfileId'] = pId.toString();
      }
      var jsonStream = http.ByteStream(uploadFile.openRead());
      var jsonDataBytes = await uploadFile.readAsBytes();
      var jsonLength = jsonDataBytes.length;
      var jsonMultipartFile = http.MultipartFile(
        'uploadfile',
        jsonStream,
        jsonLength,
        filename: uploadFile.path.split('/').last,
        contentType: MediaType('application', 'json'),
      );
      request.files.add(jsonMultipartFile);
      request.headers.addAll({
        "Authorization": "Bearer ${prefModel.userData!.token}",
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseJson = json.decode(utf8.decode(responseData));
        return DeviceDataResponseModel.fromJson(responseJson);
      } else if (response.statusCode == 400) {
        showErrorToast(context, "Invalid Data");
        final String jsonString = json.encode(jsonData);
        OfflineTestModel testDetails = OfflineTestModel.fromJson(json.decode(jsonString));
        prefModel.offlineSavedTests!.add(testDetails);
        await AppPref.setPref(prefModel);
        showSuccessToast(context, AppLocale.testSavedOffline.getString(context));
        throw "could not fetch Data ${response.statusCode}";
      } else if (response.statusCode == 401) {
        // final String jsonString = json.encode(jsonData);
        // OfflineTestModel testDetails = OfflineTestModel.fromJson(json.decode(jsonString));
        // prefModel.offlineSavedTests!.add(testDetails);
        // await AppPref.setPref(prefModel);
        // showSuccessToast(context, AppLocale.testSavedOffline.getString(context));
        throw 'Unauthorized';
      } else {
        final String jsonString = json.encode(jsonData);
        OfflineTestModel testDetails = OfflineTestModel.fromJson(json.decode(jsonString));
        prefModel.offlineSavedTests!.add(testDetails);
        await AppPref.setPref(prefModel);
        Navigator.pop(context);
        showErrorToast(context, "Something went wrong");
        showSuccessToast(context, AppLocale.testSavedOffline.getString(context));
        throw "could not fetch data ${response.statusCode}";
      }
    }

    try {
      return await sendRequest();
    } catch (e) {
      if (e == 'Unauthorized') {
        await getRefreshToken();
        return await sendRequest();
      } else {
        rethrow;
      }
    }
  }

  Future<AddDeviceResponseModel> addDevice(
      String name,
      String deviceUid,
      String type,
      String serialNo,
      BuildContext context,
      BuildContext oldContext) async {
    if (type == "le") {
      http.Response response = await hitApiPost(
          true,
          UrlConstants.userAndDevice,
          jsonEncode({
            "type": "le",
            "deviceSerialNo": serialNo,
            "deviceKey": deviceUid,
            "roleId": prefModel.userData!.roleId,
            "userId": prefModel.userData!.id
          }));
      if (response.statusCode == 200) {
        return AddDeviceResponseModel.fromJson(json.decode(response.body));
      } else {
        Navigator.pop(context);
        showErrorToast(oldContext, "Something went wrong");
        throw "could not reset password ${response.statusCode}";
      }
    } else {
      throw "Classic device not supported atm";
    }
  }

  Future<DeviceResponseModel> getMyDevices() async {
    http.Response response = await hitApiGet(true,
        "${UrlConstants.userAndDevice}/GetDevicesByUserId/${prefModel.userData!.id}");
    if (response.statusCode == 200) {
      return DeviceResponseModel.fromJson(json.decode(response.body));
    } else {
      throw "could not fetch devices ${response.statusCode}";
    }
  }

  deleteMyDevice(int? userAndDeviceId, BuildContext context) async {
    http.Response response = await http.delete(
      Uri.parse("${UrlConstants.userAndDevice}/$userAndDeviceId"),
      headers: getHeaders(true),
    );
    if (response.statusCode == 200) {
      return DeviceDeleteResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      throw "could not fetch devices ${response.statusCode}";
    }
  }

    Future<MyReportsResponseModel> getMyReports(
        String? reportTime, String? reportStatus, String? pId) async {
      int timeType = 0;
      int reportStatusType = 0;

      if (reportTime == 'This Week') {
        timeType = 1;
      } else if (reportTime == 'This Month') {
        timeType = 2;
      }

      if (reportStatus == 'New') {
        reportStatusType = 1;
      } else if (reportStatus == 'In Progress') {
        reportStatusType = 2;
      } else if (reportStatus == 'Success') {
        reportStatusType = 3;
      } else if (reportStatus == 'Fail') {
        reportStatusType = 4;
      }
      String url = "${UrlConstants.getRequestBySearchFilter}/${prefModel.userData!.id}";

      if (timeType != 0 || reportStatusType != 0 || pId != null) {
        url += "?";
        if (timeType != 0) {
          url += "time=$timeType";
          if (reportStatusType != 0 || pId != null) {
            url += "&";
          }
        }
        if (reportStatusType != 0) {
          url += "statusType=$reportStatusType";
          if (pId != null) {
            url += "&";
          }
        }
        if (pId != 'null') {
          if (prefModel.userData!.roleId == 2) {
            url += "individualProfileId=$pId";
          } else {
            url += "enterpriseProfileId=$pId";
          }
        }
      }
      http.Response response = await hitApiGet(true, url);
      if (response.statusCode == 200) {
        return MyReportsResponseModel.fromJson(json.decode(response.body));
      } else {
        throw "could not fetch devices ${response.statusCode}";
      }
    }

  Future<DashboardCountResponseModel> getDashboardCounts(int pId) async {
    if (prefModel.userData!.roleId == 2) {
      http.Response response = await hitApiGet(true,
          "${UrlConstants.mDashboard}${prefModel.userData!.id}?individualProfileId=$pId");
      if (response.statusCode == 200) {
        return DashboardCountResponseModel.fromJson(json.decode(response.body));
      } else {
        throw "could not fetch devices ${response.statusCode}";
      }
    } else {
      http.Response response = await hitApiGet(true,
          "${UrlConstants.mDashboard}${prefModel.userData!.id}?enterpriseProfileId=$pId");
      if (response.statusCode == 200) {
        return DashboardCountResponseModel.fromJson(json.decode(response.body));
      } else {
        throw "could not fetch devices ${response.statusCode}";
      }
    }
  }

  Future<MyReportsResponseModel> getAllReportsByProfileId(int? pId) async {
    if (prefModel.userData!.roleId == 2) {
      http.Response response = await hitApiGet(true,
          "${UrlConstants.getRequestBySearchFilter}/${prefModel.userData!.id}?individualProfileId=$pId");
      if (response.statusCode == 200) {
        return MyReportsResponseModel.fromJson(json.decode(response.body));
      } else {
        throw "could not fetch devices ${response.statusCode}";
      }
    } else {
      http.Response response = await hitApiGet(true,
          "${UrlConstants.getRequestBySearchFilter}/${prefModel.userData!.id}?enterpriseProfileId=$pId");
      if (response.statusCode == 200) {
        return MyReportsResponseModel.fromJson(json.decode(response.body));
      } else {
        throw "could not fetch devices ${response.statusCode}";
      }
    }
  }

  Future<DetailedReportPdfModel> getReportPdf(
      int? requestDeviceDataId, BuildContext context) async {
    http.Response response = await hitApiGet(true,
        "${UrlConstants.getResponseDocumentsByUserId}${prefModel.userData!.id}?requestId=$requestDeviceDataId");
    if (response.statusCode == 200) {
      return DetailedReportPdfModel.fromJson(json.decode(response.body));
    } else {
      throw "could not fetch devices ${response.statusCode}";
    }
  }

  Future<ReportsDetailModel> getReport(
      int? requestDeviceDataId, BuildContext context) async {
    http.Response response = await hitApiGet(true,
        "${UrlConstants.getAllReportsByUserId}${prefModel.userData!.id}?requestId=$requestDeviceDataId");
    if (response.statusCode == 200) {
      return ReportsDetailModel.fromJson(json.decode(response.body));
    } else {
      throw "could not fetch devices ${response.statusCode}";
    }
  }

  Future<SummaryReportResponseModel> getSummaryReports(
      BuildContext context, String pId, int type) async {
    if (prefModel.userData!.roleId == 2) {
      http.Response response = await hitApiGet(true,
          "${UrlConstants.getSummaryReport}/${prefModel.userData!.id}?individualProfileId=$pId&type=$type");
      if (response.statusCode == 200) {
        return SummaryReportResponseModel.fromJson(json.decode(response.body));
      } else {
        throw "could not fetch data ${response.statusCode}";
      }
    } else {
      http.Response response = await hitApiGet(true,
          "${UrlConstants.getSummaryReport}/${prefModel.userData!.id}?enterpriseProfileId=${pId}&type=1");
      if (response.statusCode == 200) {
        return SummaryReportResponseModel.fromJson(json.decode(response.body));
      } else {
        throw "could not fetch data ${response.statusCode}";
      }
    }
  }

  Future<CountryMasterResponseModel> getCountryMaster(
      BuildContext context) async {
    http.Response response =
        await hitApiGet(false, UrlConstants.getCountryMaster);
    if (response.statusCode == 200) {
      return CountryMasterResponseModel.fromJson(json.decode(response.body));
    } else {
      Navigator.pop(context);
      showErrorToast(context, "Something went wrong");
      throw "could not get the states ${response.statusCode}";
    }
  }

  Future<CheckRequestCountModel> checkRequestCount(
      BuildContext context, int? individualId, int? enterpriseId) async {
    String url = prefModel.userData!.roleId == 2
        ? "${UrlConstants.requestDeviceData}/GetRequestCountByUserId/${prefModel.userData!.id}?individualProfileId=$individualId"
        : "${UrlConstants.requestDeviceData}/GetRequestCountByUserId/${prefModel.userData!.id}?enterpriseProfileId=$enterpriseId";
    http.Response response = await hitApiGet(true, url);
    if (response.statusCode == 200) {
      return CheckRequestCountModel.fromJson(json.decode(response.body));
    } else {
      showErrorToast(context, "Something went wrong");
      throw "could not get the states ${response.statusCode}";
    }
  }

  checkRequestDuration(
      BuildContext context, int? individualId, int? enterpriseId) async {
    String url = prefModel.userData!.roleId == 2
        ? "${UrlConstants.requestDeviceData}/GetRequestDurationByUserId/${prefModel.userData!.id}?individualProfileId=$individualId"
        : "${UrlConstants.requestDeviceData}/GetRequestDurationByUserId/${prefModel.userData!.id}?enterpriseProfileId=$enterpriseId";
    http.Response response = await hitApiGet(true, url);
    if (response.statusCode == 200) {
      return CheckRequestCountModel.fromJson(json.decode(response.body));
    } else {
      showErrorToast(context, "Something went wrong");
      throw "could not get the states ${response.statusCode}";
    }
  }

  Future<RegisterResponseModel> getUserByGuid() async {
    http.Response response = await hitApiGet(
        true, "${UrlConstants.getUserByGuid}${prefModel.userData!.uniqueGuid}");
    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      throw "could not get the userdata ${response.statusCode}";
    }
  }
}
