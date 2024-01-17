import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/app_buttons.dart';
import '../../utils/appColors.dart';
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
                      const Text("Welcome to ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                      const Text("VI Care ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                      const SizedBox(height: 10,),
                      const Text("Enter your email address and password to use the application",style: TextStyle(color: AppColors.fontShadeColor),),
                      const SizedBox(height: 20,),
                      const Text("Email",style: TextStyle(fontWeight: FontWeight.w600),),
                      const SizedBox(height: 15,),
                      TextFormField(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Email',
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
                      const Text("Password",style: TextStyle(fontWeight: FontWeight.w600),),
                      const SizedBox(height: 15,),
                      TextFormField(
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter valid password';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Password',
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
                              Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                            },
                            child: const Text("Forget Password?",style: TextStyle(fontSize: 13),)),
                      ),
                      const SizedBox(height: 20,),
                      getPrimaryAppButton(context, "Sign in",
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
                    const Text("Don't have an account? ",style: TextStyle(color: AppColors.fontShadeColor),),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: const Text("Register Now",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                  ],
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          children: [
                            TextSpan(
                              text: "By loging in to Vi Care app, You agree\nto our",
                              style: TextStyle(
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
                                        'title': "Terms and conditions",
                                      });
                                },
                              text: " Terms And Conditions \n",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "and ",
                              style: TextStyle(
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
                                        'title': "Privacy Policy",
                                      });
                                },
                              text: "Privacy Policy",
                              style: TextStyle(
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
