import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../network/api_calls.dart';

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
  TextEditingController editProfileContactNumberController = TextEditingController();
  TextEditingController editProfileFirstNameController = TextEditingController();
  TextEditingController editProfileLastNameController = TextEditingController();
  String? editProfileBloodGroup;
  String? editProfileGender;
  File? editProfileSelectedImage;
  BuildContext? editProfilePageContext;

  clearEditProfileForm() {
    editProfileDobController.clear();
    editProfileContactNumberController.clear();
    editProfileFirstNameController.clear();
    editProfileLastNameController.clear();
    editProfileBloodGroup = null;
    editProfileGender = null;
    editProfileSelectedImage = null;
    notifyListeners();
  }

  //change password declaration
  final changePasswordFormKey = GlobalKey<FormState>();
  bool changePasswordIsShowPassword = true;
  bool changePasswordIsConfirmPassword = true;
  BuildContext? changePasswordPageContext;

}
