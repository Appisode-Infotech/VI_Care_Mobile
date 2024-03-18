import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:vicare/create_patients/model/add_individual_profile_response_model.dart';
import 'package:vicare/create_patients/model/individual_response_model.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../../network/api_calls.dart';
import '../../utils/routes.dart';
import '../model/all_enterprise_users_response_model.dart';
import '../model/all_patients_response_model.dart';
import '../model/enterprise_response_model.dart';

class PatientProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();
  IndividualResponseModel? individualPatientData;
  EnterpriseResponseModel? enterpriseUserData;
  BuildContext? relGetPatientContext;
  Future<AllPatientsResponseModel>? individualPatients;
  Future<AllEnterpriseUsersResponseModel>? enterprisePatients;


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
  String? addPatientBloodGroup;
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
    addPatientBloodGroup = null;
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
  String? editPatientBloodGroup;
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
    editPatientBloodGroup = null;
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
      AddIndividualProfileResponseModel response =
          await apiCalls.addIndividualProfile(
              addNewPatientDobController.text,
              addNewPatientMobileController.text,
              addNewPatientEmailController.text,
              addNewPatientFirstNameController.text,
              addNewPatientLastNameController.text,
              addNewPatientAddressController.text,
              addNewPatientGender!,
              addPatientSelectedImage,
              addNewPatientContext!,
              addPatientBloodGroup!);
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
              addNewPatientContext!,
              addPatientBloodGroup!
          );
      if (response.result != null) {
        showSuccessToast(addNewPatientContext!, response.message!);
        Navigator.pop(addNewPatientContext!);
        Navigator.pop(addNewPatientContext!);
      }
    }
  }

  Future<void> prefillEditPatientDetails(BuildContext context) async {
    showLoaderDialog(context);
    editPatientSelectedImage=null;
    if(prefModel.userData!.roleId==2){
      editPatientDobController.text = "${individualPatientData!.result!.contact!.doB!.year}-${individualPatientData!.result!.contact!.doB!.month}-${individualPatientData!.result!.contact!.doB!.day}";
      editPatientMobileController.text = individualPatientData!.result!.contact!.contactNumber!;
      editPatientEmailController.text = individualPatientData!.result!.email!;
      editPatientFirstNameController.text = individualPatientData!.result!.firstName!;
      editPatientLastNameController.text = individualPatientData!.result!.lastName!;
      editPatientAddressController.text = individualPatientData!.result!.contact!.address.toString();
      editPatientAddressController.text = individualPatientData!.result!.contact!.address.toString();
      editPatientGender = individualPatientData!.result!.contact!.gender==1?"Male":individualPatientData!.result!.contact!.gender==2?"Female":"Do not wish to specify";
      editPatientBloodGroup = individualPatientData!.result!.contact!.bloodGroup;
      editPatientSelectedImage = await apiCalls.downloadImageAndReturnFilePath(individualPatientData!.result!.profilePicture!.url!);
      notifyListeners();
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.editPatientsRoute);
    }else{
      editPatientDobController.text = "${enterpriseUserData!.result!.contact!.doB!.year}-${enterpriseUserData!.result!.contact!.doB!.month}-${enterpriseUserData!.result!.contact!.doB!.day}";
      editPatientMobileController.text = enterpriseUserData!.result!.contact!.contactNumber!;
      editPatientEmailController.text = enterpriseUserData!.result!.emailId!;
      editPatientFirstNameController.text = enterpriseUserData!.result!.firstName!;
      editPatientLastNameController.text = enterpriseUserData!.result!.lastName!;
      // editPatientAddressController.text = enterpriseUserData!.result!.contact!.address;
      editPatientGender = enterpriseUserData!.result!.contact!.gender==1?"Male":enterpriseUserData!.result!.contact!.gender==2?"Female":"Do not wish to specify";
      editPatientBloodGroup = enterpriseUserData!.result!.contact!.bloodGroup;
      editPatientSelectedImage =  await apiCalls.downloadImageAndReturnFilePath(enterpriseUserData!.result!.profilePicture!.url!);
      notifyListeners();
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.editPatientsRoute);
    }
  }

  editPatient() async {
    if (prefModel.userData!.roleId == 2) {
      AddIndividualProfileResponseModel response = await apiCalls.editPatient(
          editPatientDobController.text,
          editPatientMobileController.text,
          editPatientEmailController.text,
          editPatientFirstNameController.text,
          editPatientLastNameController.text,
          editPatientAddressController.text,
          editPatientGender!,
          editPatientSelectedImage!,
          editPatientPageContext!,
        editPatientBloodGroup!,
        individualPatientData!.result!.userId.toString(),
        individualPatientData!.result!.contactId.toString(),
        individualPatientData!.result!.id.toString()
      );
    if (response.result != null) {
        showSuccessToast(editPatientPageContext!, response.message!);
        Navigator.pop(editPatientPageContext!);
        Navigator.pop(editPatientPageContext!);
      }
    } else {
      AddIndividualProfileResponseModel response =
          await apiCalls.editEnterprise(
              editPatientEmailController.text,
              editPatientFirstNameController.text,
              editPatientLastNameController.text,
              editPatientDobController.text,
              editPatientAddressController.text,
              editPatientMobileController.text,
              editPatientGender!,
              editPatientSelectedImage!,
              editPatientPageContext!,
              editPatientBloodGroup!,
              enterpriseUserData!.result!.enterpriseUserId.toString(),
            enterpriseUserData!.result!.id.toString(),
            enterpriseUserData!.result!.contactId.toString()
          );
      if (response.result != null) {
        showSuccessToast(editPatientPageContext!, response.message!);
        Navigator.pop(editPatientPageContext!);
        Navigator.pop(editPatientPageContext!);
      }
    }
  }

  getMyPatients() {
    individualPatients = apiCalls.getMyIndividualUsers(relGetPatientContext!);
  }

   getEnterpriseProfiles() {
    enterprisePatients = apiCalls.getMyEnterpriseUsers(relGetPatientContext!);
  }

  getIndividualUserData(String? pId, BuildContext context) async {
    showLoaderDialog(context);
    individualPatientData = await apiCalls.getIndividualUserData(pId, context);
    if (individualPatientData!.result != null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.patientDetailsRoute);
    } else {
      Navigator.pop(context);
      showErrorToast(context, individualPatientData!.message!);
    }
  }

  getEnterpriseUserData(String? eId, BuildContext context) async {
    showLoaderDialog(context);
    enterpriseUserData = await apiCalls.getEnterpriseUserData(eId, context);
    if (enterpriseUserData!.result != null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.patientDetailsRoute);
    } else {
      Navigator.pop(context);
      showErrorToast(context, enterpriseUserData!.message!);
    }
  }
}


