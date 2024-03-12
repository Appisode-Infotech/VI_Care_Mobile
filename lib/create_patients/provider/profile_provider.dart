import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../../network/api_calls.dart';
import '../../utils/routes.dart';

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

  Future<void> preFillEditProfile(BuildContext context)async {
    showLoaderDialog(context);
    editProfileSelectedImage=null;
    if(prefModel.userData!.roleId==2){
    editProfileDobController.text= "${prefModel.userData!.contact!.doB!.year}-${prefModel.userData!.contact!.doB!.month}-${prefModel.userData!.contact!.doB!.day}";
    editProfileContactNumberController.text=prefModel.userData!.contactNumber!;
    editProfileFirstNameController.text=prefModel.userData!.contact!.firstname!;
    editProfileLastNameController.text=prefModel.userData!.contact!.lastName!;
    editProfileBloodGroup = prefModel.userData!.contact!.bloodGroup;
    editProfileGender = prefModel.userData!.contact!.gender==1?"Male":prefModel.userData!.contact!.gender==2?"Female":"Do not wish to specify";
    editProfileSelectedImage = await apiCalls.downloadImageAndReturnFilePath(prefModel.userData!.profilePicture!.url.toString());
    notifyListeners();
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.editProfileRoute);
    }else{
      editProfileDobController.text= "${prefModel.userData!.contact!.doB!.year}-${prefModel.userData!.contact!.doB!.month}-${prefModel.userData!.contact!.doB!.day}";
      editProfileContactNumberController.text=prefModel.userData!.contactNumber!;
      editProfileFirstNameController.text=prefModel.userData!.contact!.firstname!;
      editProfileLastNameController.text=prefModel.userData!.contact!.lastName!;
      editProfileBloodGroup = prefModel.userData!.contact!.bloodGroup;
      editProfileGender = prefModel.userData!.contact!.gender==1?"Male":prefModel.userData!.contact!.gender==2?"Female":"Do not wish to specify";
      editProfileSelectedImage = await apiCalls.downloadImageAndReturnFilePath(prefModel.userData!.profilePicture!.url.toString());
      notifyListeners();
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.editProfileRoute);
    }
  }

  final editProfileFormKey = GlobalKey<FormState>();
  TextEditingController editProfileDobController = TextEditingController();
  TextEditingController editProfileContactNumberController = TextEditingController();
  TextEditingController editProfileFirstNameController = TextEditingController();
  TextEditingController editProfileLastNameController = TextEditingController();
  String? editProfileBloodGroup;
  String? editProfileGender;
  int? selectedGender;
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


  void editProfile() {
    apiCalls.editIndividualProfile(
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

    );
  }

}
