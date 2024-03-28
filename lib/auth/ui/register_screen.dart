import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/auth/auth_provider.dart';
import 'package:vicare/auth/model/send_otp_response_model.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../main.dart';
import '../../utils/app_buttons.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int currentStep = 1;

  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.registerPageContext = context;
        return Scaffold(
          body: Form(
            key: authProvider.registerFormKey,
            child: Column(
              children: [
                // Non-scrollable part
                Padding(
                  padding: const EdgeInsets.only(
                      top: 80, left: 20, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocale.createAccount.getString(context),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocale.pleaseFillToRegister.getString(context),
                        style: const TextStyle(color: AppColors.fontShadeColor),
                      ),
                      const SizedBox(height: 10),
                      StepProgressIndicator(
                        roundedEdges: const Radius.circular(20),
                        size: 7,
                        totalSteps: 3,
                        currentStep: currentStep,
                        selectedColor: AppColors.primaryColor,
                        unselectedColor: Colors.grey,
                      ),
                    ],
                  ),
                ),

                // Scrollable part
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          currentStep == 1
                              ? emailPassword(authProvider)
                              : const SizedBox.shrink(),
                          currentStep == 2
                              ? otpScreen(authProvider)
                              : const SizedBox.shrink(),
                          currentStep == 3
                              ? personalDetails(authProvider)
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                          if (authProvider
                                              .registerFormKey.currentState!
                                              .validate()) {
                                            if (currentStep == 1) {
                                              SendOtpResponseModel response =
                                                  await authProvider.sendOtp();
                                              authProvider.otpReceived =
                                                  response.result!.otp;
                                              authProvider.registerOtpController
                                                  .clear();
                                              setState(() {
                                                currentStep = currentStep + 1;
                                              });
                                            } else if (currentStep == 2) {
                                              if (authProvider.otpReceived ==
                                                  authProvider
                                                      .registerOtpController
                                                      .text) {
                                                showSuccessToast(context,
                                                    AppLocale.otpSuccessful.getString(context));
                                                setState(() {
                                                  currentStep = currentStep + 1;
                                                });
                                              } else {
                                                showErrorToast(
                                                    context, AppLocale.invalidOtp.getString(context));
                                                // show error toast invalid otp
                                              }
                                            }
                                          }
                                        },
                                      )
                                    : getPrimaryAppButton(
                                        context,
                                        AppLocale.proceedToSignUp
                                            .getString(context),
                                        onPressed: () async {
                                          if (authProvider
                                              .registerFormKey.currentState!
                                              .validate()) {
                                            if (authProvider
                                                .registerSelectedImage ==
                                                null) {
                                              showErrorToast(context,
                                                  AppLocale.validImage.getString(context));
                                              return;
                                            }
                                            authProvider.register();
                                          }
                                        },
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  emailPassword(AuthProvider authProvider) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocale.email.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: authProvider.registerEmailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocale.validEmail.getString(context);
                }
                if (authProvider.isNotValidEmail(value)) {
                  return AppLocale.validEmail.getString(context);
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: AppLocale.email.getString(context),
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
            Text(AppLocale.password.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),

            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textCapitalization: TextCapitalization.sentences,
              controller: authProvider.registerPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocale.validPassword.getString(context);
                }
                if (!authProvider.isStrongPassword(value)) {
                  return AppLocale.strongPassword.getString(context);
                }
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              obscureText: authProvider.registerIsShowPassword,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: AppLocale.password.getString(context),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      authProvider.registerIsShowPassword =
                          !authProvider.registerIsShowPassword;
                    });
                  },
                  child: Icon(
                    authProvider.registerIsShowPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                counterText: "",
                isCollapsed: true,
                errorMaxLines: 2,
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
            Text(AppLocale.registerAs.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocale.validRole.getString(context);
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
              value: authProvider.registerAs,
              hint: Text(AppLocale.role.getString(context)),
              onChanged: (String? value) {
                for (var role in authProvider.masterRolesResponse!.result!) {
                  if (role.name == value) {
                    authProvider.selectedRoleId = role.id;
                    break;
                  }
                }

                setState(() {
                  authProvider.registerAs = value!;
                });
              },
              style: const TextStyle(color: Colors.black),
              items: <String>[
                for (int i = 0;
                    i < authProvider.masterRolesResponse!.result!.length;
                    i++)
                  authProvider.masterRolesResponse!.result![i].name!,
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // SizedBox(height: screenSize.height/7,),
          ],
        ),
      ],
    );
  }

  otpScreen(AuthProvider authProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocale.enterOtp.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: authProvider.registerOtpController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validOtp.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.otp.getString(context),
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
      ],
    );
  }

  personalDetails(AuthProvider authProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      authProvider.registerSelectedImage =
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
                      authProvider.registerSelectedImage =
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
                  backgroundImage: authProvider.registerSelectedImage != null
                      ? FileImage(authProvider.registerSelectedImage!)
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
                                        authProvider.registerSelectedImage =
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
                                        authProvider.registerSelectedImage =
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
        Text(AppLocale.firstName.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: authProvider.registerFirstName,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validFirstName.getString(context);
            }
            // if (authController.isNotValidName(value)) {
            //   return AppLocale.validFirstName.getString(context);
            // }
            return null;
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.firstName.getString(context),
            hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
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
          controller: authProvider.registerLastName,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validLastName.getString(context);
            }
            // if (authController.isNotValidName(value)) {
            //   return AppLocale.validFirstName.getString(context);
            // }
            return null;
          },
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.lastName.getString(context),
            hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
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
        Text(AppLocale.contactNumber.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: authProvider.registerContactNumberController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validContact.getString(context);
            }
            if (authProvider.isNotValidContactNumber(value)) {
              return AppLocale.validContact.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,

          maxLength: 10,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.contactNumber.getString(context),
            hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
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
          value: authProvider.registerBloodGroup,
          onChanged: (String? value) {
            setState(() {
              authProvider.registerBloodGroup = value!;
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
        Text(AppLocale.gender.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocale.validGender.getString(context);
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
          hint: Text(AppLocale.selectGender.getString(context)),
          value: authProvider.gender,
          onChanged: (String? value) {
            setState(() {
              authProvider.selectedGender = value == "Male"
                  ? 1
                  : value == "Female"
                      ? 2
                      : value == "Do not wish to specify"
                          ? 3
                          : 0;
              authProvider.gender = value!;
            });
          },
          style: const TextStyle(color: Colors.black),
          items: <String>[
            "Male",
            "Female",
            "Do not wish to specify"
            // AppLocale.male.getString(context),
            // AppLocale.female.getString(context)
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
                        authProvider.registerDobController.text =
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
                        errorMaxLines: 2,
                      ),
                      controller: authProvider.registerDobController,
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
         Text(AppLocale.state.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
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
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            focusColor: Colors.transparent,
            errorStyle: TextStyle(color: Colors.red.shade400),
          ),
          dropdownColor: Colors.white,
          value: authProvider.registerStateAs,
          hint:  Text(AppLocale.state.getString(context)),
          onChanged: (String? value) {
            for (var state in authProvider.stateMasterResponse!.result!) {
              if (state.name == value) {
                authProvider.selectedStateId = state.id;
                break;
              }
            }
            setState(() {
              authProvider.registerStateAs = value!;
            });
          },
          style: const TextStyle(color: Colors.black),
          items: <String>[
            for (int i = 0; i < authProvider.stateMasterResponse!.result!.length; i++)
              authProvider.stateMasterResponse!.result![i].name.toString(),
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
         Text(AppLocale.street.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: authProvider.registerStreetController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.streetValid.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
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
          controller: authProvider.registerAreaController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.areaValid.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
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
         Text(AppLocale.landMark.getString(context), style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: authProvider.registerLandmarkController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.landMarkValid.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
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
         Text(AppLocale.city.getString(context),
            style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          controller: authProvider.registerCityController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.cityValid.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
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
          controller: authProvider.registerPinCodeController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.pinCodeValid.getString(context);
            }
            return null;
          },
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
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize!.width - 40,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocale.agreeToLogin.getString(context),
                      style: const TextStyle(
                        color: AppColors.fontShadeColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Routes.webViewRoute,
                              arguments: {
                                'url': "https://www.google.com",
                                'title': AppLocale.termsAndConditions
                                    .getString(context),
                              });
                        },
                      text: AppLocale.termsAndConditions.getString(context),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: AppLocale.and.getString(context),
                      style: const TextStyle(
                        color: AppColors.fontShadeColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Routes.webViewRoute,
                              arguments: {
                                'url': "https://www.google.com",
                                'title':
                                    AppLocale.privacyPolicy.getString(context),
                              });
                        },
                      text: AppLocale.privacyPolicy.getString(context),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
