import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vicare/create_patients/model/add_individual_profile_response_model.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../../network/api_calls.dart';
import '../model/all_enterprise_users_response_model.dart';
import '../model/all_patients_response_model.dart';

class PatientProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  //add New Patient Page declarations
  final addPatientFormKey = GlobalKey<FormState>();
  TextEditingController addNewPatientDobController = TextEditingController();
  TextEditingController addNewPatientMobileController = TextEditingController();
  TextEditingController addNewPatientEmailController = TextEditingController();
  TextEditingController addNewPatientFirstNameController =
  TextEditingController();
  TextEditingController addNewPatientLastNameController =
  TextEditingController();
  TextEditingController addNewPatientAddressController =
  TextEditingController();
  String? addNewPatientGender;
  File? addPatientSelectedImage;
  BuildContext? addNewPatientContext;

  clearAddPatientForm() {
    addNewPatientDobController.clear();
    addNewPatientMobileController.clear();
    addNewPatientEmailController.clear();
    addNewPatientFirstNameController.clear();
    addNewPatientLastNameController.clear();
    addNewPatientAddressController.clear();
    addNewPatientGender = null;
    addPatientSelectedImage = null;
    notifyListeners();
  }

  //edit patient page declarations

  final editPatientFormKey = GlobalKey<FormState>();
  TextEditingController editPatientDobController = TextEditingController();
  TextEditingController editPatientMobileController = TextEditingController();
  TextEditingController editPatientEmailController = TextEditingController();
  TextEditingController editPatientFirstNameController =
  TextEditingController();
  TextEditingController editPatientLastNameController = TextEditingController();
  TextEditingController editPatientAddressController = TextEditingController();
  String? editPatientGender;
  int? selectedGender;
  File? editPatientSelectedImage;
  BuildContext? editPatientPageContext;

  clearEditPatientForm() {
    editPatientDobController.clear();
    editPatientMobileController.clear();
    editPatientEmailController.clear();
    editPatientFirstNameController.clear();
    editPatientLastNameController.clear();
    editPatientAddressController.clear();
    editPatientGender = null;
    editPatientSelectedImage = null;
    notifyListeners();
  }

  int calculateAge(String dateOfBirthString) {
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString);
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(dateOfBirth);
    int ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }

  addNewPatient() async {
    showLoaderDialog(addNewPatientContext!);
    if (prefModel.userData!.roleId == 2) {
      AddIndividualProfileResponseModel response = await apiCalls.addIndividualProfile(
          addNewPatientDobController.text,
          addNewPatientMobileController.text,
          addNewPatientEmailController.text,
          addNewPatientFirstNameController.text,
          addNewPatientLastNameController.text,
          addNewPatientAddressController.text,
          addNewPatientGender!,
          addPatientSelectedImage,
          addNewPatientContext!);
      if (response.result != null) {
        showSuccessToast(addNewPatientContext!, response.message!);
        Navigator.pop(addNewPatientContext!);
        Navigator.pop(addNewPatientContext!);
      }
    } else {
      AddIndividualProfileResponseModel response =
      await apiCalls.addEnterpriseProfile(
          addNewPatientDobController.text,
          addNewPatientMobileController.text,
          addNewPatientEmailController.text,
          addNewPatientFirstNameController.text,
          addNewPatientLastNameController.text,
          addNewPatientAddressController.text,
          addNewPatientGender!,
          addPatientSelectedImage,
          addNewPatientContext!);
      if (response.result != null) {
        showSuccessToast(addNewPatientContext!, response.message!);
        Navigator.pop(addNewPatientContext!);
        Navigator.pop(addNewPatientContext!);
      }
    }
  }

  editPatient() async {
    showLoaderDialog(editPatientPageContext!);
    if (prefModel.userData!.roleId == 2) {
      AddIndividualProfileResponseModel response = await apiCalls.editPatient(
          editPatientEmailController.text,
          editPatientFirstNameController.text,
          editPatientLastNameController.text,
          editPatientDobController.text,
          editPatientAddressController.text,
          editPatientMobileController.text,
          editPatientGender!,
          editPatientSelectedImage!,
          editPatientPageContext!);
      if (response.result != null) {
        showSuccessToast(editPatientPageContext!, response.message!);
        Navigator.pop(editPatientPageContext!);
        Navigator.pop(editPatientPageContext!);
      }
    }else {
        AddIndividualProfileResponseModel response = await apiCalls
            .editEnterprise(
            editPatientEmailController.text,
            editPatientFirstNameController.text,
            editPatientLastNameController.text,
            editPatientDobController.text,
            editPatientAddressController.text,
            editPatientMobileController.text,
            editPatientGender!,
            editPatientSelectedImage!,
            editPatientPageContext!);
        if (response.result != null) {
          showSuccessToast(editPatientPageContext!, response.message!);
          Navigator.pop(editPatientPageContext!);
          Navigator.pop(editPatientPageContext!);
        }
      }
  }


  Future<AllPatientsResponseModel> getMyPatients(BuildContext context){
    return apiCalls.getMyIndividualUsers(context);
  }
  Future<AllEnterpriseUsersResponseModel> getEnterpriseProfiles(BuildContext context){
    return apiCalls.getMyEnterpriseUsers(context);
  }

  getIndividualUserData(String? uniqueGuid, BuildContext context) {
    return apiCalls.getIndividualUserData(uniqueGuid,context);
  }

  getEnterpriseUserData(String? uniqueGuid, BuildContext context) {
    return apiCalls.getEnterpriseUserData(uniqueGuid,context);

  }

}

// void prefillEditPatientDetails() {
//   editPatientDobController.text = addNewPatientDobController.text;
//   editPatientMobileController.text = addNewPatientMobileController.text;
//   editPatientEmailController.text = addNewPatientEmailController.text;
//   editPatientFirstNameController.text = addNewPatientFirstNameController.text;
//   editPatientLastNameController.text = addNewPatientLastNameController.text;
//   editPatientAddressController.text = addNewPatientAddressController.text;
//   editPatientGender = addNewPatientGender;
//   editPatientSelectedImage = addPatientSelectedImage;
//   notifyListeners();
// }

