import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vicare/main.dart';

import '../../auth/model/register_response_model.dart';
import '../../auth/model/send_otp_response_model.dart';
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
  final changePasswordFormKey = GlobalKey<FormState>();

  String? resetPasswordOtp;
  CountdownController countdownController =
  CountdownController(autoStart: true);
  int seconds = 30;
  bool firstStateEnabled = false;


  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ProfileProvider profileProvider,
          Widget? child) {
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
                            fontSize: 12, color: AppColors.fontShadeColor),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              currentStep != 1
                                  ? Expanded(
                                      child: getPrimaryAppButton(
                                      context,
                                      AppLocale.previous.getString(context),
                                      onPressed: () async {
                                        setState(() {
                                          currentStep = currentStep - 1;
                                        });
                                      },
                                      buttonColor: Colors.red.shade500,
                                    ))
                                  : const SizedBox.shrink(),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: (currentStep == 1)
                                    ? getPrimaryAppButton(context,
                                        AppLocale.next.getString(context),
                                        onPressed: () async {
                                      showLoaderDialog(context);
                                          RegisterResponseModel res = await profileProvider.verifyOtp(context,prefModel.userData!.email!,profileProvider
                                              .changePasswordOtpController
                                              .text);
                                          Navigator.pop(context);
                                        if (res.result!=null) {
                                          showSuccessToast(
                                              context,
                                              res.message.toString());
                                          setState(() {
                                            currentStep = currentStep + 1;
                                          });
                                        } else {
                                          showErrorToast(
                                              context,
                                              res.message.toString());
                                        }
                                      })
                                    : getPrimaryAppButton(context,
                                        AppLocale.submit.getString(context),
                                        onPressed: () async {
                                        if (changePasswordFormKey.currentState!
                                            .validate()) {
                                          profileProvider
                                              .resetNewPassword(context);
                                        }
                                      }),
                              )
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
          enabled: false,
          initialValue: prefModel.userData!.email,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validOtp.getString(context);
            }
            if (profileProvider.isNotValidEmail(value)) {
              return AppLocale.validEmail.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.otp.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(
                color: Colors.red, overflow: TextOverflow.ellipsis),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorMaxLines: 2,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: profileProvider.changePasswordOtpController,
          maxLength: 6,
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
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.otp.getString(context),
            counterText: "",
            isCollapsed: true,
            errorStyle: const TextStyle(
                color: Colors.red, overflow: TextOverflow.ellipsis),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            errorMaxLines: 2,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            if (firstStateEnabled) {
              showLoaderDialog(context);
              SendOtpResponseModel response =
              await profileProvider.changePassword(context);
              profileProvider.resetPasswordOtp =
                  response.result!.otp;
              if (response.result != null) {
                showSuccessToast(context, response.message!);
              } else {
                showErrorToast(context, response.message!);
              }
              profileProvider.changePasswordOtpController.clear();
              Navigator.pop(context);
              setState(() {
                firstStateEnabled = false;
                countdownController.restart();
              });
            }
          },
          child: Countdown(
            controller: countdownController,
            seconds: seconds,
            build: (context, time) => Text(
              firstStateEnabled
                  ? 'Resend'
                  : 'Resend OTP in ${time.round()}',
              style: TextStyle(
                color: firstStateEnabled
                    ? AppColors.primaryColor
                    : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            interval: const Duration(seconds: 1),
            onFinished: () {
              setState(() {
                firstStateEnabled =
                !firstStateEnabled;
              });
            },
          ),
        ),
      ],
    );
  }

  changePassword(ProfileProvider profileProvider) {
    return Form(
      key: changePasswordFormKey,
      child: Column(
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
            controller: profileProvider.changePasswordOneController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocale.validPassword.getString(context);
              }
              if (!profileProvider.isStrongPassword(value)) {
                return AppLocale.strongPassword.getString(context);
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
              errorStyle: const TextStyle(
                  color: Colors.red, overflow: TextOverflow.ellipsis),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              errorMaxLines: 2,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
            controller: profileProvider.changePasswordTwoController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocale.validPassword.getString(context);
              }
              if (!profileProvider.isStrongPassword(value)) {
                return AppLocale.strongPassword.getString(context);
              }
              return null;
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: profileProvider.changePasswordIsConfirmPassword,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: AppLocale.password.getString(context),
              suffixIcon: CupertinoButton(
                onPressed: () {
                  setState(() {
                    profileProvider.changePasswordIsConfirmPassword =
                        !profileProvider.changePasswordIsConfirmPassword;
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
              errorStyle: const TextStyle(
                  color: Colors.red, overflow: TextOverflow.ellipsis),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              errorMaxLines: 2,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}
