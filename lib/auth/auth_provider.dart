import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vicare/auth/model/register_response_model.dart';
import 'package:vicare/auth/model/reset_password_response_model.dart';
import 'package:vicare/auth/model/role_master_response_model.dart';
import 'package:vicare/auth/model/send_otp_response_model.dart';
import 'package:vicare/create_patients/model/country_master_response_model.dart';
import 'package:vicare/database/app_pref.dart';
import 'package:vicare/network/api_calls.dart';

import '../create_patients/model/state_master_response_model.dart';
import '../main.dart';
import '../utils/app_buttons.dart';
import '../utils/routes.dart';

class AuthProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  bool isNotValidEmail(String email) {
    const emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(emailRegex);
    return !regExp.hasMatch(email);
  }

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

  // Login page declarations
  BuildContext? onBoardingScreenContext;
  RoleMasterResponseModel? masterRolesResponse;

  // Login page declarations
  final loginFormKey = GlobalKey<FormState>();
  bool loginIsShowPassword = true;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  // Register page declarations
  final registerFormKey = GlobalKey<FormState>();
  bool registerIsShowPassword = true;
  TextEditingController registerFirstName = TextEditingController();
  TextEditingController registerLastName = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerDobController = TextEditingController();
  TextEditingController registerOtpController = TextEditingController();
  TextEditingController registerStreetController = TextEditingController();
  TextEditingController registerAreaController = TextEditingController();
  TextEditingController registerLandmarkController = TextEditingController();
  TextEditingController registerCityController = TextEditingController();
  TextEditingController registerPinCodeController = TextEditingController();
  TextEditingController registerContactNumberController = TextEditingController();
  TextEditingController registerWeightController = TextEditingController();
  TextEditingController registerHeightController = TextEditingController();
  String? registerBloodGroup;
  String? otpReceived;
  int? selectedRoleId;
  int? selectedStateId;
  int? selectedCountryId;
  int? selectedGender;
  StateMasterResponseModel? stateMasterResponse;
  CountryMasterResponseModel? countryMasterResponse;

  File? registerSelectedImage;
  String? registerAs;
  String? registerStateAs;
  String? registerCountryAs;
  String? gender;

  // Forgot password page declarations
  final forgotPasswordFormKey = GlobalKey<FormState>();
  bool forgotPasswordIsShowPassword = true;
  bool forgotPasswordIsConfirmPassword = true;
  BuildContext? forgotPageContext;
  TextEditingController forgotPasswordConfirmPasswordController =
      TextEditingController();
  TextEditingController forgotPasswordNewPasswordController =
      TextEditingController();
  TextEditingController forgotPasswordOtpController = TextEditingController();
  TextEditingController forgotPasswordEmailController = TextEditingController();
  String? forgotPassOtp;

  clearLoginForm() {
    loginEmailController.clear();
    loginPasswordController.clear();
    notifyListeners();
  }

  clearRegisterForm() {
    registerFirstName.clear();
    registerLastName.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerDobController.clear();
    registerContactNumberController.clear();
    registerSelectedImage = null;
    registerAs = null;
    registerStateAs = null;
    gender = null;
    registerBloodGroup = null;
    otpReceived = null;
    selectedRoleId = null;
    selectedStateId=null;
    selectedGender = null;
    notifyListeners();
  }

  clearForgotPasswordForm() {
    forgotPasswordConfirmPasswordController.clear();
    forgotPasswordNewPasswordController.clear();
    forgotPasswordOtpController.clear();
    forgotPasswordEmailController.clear();
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    showLoaderDialog(context);
    RegisterResponseModel response = await apiCalls.loginUser(
        loginEmailController.text,
        loginPasswordController.text,
        context);
    if (response.result != null) {
      prefModel.userData = response.result;
      AppPref.setPref(prefModel);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.dashboardRoute, (route) => false);
      clearLoginForm();
    } else {
      Navigator.pop(context);
      showErrorToast(context, response.message!);
    }
  }

   register(BuildContext context) async {
    showLoaderDialog(context);
    RegisterResponseModel response = await apiCalls.registerNewUser(
        profilePic: registerSelectedImage,
        dob: registerDobController.text,
        fName: registerFirstName.text,
        lName: registerLastName.text,
        email: registerEmailController.text,
        gender: selectedGender,
        roleId: selectedRoleId,
        bloodGroup: registerBloodGroup,
        contact: registerContactNumberController.text,
        password: registerPasswordController.text,
        context: context,
        state: selectedStateId,
        street: registerStreetController.text,
        area: registerAreaController.text,
        landMark: registerLandmarkController.text,
        city: registerCityController.text,
        pinCode: registerPinCodeController.text,
        country: selectedCountryId,
        height: registerHeightController.text,
        weight: registerWeightController.text
    );
    if (response.result != null) {
      prefModel.userData = response.result;
      AppPref.setPref(prefModel);
      Navigator.pop(context);
      showSuccessToast(context, response.message!);
      clearRegisterForm();
      Navigator.pop(context);
    } else {
      showErrorToast(context, response.message!);
      Navigator.pop(context);
    }
  }

  Future<SendOtpResponseModel> sendOtp(BuildContext context) async {
    showLoaderDialog(context);
    SendOtpResponseModel response = await apiCalls.sendOtpToRegister(
        registerEmailController.text, context);
    Navigator.pop(context);
    if (response.result == null) {
      showErrorToast(context, response.message!);
    } else {
      showSuccessToast(context, response.message!);
    }
    return response;
  }

  Future<void> getRoleMasters(BuildContext relContext) async {
    masterRolesResponse = await apiCalls.getMasterRoles(relContext);
    if (masterRolesResponse!.result!.isEmpty) {
      clearRegisterForm();
      showErrorToast(relContext, masterRolesResponse!.message!);
    }
  }

  Future<SendOtpResponseModel> sendOtpForResetPassword() async {
    showLoaderDialog(forgotPageContext!);
    SendOtpResponseModel response = await apiCalls.sendOtpToResetPassword(
        forgotPasswordEmailController.text, forgotPageContext!);
    Navigator.pop(forgotPageContext!);
    return response;
  }

  Future<ResetPasswordResponseModel> resetPassword(BuildContext? coContext) async {
    showLoaderDialog(coContext!);
    ResetPasswordResponseModel response = await apiCalls.resetPassword(
        forgotPasswordEmailController.text,
        forgotPasswordNewPasswordController.text,
        coContext);
    if (response.result != null && response.result == true) {
      Navigator.pop(coContext);
      showSuccessToast(coContext, response.message!);
      Navigator.pushNamed(coContext, Routes.loginRoute);
    } else {
      showErrorToast(forgotPageContext!, response.message!);
    }
    return response;
  }

  Future<void> getStateMaster(BuildContext context, String? uniqueGuid) async {
    stateMasterResponse = await apiCalls.getStateMaster(context,uniqueGuid);
    if (stateMasterResponse!.result!.isEmpty) {
      showErrorToast(context, stateMasterResponse!.message.toString());
    }
  }

  Future<void> getCountryMaster(BuildContext context) async {
    countryMasterResponse = await apiCalls.getCountryMaster(context);
    if (countryMasterResponse!.result!.isEmpty) {
      showErrorToast(context, countryMasterResponse!.message.toString());
    }
  }

}
