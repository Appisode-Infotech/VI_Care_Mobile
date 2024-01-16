import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../main.dart';
import '../utils/app_buttons.dart';
import '../utils/appcolors.dart';
import '../routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding:  const EdgeInsets.symmetric(vertical: 80,horizontal:30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(onTap: () {
                Navigator.pushNamed(context, Routes.onboardingRoute);
              },
                child: const Icon(Icons.arrow_back_ios, size: 25, weight: 45,),
              ),
              const SizedBox(height: 10,),
              const Text("Forgot password ?",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              const SizedBox(height: 10,),
              const Text("Please enter your registered email, We will send you an otp on your mail to reset your password",style: TextStyle(fontSize: 12,color: AppColors.fontShadeColor),),
              const SizedBox(height: 20,),
              const StepProgressIndicator(
                roundedEdges: Radius.circular(20),
                size: 7,
                totalSteps: 2,
                currentStep: 1,
                selectedColor: AppColors.primaryColor,
                unselectedColor: Colors.grey,
              ),

              const SizedBox(height:20),
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
              SizedBox(height: screenSize!.height/7,),

              Align(
                alignment: Alignment.bottomCenter,
              child:getPrimaryAppButton(context, "Send Otp",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.resetPasswordRoute);
                  }),
              )
            ],
          ),
        ),

      ),
    );
  }
}
