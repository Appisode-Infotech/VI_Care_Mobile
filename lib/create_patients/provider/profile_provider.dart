import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vicare/auth/model/register_response_model.dart';
import 'package:vicare/create_patients/model/country_master_response_model.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../../auth/model/reset_password_response_model.dart';
import '../../auth/model/send_otp_response_model.dart';
import '../../database/app_pref.dart';
import '../../main.dart';
import '../../network/api_calls.dart';
import '../../utils/routes.dart';
import '../model/state_master_response_model.dart';

class ProfileProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  TextEditingController changePasswordOneController = TextEditingController();
  TextEditingController changePasswordTwoController = TextEditingController();

  bool isNotValidContactNumber(String contactNumber) {
    if (contactNumber.length == 10) {
      return false;
    } else {
      return true;
    }
  }

  bool isStrongPassword(String password) {
    if (password.length < 8) {
      return false;
    }
    bool hasCapitalLetter = password.contains(RegExp(r'[A-Z]'));
    bool hasSpecialCharacter =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    return hasCapitalLetter && hasSpecialCharacter && hasNumber;
  }

  clearChangePassword() {
    changePasswordOneController.clear();
    changePasswordTwoController.clear();
    notifyListeners();
  }

  Future<void> preFillEditProfile(BuildContext context) async {
    editProfileSelectedImage = null;
    showLoaderDialog(context);

    final DateTime dob = DateTime(
      prefModel.userData!.contact!.doB!.year,
      prefModel.userData!.contact!.doB!.month,
      prefModel.userData!.contact!.doB!.day,
    );
    final String formattedDob = DateFormat('dd-MM-yyyy').format(dob);

    editProfileDobController.text = formattedDob;
    // editProfileDobController.text = "${prefModel.userData!.contact!.doB!.year}-${prefModel.userData!.contact!.doB!.month}-${prefModel.userData!.contact!.doB!.day}";
    editProfileContactNumberController.text =
        prefModel.userData!.contactNumber.toString();
    editProfileFirstNameController.text =
        prefModel.userData!.contact!.firstName!;
    editProfileLastNameController.text = prefModel.userData!.contact!.lastName!;
    editProfileEmailController.text = prefModel.userData!.email!;
    editProfileStreetController.text =
        prefModel.userData!.contact!.address!.street != null
            ? prefModel.userData!.contact!.address!.street!
            : "";
    editProfileAreaController.text =
        prefModel.userData!.contact!.address!.area != null
            ? prefModel.userData!.contact!.address!.area!
            : "";
    editProfileLandMarkController.text =
        prefModel.userData!.contact!.address!.landmark != null
            ? prefModel.userData!.contact!.address!.landmark!
            : "";
    editProfileCityController.text =
        prefModel.userData!.contact!.address!.city!;
    editProfilePinCodeController.text =
        prefModel.userData!.contact!.address!.pinCode != null
            ? prefModel.userData!.contact!.address!.pinCode!
            : "";
    editProfileBloodGroup = prefModel.userData!.contact!.bloodGroup;
    profileHeightController.text = prefModel.userData!.height == null
        ? ''
        : prefModel.userData!.height.toString();
    profileWeightController.text = prefModel.userData!.weight == null
        ? ''
        : prefModel.userData!.weight.toString();

    if (prefModel.userData!.profilePicture != null) {
      final imageUrl = prefModel.userData!.profilePicture!.url;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        final imagePath =
            await apiCalls.downloadImageAndReturnFilePath(imageUrl);
        if (imagePath != null) {
          editProfileSelectedImage = imagePath;
        } else {
          print('Error: Image file not found at path: $imagePath');
        }
      }
    }

    await getCountryMaster(context);
    if (countryMasterResponse != null &&
        countryMasterResponse!.result!.isNotEmpty) {
      for (var country in countryMasterResponse!.result!) {
        if (country.id == prefModel.userData!.contact!.address!.countryId) {
          editProfileCountryAs = country.name;
          editProfileSelectedCountryId = country.id;
          await getStateMaster(context, country.uniqueGuid);
          break;
        }
      }
    }
    if (editStateMasterResponse != null &&
        editStateMasterResponse!.result!.isNotEmpty) {
      for (var state in editStateMasterResponse!.result!) {
        if (state.id == prefModel.userData!.contact!.address!.stateId) {
          editProfileStateAs = state.name;
          break;
        }
      }
    } else {
      "";
    }
    editProfileGender = prefModel.userData!.contact!.gender == 1
        ? "Male"
        : prefModel.userData!.contact!.gender == 2
            ? "Female"
            : "Do not wish to specify";

    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.editProfileRoute).then((value) {
      notifyListeners();
      return null;
    });
  }

  final editProfileFormKey = GlobalKey<FormState>();
  TextEditingController editProfileDobController = TextEditingController();
  TextEditingController editProfileContactNumberController =
      TextEditingController();
  TextEditingController editProfileEmailController = TextEditingController();
  TextEditingController editProfileFirstNameController =
      TextEditingController();
  TextEditingController editProfileLastNameController = TextEditingController();
  TextEditingController editProfileStreetController = TextEditingController();
  TextEditingController editProfileAreaController = TextEditingController();
  TextEditingController editProfileCityController = TextEditingController();
  TextEditingController editProfileLandMarkController = TextEditingController();
  TextEditingController editProfilePinCodeController = TextEditingController();
  TextEditingController profileHeightController = TextEditingController();
  TextEditingController profileWeightController = TextEditingController();
  String? editProfileBloodGroup;
  String? editProfileGender;
  int? selectedGender;
  File? editProfileSelectedImage;
  BuildContext? editProfilePageContext;
  int? editProfileSelectedStateId;
  int? editProfileSelectedCountryId;
  String? editProfileStateAs;
  String? editProfileCountryAs;
  StateMasterResponseModel? editStateMasterResponse;
  CountryMasterResponseModel? countryMasterResponse;

  clearEditProfileForm() {
    editProfileDobController.clear();
    editProfileContactNumberController.clear();
    editProfileFirstNameController.clear();
    editProfileLastNameController.clear();
    editProfileEmailController.clear();
    editProfileBloodGroup = null;
    editProfileGender = null;
    editProfileStreetController.clear();
    editProfileAreaController.clear();
    editProfileCityController.clear();
    editProfileLandMarkController.clear();
    profileHeightController.clear();
    profileWeightController.clear();
    editProfilePinCodeController.clear();
    editProfileStateAs = null;
    editProfileCountryAs = null;
    editProfileSelectedImage = null;
    notifyListeners();
  }

  //change password declaration
  final changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController changePasswordOtpController = TextEditingController();
  String? otpReceived;
  bool changePasswordIsShowPassword = true;
  bool changePasswordIsConfirmPassword = true;
  String? resetPasswordOtp;
  BuildContext? changePasswordPageContext;

  Future<void> editProfile() async {
    showLoaderDialog(editProfilePageContext!);
    RegisterResponseModel response = await apiCalls.editProfile(
        editProfileFirstNameController.text,
        editProfileLastNameController.text,
        editProfileContactNumberController.text,
        editProfileBloodGroup!,
        editProfileGender!,
        editProfileDobController.text,
        editProfileSelectedImage!,
        editProfilePageContext!,
        prefModel.userData!.id,
        prefModel.userData!.contactId,
        editProfileStreetController.text,
        editProfileAreaController.text,
        editProfileCityController.text,
        editProfileLandMarkController.text,
        editProfilePinCodeController.text,
        prefModel.userData!.contact!.addressId,
        editProfileSelectedStateId ??
            prefModel.userData!.contact!.address!.stateId,
        editProfileSelectedCountryId ??
            prefModel.userData!.contact!.address!.countryId,
        profileHeightController.text,
        profileWeightController.text,
        editProfileEmailController.text);
    if (response.result != null) {
      prefModel.userData!.contact!.firstName =
          response.result!.contact!.firstName;
      prefModel.userData!.contact!.lastName =
          response.result!.contact!.lastName;
      prefModel.userData!.contactNumber = response.result!.contactNumber;
      prefModel.userData!.contact!.bloodGroup =
          response.result!.contact!.bloodGroup;
      prefModel.userData!.contact!.gender = response.result!.contact!.gender;
      prefModel.userData!.contact!.doB = response.result!.contact!.doB;
      prefModel.userData!.profilePicture!.url =
          response.result!.profilePicture!.url;
      prefModel.userData!.id = response.result!.id;
      prefModel.userData!.contactId = response.result!.contactId;
      prefModel.userData!.contact!.address!.street =
          response.result!.contact!.address!.street;
      prefModel.userData!.contact!.address!.area =
          response.result!.contact!.address!.area;
      prefModel.userData!.contact!.address!.city =
          response.result!.contact!.address!.city;
      prefModel.userData!.contact!.address!.landmark =
          response.result!.contact!.address!.landmark;
      prefModel.userData!.contact!.address!.pinCode =
          response.result!.contact!.address!.pinCode;
      prefModel.userData!.contact!.addressId =
          response.result!.contact!.addressId;
      prefModel.userData!.contact!.address!.stateId =
          response.result!.contact!.address!.stateId;
      prefModel.userData!.contact!.address!.countryId =
          response.result!.contact!.address!.countryId;
      prefModel.userData!.height = response.result!.height;
      prefModel.userData!.weight = response.result!.weight;
      prefModel.userData!.email = response.result!.email;
      AppPref.setPref(prefModel);
      Navigator.pop(editProfilePageContext!);
      showSuccessToast(editProfilePageContext!, response.message!);
    } else {
      showErrorToast(editProfilePageContext!, response.message!);
    }
    Navigator.pop(editProfilePageContext!);
  }

  Future<SendOtpResponseModel> changePassword(BuildContext context) async {
    SendOtpResponseModel response = await apiCalls.sendOtpToChangePassword(
        prefModel.userData!.email.toString(),
        context,
        changePasswordIsShowPassword);
    return response;
  }

  Future<void> resetNewPassword(BuildContext context) async {
    showLoaderDialog(context);
    ResetPasswordResponseModel response = await apiCalls.resetNewPassword(
        changePasswordTwoController.text, prefModel.userData!.email, context);
    if (response.result != null && response.result == true) {
      Navigator.pop(context);
      clearChangePassword();
      Navigator.pop(context);
      showSuccessToast(context, response.message!);
    } else {
      showErrorToast(context!, response.message!);
    }
  }

  Future<void> getStateMaster(BuildContext context, String? uniqueGuid) async {
    editStateMasterResponse =
        await apiCalls.getStateMaster(context, uniqueGuid);
    if (editStateMasterResponse!.result!.isNotEmpty) {
    } else {
      Navigator.pop(context);
      showErrorToast(context, editStateMasterResponse!.message.toString());
    }
  }

  Future<void> getCountryMaster(BuildContext context) async {
    countryMasterResponse = await apiCalls.getCountryMaster(context);
    if (countryMasterResponse!.result!.isEmpty) {
      showErrorToast(context, countryMasterResponse!.message.toString());
    }
  }
}
