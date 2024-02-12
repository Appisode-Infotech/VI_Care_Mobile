import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../utils/routes.dart';

class AuthProvider extends ChangeNotifier {
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
  File? registerSelectedImage;
  String? registerAs;
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
    registerSelectedImage = null;
    registerAs = null;
    gender = null;
    notifyListeners();
  }

  clearForgotPasswordForm() {
     forgotPasswordConfirmPasswordController.clear();
    forgotPasswordNewPasswordController.clear();
    forgotPasswordOtpController.clear();
    forgotPasswordEmailController .clear();
    notifyListeners();
  }

  void login() {
    Navigator.pushNamed(loginPageContext!, Routes.dashboardRoute);
  }

  void register() {
    Navigator.pushNamed(registerPageContext!, Routes.dashboardRoute);
  }

}
