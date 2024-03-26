import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vicare/auth/model/register_response_model.dart';
import 'package:vicare/auth/model/reset_password_response_model.dart';
import 'package:vicare/auth/model/role_master_response_model.dart';
import 'package:vicare/auth/model/send_otp_response_model.dart';
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
  BuildContext? loginPageContext;

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
  String? registerBloodGroup;
  String? otpReceived;
  int? selectedRoleId;
  int? selectedStateId;
  int? selectedGender;
  StateMasterResponseModel? stateMasterResponse;

  File? registerSelectedImage;
  String? registerAs;
  String? registerStateAs;
  String? gender;
  BuildContext? registerPageContext;

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

  Future<void> login() async {
    showLoaderDialog(loginPageContext!);
    RegisterResponseModel response = await apiCalls.loginUser(
        loginEmailController.text,
        loginPasswordController.text,
        loginPageContext!);
    if (response.result != null) {
      prefModel.userData = response.result;
      AppPref.setPref(prefModel);
      Navigator.pop(loginPageContext!);
      Navigator.pushNamedAndRemoveUntil(
          loginPageContext!, Routes.dashboardRoute, (route) => false);
      clearLoginForm();
    } else {
      Navigator.pop(loginPageContext!);
      showErrorToast(loginPageContext!, response.message!);
    }
  }

  Future<void> register() async {
    showLoaderDialog(registerPageContext!);
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
        context: registerPageContext!,
        state: selectedStateId,
      street:registerStreetController.text,
      area:registerAreaController.text,
      landMark:registerLandmarkController.text,
      city:registerCityController.text,
      pinCode:registerPinCodeController.text
    );
    if (response.result != null) {
      prefModel.userData = response.result;
      AppPref.setPref(prefModel);
      Navigator.pop(registerPageContext!);
      Navigator.pushNamed(registerPageContext!, Routes.loginRoute);
      showSuccessToast(registerPageContext!, response.message!);
      clearRegisterForm();
    } else {
      Navigator.pop(registerPageContext!);
      showErrorToast(registerPageContext!, response.message!);
    }
  }

  Future<SendOtpResponseModel> sendOtp() async {
    showLoaderDialog(registerPageContext!);
    SendOtpResponseModel response = await apiCalls.sendOtpToRegister(
        registerEmailController.text, registerPageContext!);
    Navigator.pop(registerPageContext!);
    if (response.result == null) {
      showErrorToast(registerPageContext!, response.message!);
    } else {
      showSuccessToast(registerPageContext!, response.message!);
    }
    return response;
  }

  Future<void> getRoleMasters(BuildContext relContext) async {
    showLoaderDialog(relContext);
    masterRolesResponse = await apiCalls.getMasterRoles(relContext);
    if (masterRolesResponse!.result!.isNotEmpty) {
      Navigator.pop(relContext);
      clearRegisterForm();
      if (relContext.mounted) {
        // Navigator.pushNamed(relContext, Routes.registerRoute);
      }
    } else {
      Navigator.pop(relContext);
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

  Future<ResetPasswordResponseModel> resetPassword() async {
    showLoaderDialog(forgotPageContext!);
    ResetPasswordResponseModel response = await apiCalls.resetPassword(
        forgotPasswordEmailController.text,
        forgotPasswordNewPasswordController.text,
        forgotPageContext!);
    if (response.result != null && response.result == true) {
      Navigator.pop(forgotPageContext!);
      showSuccessToast(forgotPageContext!, response.message!);
      Navigator.pushNamedAndRemoveUntil(
          forgotPageContext!, Routes.loginRoute, (route) => false);
    } else {
      showErrorToast(forgotPageContext!, response.message!);
    }
    return response;
  }

  Future<void> getStateMaster(BuildContext context) async {
    stateMasterResponse = await apiCalls.getStateMaster(context);
    if (stateMasterResponse!.result!.isNotEmpty) {
      clearRegisterForm();
      if (context.mounted) {
        // Navigator.pushNamed(context, Routes.registerRoute);
      }
    } else {
      Navigator.pop(context);
      showErrorToast(context, stateMasterResponse!.message.toString());
    }
  }
}
