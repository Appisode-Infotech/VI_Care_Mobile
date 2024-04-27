import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/auth/auth_provider.dart';

import '../../main.dart';
import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../model/send_otp_response_model.dart';

class ForgotResetPassword extends StatefulWidget {
  const ForgotResetPassword({super.key});

  @override
  State<ForgotResetPassword> createState() => _ForgotResetPasswordState();
}

class _ForgotResetPasswordState extends State<ForgotResetPassword> {
  int currentStep = 1;

  String? resetPasswordOtp;

  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.forgotPageContext = context;
        return Scaffold(
          body: Form(
            key: authProvider.forgotPasswordFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        weight: 45,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    currentStep == 1
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.forgotPassword.getString(context),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.emailToResetPassword
                                    .getString(context),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.fontShadeColor),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.resetPassword.getString(context),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.enterOtpForNewPswd.getString(context),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.fontShadeColor),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                    StepProgressIndicator(
                      roundedEdges: const Radius.circular(20),
                      size: 7,
                      totalSteps: 2,
                      currentStep: currentStep,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    currentStep == 1
                        ? forgotPassword(authProvider)
                        : const SizedBox.shrink(),
                    currentStep == 2
                        ? resetPassword(screenSize!, authProvider)
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
                                if (authProvider
                                    .forgotPasswordFormKey.currentState!
                                    .validate()) {
                                  SendOtpResponseModel response =
                                      await authProvider
                                          .sendOtpForResetPassword();
                                  if (response.result != null) {
                                    showSuccessToast(
                                        context, response.message!);
                                    resetPasswordOtp = response.result!.otp;
                                    setState(() {
                                      currentStep = currentStep + 1;
                                    });
                                  } else {
                                    showErrorToast(context, response.message!);
                                  }
                                }
                              })
                            : getPrimaryAppButton(
                                context, AppLocale.next.getString(context),
                                onPressed: () async {
                                if (authProvider
                                    .forgotPasswordFormKey.currentState!
                                    .validate()) {
                                  if (resetPasswordOtp ==
                                      authProvider
                                          .forgotPasswordOtpController.text) {
                                    authProvider.resetPassword(context);
                                  } else {
                                    showErrorToast(
                                        context, AppLocale.validOtp.getString(context));
                                  }
                                }
                              }),
                      ],
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

  Widget forgotPassword(AuthProvider authProvider) {
    return Column(
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
          controller: authProvider.forgotPasswordEmailController,
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
      ],
    );
  }

  Widget resetPassword(Size size, AuthProvider authProvider) {
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
          controller: authProvider.forgotPasswordOtpController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validOtp.getString(context);
            }
            if (value != resetPasswordOtp) {
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
        Text(
          AppLocale.newPassword.getString(context),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: authProvider.forgotPasswordNewPasswordController,
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
          obscureText: authProvider.forgotPasswordIsShowPassword,
          decoration: InputDecoration(
            errorMaxLines: 2,
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.password.getString(context),
            suffixIcon: CupertinoButton(
              onPressed: () {
                setState(() {
                  authProvider.forgotPasswordIsShowPassword =
                      !authProvider.forgotPasswordIsShowPassword;
                });
              },
              child: Icon(
                authProvider.forgotPasswordIsShowPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
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
        Text(
          AppLocale.confirmPassword.getString(context),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: authProvider.forgotPasswordConfirmPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPassword.getString(context);
            }

            if (value !=
                authProvider.forgotPasswordNewPasswordController.text) {
              return AppLocale.passwordsDoNotMatch.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: authProvider.forgotPasswordIsConfirmPassword,
          decoration: InputDecoration(
            errorMaxLines: 2,
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.password.getString(context),
            suffixIcon: CupertinoButton(
              onPressed: () {
                setState(() {
                  authProvider.forgotPasswordIsConfirmPassword =
                      !authProvider.forgotPasswordIsConfirmPassword;
                });
              },
              child: Icon(
                authProvider.forgotPasswordIsConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
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
}
