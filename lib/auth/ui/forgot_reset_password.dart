import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../main.dart';
import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class ForgotResetPassword extends StatefulWidget {
  const ForgotResetPassword({super.key});

  @override
  State<ForgotResetPassword> createState() => _ForgotResetPasswordState();
}

class _ForgotResetPasswordState extends State<ForgotResetPassword> {
  final formKey = GlobalKey<FormState>();

  bool isShowPassword = true;
  bool isConfirmPassword = true;
  int currentStep = 1;

  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.loginRoute);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    weight: 45,
                  ),
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
                            AppLocale.emailToResetPassword.getString(context),
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.fontShadeColor),
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
                                fontSize: 12, color: AppColors.fontShadeColor),
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
                    ? forgotPassword(screenSize!)
                    : const SizedBox.shrink(),
                currentStep == 2
                    ? resetPassword(screenSize!)
                    : const SizedBox.shrink(),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    currentStep != 1
                        ? getPrimaryAppButton(
                            context,
                            AppLocale.previous.getString(context),
                            onPressed: () {
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
                            onPressed: () {
                            setState(() {
                              currentStep = currentStep + 1;
                            });
                          })
                        : getPrimaryAppButton(
                            context, AppLocale.next.getString(context),
                            onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.loginRoute, (route) => false);
                          }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forgotPassword(Size size) {
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
          validator: (value) {
            if (value!.isEmpty) {
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

  Widget resetPassword(Size size) {
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
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validEmail.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
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
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPassword.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: isShowPassword,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.password.getString(context),
            suffixIcon: CupertinoButton(
              onPressed: () {
                setState(() {
                  isShowPassword = !isShowPassword;
                });
              },
              child: Icon(
                isShowPassword ? Icons.visibility_off : Icons.visibility,
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
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPassword.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: isConfirmPassword,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.password.getString(context),
            suffixIcon: CupertinoButton(
              onPressed: () {
                setState(() {
                  isConfirmPassword = !isConfirmPassword;
                });
              },
              child: Icon(
                isConfirmPassword ? Icons.visibility_off : Icons.visibility,
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
