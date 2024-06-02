import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';

import '../provider/patient_provider.dart';

class AddNewPatientScreen extends StatefulWidget {
  const AddNewPatientScreen({super.key});

  @override
  State<AddNewPatientScreen> createState() => _AddNewPatientScreenState();
}

class _AddNewPatientScreenState extends State<AddNewPatientScreen> {
  int currentStep = 1;

  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, PatientProvider patientProvider, Widget? child) {
        patientProvider.addNewPatientContext = context;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              prefModel.userData!.roleId == 2
                  ? AppLocale.addMember.getString(context)
                  : prefModel.userData!.roleId == 3
                  ? AppLocale.addPatients.getString(context)
                  : prefModel.userData!.roleId == 4
                  ? AppLocale.addPlayer.getString(context)
                  : "",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 75,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Form(
            key: patientProvider.addPatientFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    patientDetails(patientProvider),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.white,
                      width: screenSize!.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getPrimaryAppButton(
                            context,
                            AppLocale.submit.getString(context),
                            onPressed: () async {
                              if (patientProvider.addPatientFormKey.currentState!.validate()) {
                                patientProvider.addNewPatient();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  patientDetails(PatientProvider patientProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocale.fillNewPatients.getString(context),
          style: const TextStyle(color: AppColors.fontShadeColor, fontSize: 13),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            showImageSourceDialog(context, onOptionSelected: (value) async {
              if (value == AppLocale.camera.getString(context)) {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (image != null) {
                  CroppedFile? croppedImage = await cropImage(image.path);
                  if (croppedImage != null) {
                    setState(() {
                      patientProvider.addPatientSelectedImage =
                          File(croppedImage.path);
                    });
                  }
                }
              } else if (value == AppLocale.gallery.getString(context)) {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  CroppedFile? croppedImage = await cropImage(image.path);
                  if (croppedImage != null) {
                    setState(() {
                      patientProvider.addPatientSelectedImage =
                          File(croppedImage.path);
                    });
                  }
                }
              }
            });
          },
          child: Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                      patientProvider.addPatientSelectedImage != null
                          ? FileImage(patientProvider.addPatientSelectedImage!)
                          : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                Positioned(
                    bottom: 4,
                    right: 2,
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.primaryColor,
                        child: IconButton(
                            onPressed: () {
                              showImageSourceDialog(context,
                                  onOptionSelected: (value) async {
                                if (value == AppLocale.camera.getString(context)) {
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (image != null) {
                                    CroppedFile? croppedImage =
                                        await cropImage(image.path);
                                    if (croppedImage != null) {
                                      setState(() {
                                        patientProvider
                                                .addPatientSelectedImage =
                                            File(croppedImage.path);
                                      });
                                    }
                                  }
                                } else if (value == AppLocale.gallery.getString(context)) {
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    CroppedFile? croppedImage =
                                        await cropImage(image.path);
                                    if (croppedImage != null) {
                                      setState(() {
                                        patientProvider
                                                .addPatientSelectedImage =
                                            File(croppedImage.path);
                                      });
                                    }
                                  }
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 15,
                            ),
                            color: Colors.white))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(AppLocale.firstName.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientFirstNameController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validFirstName.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.text,
          maxLength: 74,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.firstName.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(AppLocale.lastName.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientLastNameController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validLastName.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.text,
          maxLength: 74,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.lastName.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(AppLocale.mobile.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: patientProvider.addNewPatientMobileController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPhone.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          maxLength: 10,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.mobile.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(AppLocale.email.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: patientProvider.addNewPatientEmailController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validEmail.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            errorMaxLines: 2,
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.email.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(AppLocale.dateOfBirth.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(
                        ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1026),
                        lastDate: DateTime.now(),
                      );
                      setState(() {
                        patientProvider.addNewPatientDobController.text =
                            "${picked!.year}-${picked.month}-${picked.day}";
                      });
                    },
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocale.validDate.getString(context);
                        }
                        return null;
                      },
                      enabled: false,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        errorStyle: const TextStyle(color: Colors.red),
                        errorMaxLines: 2,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffD3D3D3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {},
                        ),
                        filled: true,
                        hintText: AppLocale.dateOfBirth.getString(context),
                        fillColor: Colors.white,
                      ),
                      controller: patientProvider.addNewPatientDobController,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        Row(
          children: [
            Text(AppLocale.gender.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.validGender.getString(context);
            }
            return null;
          },
          decoration: InputDecoration(
            errorMaxLines: 2,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.green,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            errorStyle: TextStyle(color: Colors.red.shade400),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          dropdownColor: Colors.white,
          hint: Text(AppLocale.selectGender.getString(context)),
          value: patientProvider.addNewPatientGender,
          onChanged: (String? value) {
            setState(() {
              patientProvider.addNewPatientGender = value;
            });
          },
          style: const TextStyle(color: Colors.black),
          items: <String>["Male", "Female", "Do not wish to specify"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(AppLocale.bloodGroup.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.validBloodGroup.getString(context);
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xffD3D3D3),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            focusColor: Colors.transparent,
            errorStyle: TextStyle(color: Colors.red.shade400),
          ),
          dropdownColor: Colors.white,
          hint: Text(AppLocale.bloodGroup.getString(context)),
          value: patientProvider.addPatientBloodGroup,
          onChanged: (String? value) {
            setState(() {
              patientProvider.addPatientBloodGroup = value!;
            });
          },
          style: const TextStyle(color: Colors.black),
          items: <String>["O+ve", "AB+ve", "B+ve", "O-ve", "A+ve", "A-ve","B-ve","AB-ve"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),


        const Text("Height",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.heightController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Height",
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        const Text("Weight",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.weightController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Weight",
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        Row(
          children: [
            Text(AppLocale.country.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.validCountry.getString(context);
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade50,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 16),
            focusColor: Colors.transparent,
            errorStyle: TextStyle(color: Colors.red.shade400),
          ),
          dropdownColor: Colors.white,
          value: patientProvider.countryAs,
          hint: const Text("Country"),
          onChanged: (String? value) async {
            var selectedCountry = patientProvider.countryMasterResponse!.result!
                .firstWhere((country) => country.name == value);
            patientProvider.selectedCountryId = selectedCountry.id;
            await patientProvider.getStateMaster(context, selectedCountry.uniqueGuid);
            setState(() {
              patientProvider.countryAs = value!;
              patientProvider.stateAs = null;
            });
          },
          style: const TextStyle(color: Colors.black),
          items: patientProvider.countryMasterResponse!.result!
              .map<DropdownMenuItem<String>>((country) {
            return DropdownMenuItem<String>(
              value: country.name,
              child: Text(country.name.toString()),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            Text(AppLocale.state.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.stateValid.getString(context);
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade50,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 16),
            focusColor: Colors.transparent,
            errorStyle: TextStyle(color: Colors.red.shade400),
          ),
          dropdownColor: Colors.white,
          value: patientProvider.stateAs,
          hint: Text(AppLocale.state.getString(context)),
          onChanged: (String? value) {
            var selectedState = patientProvider.stateMasterResponse!.result!
                .firstWhere((state) => state.name == value);

            patientProvider.selectedStateId = selectedState.id;
            setState(() {
              patientProvider.stateAs = value!;
            });
          },
          style: const TextStyle(color: Colors.black),
          items: patientProvider.stateMasterResponse?.result?.map<DropdownMenuItem<String>>((state) {
            return DropdownMenuItem<String>(
              value: state.name,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(state.name.toString()),
              ),
            );
          }).toList() ?? [],
        ),

        const SizedBox(
          height: 10,
        ),
         Text(AppLocale.street.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientStreetController,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return AppLocale.streetValid.getString(context);
          //   }
          //   return null;
          // },
          keyboardType: TextInputType.streetAddress,
          maxLength: 74,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.street.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(height: 10,),
         Text(AppLocale.area.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientAreaController,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return AppLocale.areaValid.getString(context);
          //   }
          //   return null;
          // },
          keyboardType: TextInputType.streetAddress,
          maxLength: 74,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.area.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),

        const SizedBox(height: 10,),
         Text(AppLocale.landMark.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientLandmarkController,
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return AppLocale.landMarkValid.getString(context);
          //   }
          //   return null;
          // },
          keyboardType: TextInputType.streetAddress,
          maxLength: 74,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.landMark.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Text(AppLocale.city.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientCityController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.cityValid.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],
          maxLength: 74,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.city.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(height: 10,),
         Text(AppLocale.pinCode.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientPinCodeController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.pinCodeValid.getString(context);
            }
            if (value.length<6) {
              return AppLocale.pinCodeValid.getString(context);
            }
            return null;
          },
          maxLength: 6,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.pinCode.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

      ],
    );
  }

  firstQuestion(PatientProvider patientProvider) {
    return Text(
      AppLocale.questionarie1.getString(context),
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }

  secondQuestion(PatientProvider patientProvider) {
    return Text(
      AppLocale.questionarie2.getString(context),
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
