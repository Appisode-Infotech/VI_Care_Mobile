import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../provider/profile_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  int currentStep = 1;

  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, ProfileProvider profileProvider, Widget? child) {
      profileProvider.changePasswordPageContext = context;
      return Scaffold(
        body: Form(
          key: profileProvider.changePasswordFormKey,
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
                      AppLocale.changePassword.getString(context),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocale.enterOtpForNewPswd.getString(context),
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.fontShadeColor),
                    ),
                    const SizedBox(height: 20),

                    StepProgressIndicator(
                      roundedEdges: const Radius.circular(20),
                      size: 7,
                      totalSteps: 2,
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
                            ? otpScreen(profileProvider)
                            : const SizedBox.shrink(),
                        currentStep == 2
                            ? changePassword(profileProvider)
                            : const SizedBox.shrink(),
                        const SizedBox(height: 30),
                        Column(
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
                            (currentStep == 1)
                                ? getPrimaryAppButton(
                                context, AppLocale.next.getString(context),
                                onPressed: () async {
                                  if (profileProvider.resetPasswordOtp ==
                                      profileProvider.changePasswordOtpController.text) {
                                    showSuccessToast(context, "Otp verified successfully");
                                    setState(() {
                                      currentStep = currentStep + 1;
                                    });
                                  } else {
                                    showErrorToast(context, "Invalid Otp");
                                  }
                                })
                                : getPrimaryAppButton(
                                context, AppLocale.submit.getString(context),
                                onPressed: () async {
                                  profileProvider.resetNewPassword(context);

                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context, Routes.profileRoute, (route) => false);
                                }
                            ),
                          ],
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

  otpScreen(ProfileProvider profileProvider) {
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
          controller:profileProvider.changePasswordOtpController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validOtp.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.otp.getString(context),
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
      ],
    );
  }

  changePassword(ProfileProvider profileProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocale.newPassword.getString(context),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPassword.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: profileProvider.changePasswordIsShowPassword,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.password.getString(context),
            suffixIcon: CupertinoButton(
              onPressed: () {
                setState(() {
                  profileProvider.changePasswordIsShowPassword =
                  !profileProvider.changePasswordIsShowPassword;
                });
              },
              child: Icon(
                profileProvider.changePasswordIsShowPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
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
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppLocale.confirmPassword.getString(context),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPassword.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText:
          profileProvider.changePasswordIsConfirmPassword,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.password.getString(context),
            suffixIcon: CupertinoButton(
              onPressed: () {
                setState(() {
                  profileProvider.changePasswordIsConfirmPassword =
                  !profileProvider
                      .changePasswordIsConfirmPassword;
                });
              },
              child: Icon(
                profileProvider.changePasswordIsConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(color: Colors.red),
            errorMaxLines: 2,
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
            contentPadding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
