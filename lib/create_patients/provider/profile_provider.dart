import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vicare/auth/model/register_response_model.dart';
import 'package:vicare/create_patients/model/edit_profile_response_model.dart';
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

  //edit profile declarations
  bool isNotValidContactNumber(String contactNumber) {
    if (contactNumber.length == 10) {
      return false;
    } else {
      return true;
    }
  }

  final editProfileFormKey = GlobalKey<FormState>();
  TextEditingController editProfileDobController = TextEditingController();
  TextEditingController editProfileContactNumberController =
      TextEditingController();
  TextEditingController editProfileFirstNameController =
      TextEditingController();
  TextEditingController editProfileLastNameController = TextEditingController();
  TextEditingController editProfileStreetController = TextEditingController();
  TextEditingController editProfileAreaController = TextEditingController();
  TextEditingController editProfileCityController = TextEditingController();
  TextEditingController editProfileLandMarkController = TextEditingController();
  TextEditingController editProfilePinCodeController = TextEditingController();
  String? editProfileBloodGroup;
  String? editProfileGender;
  int? selectedGender;
  File? editProfileSelectedImage;
  BuildContext? editProfilePageContext;
  int? editProfileSelectedStateId;
  String? editProfileStateAs;
  StateMasterResponseModel? stateMasterResponse;

  clearEditProfileForm() {
    editProfileDobController.clear();
    editProfileContactNumberController.clear();
    editProfileFirstNameController.clear();
    editProfileLastNameController.clear();
    editProfileBloodGroup = null;
    editProfileGender = null;
    editProfileStreetController.clear();
    editProfileAreaController.clear();
    editProfileCityController.clear();
    editProfileLandMarkController.clear();
    editProfilePinCodeController.clear();
    editProfileStateAs = null;
    editProfileSelectedImage = null;
    notifyListeners();
  }

  Future<void> preFillEditProfile(BuildContext context) async {
    showLoaderDialog(context);
      editProfileDobController.text = "${prefModel.userData!.contact!.doB!.year}-${prefModel.userData!.contact!.doB!.month}-${prefModel.userData!.contact!.doB!.day}";
      editProfileContactNumberController.text = prefModel.userData!.contactNumber!;
      editProfileFirstNameController.text = prefModel.userData!.contact!.firstname!;
      editProfileLastNameController.text = prefModel.userData!.contact!.lastName!;
      print(prefModel.userData!.contact!.toJson());
      editProfileStreetController.text=prefModel.userData!.contact!.address!.street!;
      editProfileAreaController.text=prefModel.userData!.contact!.address!.area!;
      editProfileLandMarkController.text=prefModel.userData!.contact!.address!.landmark!;
      editProfileCityController.text=prefModel.userData!.contact!.address!.city!;
      editProfilePinCodeController.text=prefModel.userData!.contact!.address!.pinCode!;
      editProfileBloodGroup = prefModel.userData!.contact!.bloodGroup;
    for (var state in stateMasterResponse!.result!) {
      if (state.id == prefModel.userData!.contact!.address!.stateId) {
        editProfileStateAs = state.name;
        break;
      }
    }
      editProfileGender = prefModel.userData!.contact!.gender == 1
          ? "Male"
          : prefModel.userData!.contact!.gender == 2
              ? "Female"
              : "Do not wish to specify";
      if(prefModel.userData!.profilePicture!=null){
        editProfileSelectedImage = await apiCalls.downloadImageAndReturnFilePath(
            prefModel.userData!.profilePicture!.url.toString());
      }
      notifyListeners();
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.editProfileRoute);
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
      RegisterResponseModel response = await apiCalls.editIndividualProfile(
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
          editProfileSelectedStateId
      );
      if (response.result != null) {
        prefModel.userData = response.result;
        AppPref.setPref(prefModel);
        showSuccessToast(editProfilePageContext!, response.message!);
        Navigator.pop(editProfilePageContext!);
      }
  }

  Future<SendOtpResponseModel> changePassword(BuildContext context) async {
    SendOtpResponseModel response = await apiCalls.sendOtpToChangePassword(
        prefModel.userData!.email.toString(),
        context,
        changePasswordIsShowPassword);
    return response;
  }

  Future<void> resetNewPassword(BuildContext context) async {
    ResetPasswordResponseModel response = await apiCalls.resetNewPassword(
        changePasswordIsShowPassword, prefModel.userData!.email, context);
    if (response.result != null && response.result == true) {
      Navigator.pop(changePasswordPageContext!);
      showSuccessToast(changePasswordPageContext!, response.message!);
      // Navigator.pushNamedAndRemoveUntil(
      //     changePasswordPageContext!, Routes.loginRoute, (route) => false);
    } else {
      showErrorToast(changePasswordPageContext!, response.message!);
    }
  }

  Future<void> getStateMaster(BuildContext context) async {
    stateMasterResponse = await apiCalls.getStateMaster(context);
    if (stateMasterResponse!.result!.isNotEmpty) {

    } else {
      Navigator.pop(context);
      showErrorToast(context, stateMasterResponse!.message.toString());
    }
  }
}
