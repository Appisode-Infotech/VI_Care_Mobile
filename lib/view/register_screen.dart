import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/utils/appcolors.dart';
import 'package:vicare/routes.dart';

import '../main.dart';
import '../utils/app_buttons.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.pushNamed(context, Routes.onboardingRoute);
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
                    const StepProgressIndicator(
                      roundedEdges: Radius.circular(20),
                      size: 7,
                      totalSteps: 3,
                      currentStep: 1,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: Colors.grey,
                    ),
                    const SizedBox(height: 30,),
                    emailPassword(screenSize!),
                    otpScreen(screenSize!),
                    personalDetails(screenSize!)

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
        if (currentStep == 1)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color(0xffD3D3D3),
                  ),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    counterText: "",
                    isCollapsed: true,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color(0xffD3D3D3),
                  ),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  obscureText: isShowPassword,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    counterText: "",
                    isCollapsed: true,
                    suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                          print(isShowPassword);
                        });
                      },
                      child: const Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
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
              SizedBox(height: screenSize.height/7,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: getPrimaryAppButton(context, "Next",
                      onPressed: () {
                        setState(() {
                          currentStep = 2;
                        });
                }),
                ),
            ],
          ),
      ],
    );
  }

  otpScreen(Size screenSize) {
    return Column(
      children: [
        if (currentStep == 2)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter OTP sent to your email", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color(0xffD3D3D3),
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    counterText: "",
                    isCollapsed: true,
                  ),
                ),
              ),

              const SizedBox(height: 30,),
              Align(
                alignment:Alignment.bottomCenter,
                child: getPrimaryAppButton(context, "Previous",
                  onPressed: () {
                    setState(() {
                      currentStep = 1;
                    });
                  }),
              ),
              const SizedBox(height: 20,),

              Align(
                alignment:Alignment.bottomCenter,
                child: getPrimaryAppButton(context, "Next",
                    onPressed: () {
                      setState(() {
                        currentStep = 3;
                      });
                    }),
              ),
            ],
          ),
      ],
    );
  }

  personalDetails(Size screenSize) {
    return Column(
      children: [
        if (currentStep == 3)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("First Name", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color(0xffD3D3D3),
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    counterText: "",
                    isCollapsed: true,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Last Name", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color(0xffD3D3D3),
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    counterText: "",
                    isCollapsed: true,
                  ),
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
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By clicking on proceed, you agree \nto our ',
                            style: TextStyle(
                              color: AppColors.fontShadeColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms and conditions ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: 'and \n',
                            style: TextStyle(
                              color: AppColors.fontShadeColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
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

              const SizedBox(height: 30,),
              Align(
                alignment:Alignment.bottomCenter,
                child: getPrimaryAppButton(context, "Proceed to Sign Up",
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, Routes.homeRoute);
                      });
                    }),
              ),

              const SizedBox(height: 20,),
              Align(
                alignment:Alignment.bottomCenter,
                child: getPrimaryAppButton(context, "Previous",
                    onPressed: () {
                      setState(() {
                        currentStep = 2;
                      });
                    }),
              ),
            ],
          ),
      ],
    );
  }
}
