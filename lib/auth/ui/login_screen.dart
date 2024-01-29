import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(image: AssetImage("assets/images/logo.png"),width: 150,),
                      const SizedBox(height: 20,),
                       Text(AppLocale.welcomeTo.getString(context) ,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                       Text(AppLocale.viCare.getString(context),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 10,),
                       Text(AppLocale.enterEmailAndPasswordTitle.getString(context),style: const TextStyle(color: AppColors.fontShadeColor),),
                      const SizedBox(height: 20,),
                       Text(AppLocale.email.getString(context),style: const TextStyle(fontWeight: FontWeight.w600),),
                      const SizedBox(height: 10,),
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
                          errorStyle: const TextStyle(
                              color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                      ),

                      const SizedBox(height: 10,),
                       Text(AppLocale.password.getString(context),style: const TextStyle(fontWeight: FontWeight.w600),),
                      const SizedBox(height: 10,),
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
                          errorStyle: const TextStyle(
                              color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, Routes.forgotResetPasswordRoute);
                            },
                            child: Text(AppLocale.forgotPassword.getString(context),style: const TextStyle(fontSize: 13),)),
                      ),
                      const SizedBox(height: 20,),
                      getPrimaryAppButton(context, AppLocale.signIn.getString(context),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(context, Routes.dashboardRoute);
                            }
                          }),
                    ],
                  ),
                ),

                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(AppLocale.dntHaveAnAccount.getString(context),style: const TextStyle(color: AppColors.fontShadeColor),),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(AppLocale.registerNow.getString(context),style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                  ],
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocale.agreeToLogin.getString(context),
                              style: const TextStyle(
                                color: AppColors.fontShadeColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, Routes.webViewRoute,
                                      arguments: {
                                        'url': "https://www.google.com",
                                        'title': AppLocale.termsAndConditions.getString(context),
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
                              text: AppLocale.and.getString(context) ,
                              style: const TextStyle(
                                color: AppColors.fontShadeColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, Routes.webViewRoute,
                                      arguments: {
                                        'url': "https://www.google.com",
                                        'title': AppLocale.privacyPolicy.getString(context),
                                      });
                                },
                              text: AppLocale.privacyPolicy.getString(context),
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
