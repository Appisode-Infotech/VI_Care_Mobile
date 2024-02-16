import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:vicare/create_patients/provider/profile_provider.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ProfileProvider profileProvider,
          Widget? child) {
        profileProvider.changePasswordPageContext = context;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocale.changePassword.getString(context),
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
            key: profileProvider.changePasswordFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      height: 30,
                    ),
                    getPrimaryAppButton(
                        context, AppLocale.submit.getString(context),
                        onPressed: () async {
                      Navigator.pushNamed(context, Routes.profileRoute);
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
