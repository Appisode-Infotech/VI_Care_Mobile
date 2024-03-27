import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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
      builder: (BuildContext context, PatientProvider patientProvider,
          Widget? child) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    StepProgressIndicator(
                      roundedEdges: const Radius.circular(20),
                      size: 7,
                      totalSteps: 3,
                      currentStep: currentStep,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    currentStep == 1
                        ? patientDetails(patientProvider)
                        : const SizedBox.shrink(),
                    currentStep == 2
                        ? firstQuestion(patientProvider)
                        : const SizedBox.shrink(),
                    currentStep == 3
                        ? secondQuestion(patientProvider)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                    Container(
                      color: Colors.white,
                      width: screenSize!.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          currentStep != 1
                              ? getPrimaryAppButton(
                                  context,
                                  AppLocale.previous.getString(context),
                                  onPressed: () async {
                                    setState(() {
                                      currentStep = currentStep - 1;
                                    });
                                  },
                                  buttonColor: Colors.red.shade500,
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                          currentStep == 1 || currentStep == 2
                              ? getPrimaryAppButton(
                                  context,
                                  AppLocale.next.getString(context),
                                  onPressed: () async {
                                    if (patientProvider
                                        .addPatientFormKey.currentState!
                                        .validate()) {
                                      if (currentStep == 1) {
                                        if (patientProvider
                                                .addPatientSelectedImage ==
                                            null) {
                                          showErrorToast(context,
                                              "Please select an image");
                                          return;
                                        }
                                      }
                                      setState(() {
                                        currentStep = currentStep + 1;
                                      });
                                    }
                                  },
                                )
                              : getPrimaryAppButton(
                                  context,
                                  AppLocale.submit.getString(context),
                                  onPressed: () async {
                                    if (patientProvider
                                        .addPatientFormKey.currentState!
                                        .validate()) {
                                      patientProvider.addNewPatient();
                                    }
                                  },
                                ),
                        ],
                      ),
                    )
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
              if (value == 'Camera') {
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
              } else if (value == 'Gallery') {
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
                                if (value == 'Camera') {
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
                                } else if (value == 'Gallery') {
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
        Text(AppLocale.mobile.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: patientProvider.addNewPatientMobileController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPhone.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.number,
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
        Text(AppLocale.email.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
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
                  Text(AppLocale.dateOfBirth.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
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
                          return "Please enter valid Date";
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
        Text(AppLocale.firstName.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientFirstNameController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validFirstName.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.text,
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
        Text(AppLocale.lastName.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientLastNameController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validLastName.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.text,
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
        Text(AppLocale.gender.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select the gender";
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
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
              patientProvider.addNewPatientGender = value!;
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
        Text(AppLocale.bloodGroup.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
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
          items: <String>["O+ve", "AB+ve", "B+ve", "O-ve", "A+ve", "A-ve"]
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
        const Text("State",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select the state";
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
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            focusColor: Colors.transparent,
            errorStyle: TextStyle(color: Colors.red.shade400),
          ),
          dropdownColor: Colors.white,
          value: patientProvider.stateAs,
          hint: const Text("State"),
          onChanged: (String? value) {
            for (var state in patientProvider.stateMasterResponse!.result!) {
              if (state.name == value) {
                patientProvider.selectedStateId = state.id;
                break;
              }
            }
            setState(() {
              patientProvider.stateAs = value!;
            });
          },
          style: const TextStyle(color: Colors.black),
          items: <String>[
            for (int i = 0; i < patientProvider.stateMasterResponse!.result!.length; i++)
              patientProvider.stateMasterResponse!.result![i].name.toString(),
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

        const SizedBox(
          height: 10,
        ),
        const Text("Street",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientStreetController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter valid street";
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Street",
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
        const Text("Area",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientAreaController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter valid area";
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Area",
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
        const Text("Landmark",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientLandmarkController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter valid landmark";
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Landmark",
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
        const Text("City",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientCityController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter valid City";
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "City",
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
        const Text("PinCode",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: patientProvider.addNewPatientPinCodeController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter valid PinCode";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "PinCode",
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
