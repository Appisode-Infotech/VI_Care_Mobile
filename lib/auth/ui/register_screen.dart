import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../main.dart';
import '../../utils/app_buttons.dart';
import '../../utils/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = true;
  bool rememberMe = false;
  TextEditingController dobController = TextEditingController();

  String? registerAs;

  int currentStep = 1;

  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.bottomCenter,
        width: screenSize!.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              currentStep!=1?getPrimaryAppButton(context, "Previous", onPressed: (){
                setState(() {
                  currentStep=currentStep-1;
                });
              }):const SizedBox.shrink(),
              const SizedBox(height: 20,),
              (currentStep==1 || currentStep==2)?getPrimaryAppButton(context, "Next",
                  onPressed: () {
                    setState(() {
                      currentStep = currentStep+1;
                    });
                  }):getPrimaryAppButton(context, "Proceed to signup",
                  onPressed: () {
                   Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardRoute, (route) => false);
                  }),
            ],
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.onBoardingRoute);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        weight: 45,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text("Create account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10,),
                    const Text("Please fill in the details to sign up and continue using the application",
                        style: TextStyle(color: AppColors.fontShadeColor)),
                    const SizedBox(height: 20,),
                     StepProgressIndicator(
                      roundedEdges: const Radius.circular(20),
                      size: 7,
                      totalSteps: 3,
                      currentStep: currentStep,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: Colors.grey,
                    ),
                    const SizedBox(height: 30,),
                    currentStep == 1?emailPassword(screenSize!):const SizedBox.shrink(),
                    currentStep == 2?otpScreen(screenSize!):const SizedBox.shrink(),
                    currentStep == 3?personalDetails(screenSize!):const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  emailPassword( Size screenSize) {
    return Column(
      children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
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
              const Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),

              TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid Password';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password',
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                        print(isShowPassword);
                      });
                    },
                    child: Icon(
                      !isShowPassword?Icons.visibility:Icons.visibility_off,
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Register as", style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade50,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                  focusColor: Colors.transparent,
                ),
                dropdownColor: Colors.white,
                value: registerAs,
                hint: const Text("Please select a role"),
                onChanged: (String? value) {
                  setState(() {
                    registerAs = value!;
                  });
                },
                style: const TextStyle(color: Colors.black),
                items: <String>['Doctor', 'Member'].map<DropdownMenuItem<String>>((String value) {
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

  otpScreen(Size screenSize) {
    return Column(
      children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter OTP sent to your email", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid OTP';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'OTP',
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

            ],
          ),
      ],
    );
  }

  personalDetails(Size screenSize) {
    return Column(
      children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("First Name", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid First Name';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'First Name',
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
              const Text("Last Name", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid Last Name';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Last Name',
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
              const Text("Gender", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xffD3D3D3),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                  focusColor: Colors.transparent,
                ),
                dropdownColor: Colors.white,
                hint: const Text("Select gender"),
                value: registerAs,
                onChanged: (String? value) {
                  setState(() {
                    registerAs = value!;
                  });
                },
                style: const TextStyle(color: Colors.black),
                items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Date of birth",style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15,top: 5,bottom: 5),
                            decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(10),
                              ),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xffD3D3D3),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1026),
                                    lastDate: DateTime.now());
                                setState(() {
                                  dobController.text = "${picked!.day} / ${picked.month} / ${picked.year}";
                                });
                              },
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_month),
                                    onPressed: () {},
                                  ),
                                ),
                                controller: dobController,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),


              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rememberMe = !rememberMe;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          // color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.6),
                        child: rememberMe
                            ? const Icon(
                          Icons.check,
                          size: 10,
                        )
                            : Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: screenSize.width/1.5,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'By clicking on proceed, you agree \nto our ',
                            style: TextStyle(
                              color: AppColors.fontShadeColor,
                              fontSize: 13,
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
                            text: " Terms And Conditions ",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: 'and \n',
                            style: TextStyle(
                              color: AppColors.fontShadeColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
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
                            text: 'Privacy Policy',
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.primaryColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // const SizedBox(height: 30,),
              // Align(
              //   alignment:Alignment.bottomCenter,
              //   child: getPrimaryAppButton(context, "Proceed to Sign Up",
              //       onPressed: () {
              //         setState(() {
              //           Navigator.pushNamed(context, Routes.dashboardRoute);
              //         });
              //       }),
              // ),
              //
              // const SizedBox(height: 20,),
              // Align(
              //   alignment:Alignment.bottomCenter,
              //   child: getPrimaryAppButton(context, "Previous",
              //       onPressed: () {
              //         setState(() {
              //           currentStep = 2;
              //         });
              //       }),
              // ),
            ],
          ),
      ],
    );
  }
}
