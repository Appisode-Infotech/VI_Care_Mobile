import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../network/api_calls.dart';

class PatientProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  //add New Patient Page declarations
  final addPatientFormKey = GlobalKey<FormState>();
  TextEditingController addNewPatientDobController = TextEditingController();
  TextEditingController addNewPatientMobileController = TextEditingController();
  TextEditingController addNewPatientEmailController = TextEditingController();
  TextEditingController addNewPatientFirstNameController = TextEditingController();
  TextEditingController addNewPatientLastNameController = TextEditingController();
  TextEditingController addNewPatientAddressController = TextEditingController();
  String? addNewPatientGender;
  File? addPatientSelectedImage;
  BuildContext? addNewPageContext;

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
  TextEditingController editPatientFirstNameController = TextEditingController();
  TextEditingController editPatientLastNameController = TextEditingController();
  TextEditingController editPatientAddressController = TextEditingController();
  String? editPatientGender;
  File? editPatientSelectedImage;
  BuildContext? editPatientPageContext;

  clearEditPatientForm() {
    editPatientDobController.clear();
    editPatientMobileController.clear();
    editPatientEmailController.clear();
    editPatientFirstNameController.clear();
    editPatientLastNameController.clear();
    editPatientAddressController.clear();
    editPatientGender=null;
    editPatientSelectedImage=null;
    notifyListeners();
  }
  //
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


}
