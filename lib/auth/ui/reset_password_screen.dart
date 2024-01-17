import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../main.dart';
import '../../utils/routes.dart';
import '../../utils/app_buttons.dart';
import '../../utils/appColors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  bool isShowPassword = true;
  final _formKey = GlobalKey<FormState>();

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
              getPrimaryAppButton(context, "Submit", onPressed: (){
                Navigator.pushNamed(context, Routes.resetPasswordRoute);
              })
            ],
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.symmetric(vertical: 80,horizontal:30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(onTap: () {
                  Navigator.pushNamed(context, Routes.onBoardingRoute);
                },
                  child: const Icon(Icons.arrow_back_ios, size: 25, weight: 45,),
                ),
                const SizedBox(height: 10,),
                const Text("Reset password ?",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                const SizedBox(height: 10,),
                const Text("Please enter the otp sent to your mail and \nenter your new password.",style: TextStyle(fontSize: 12,color: AppColors.fontShadeColor),),
                const SizedBox(height: 20,),
                const StepProgressIndicator(
                  roundedEdges: Radius.circular(20),
                  size: 7,
                  totalSteps: 2,
                  currentStep: 2,
                  selectedColor: AppColors.primaryColor,
                  unselectedColor: Colors.grey,
                ),
                const SizedBox(height:30),
                const Text("Enter OTP sent to your email", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 15,),
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
                const Text("New Password",style: TextStyle(fontWeight: FontWeight.w600),),
                const SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: const Color(0xffD3D3D3),),
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: isShowPassword,
                    textAlignVertical: TextAlignVertical.center,
                    decoration:  InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        counterText: "",
                        isCollapsed: true,
                        suffixIcon: CupertinoButton(onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                            print(isShowPassword);
                          });
                        },
                          child:  isShowPassword?const Icon(
                            Icons.visibility_off, color: Colors.grey,
                          ):const Icon(
                            Icons.visibility, color: Colors.grey,
                          ),
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text("Confirm New Password",style: TextStyle(fontWeight: FontWeight.w600),),
                const SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: const Color(0xffD3D3D3),),
                  ),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: isShowPassword,
                    textAlignVertical: TextAlignVertical.center,
                    decoration:  InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        counterText: "",
                        isCollapsed: true,
                        suffixIcon: CupertinoButton(onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                            print(isShowPassword);
                          });
                        },
                          child:  isShowPassword?const Icon(
                            Icons.visibility_off, color: Colors.grey,
                          ):const Icon(
                            Icons.visibility, color: Colors.grey,
                          ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );

  }
}
