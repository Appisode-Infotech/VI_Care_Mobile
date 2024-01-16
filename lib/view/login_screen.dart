import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../utils/appcolors.dart';
import '../routes.dart';
import '../utils/app_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //     child: Form(
    //       key: _formKey,
    //       child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(20.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const Image(image: AssetImage("assets/images/logo.png"), width: 150),
    //                   const SizedBox(height: 20),
    //                   const Text('welcome').tr(),
    //                   const Text('viCare').tr(),
    //                   const SizedBox(height: 10),
    //                   const Text('enterEmailAndPassword').tr(),
    //                   const SizedBox(height: 20),
    //                   const Text('email').tr(),
    //                   const SizedBox(height: 15),
    //                   Container(
    //                     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: const BorderRadius.all(Radius.circular(10)),
    //                       border: Border.all(
    //                         color: const Color(0xffD3D3D3),
    //                       ),
    //                     ),
    //                     child: TextFormField(
    //                       textInputAction: TextInputAction.next,
    //                       decoration: const InputDecoration(
    //                         border: InputBorder.none,
    //                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
    //                         counterText: "",
    //                         isCollapsed: true,
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 20),
    //                   const Text('password').tr(),
    //                   const SizedBox(height: 15),
    //                   Container(
    //                     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: const BorderRadius.all(Radius.circular(10)),
    //                       border: Border.all(
    //                         color: const Color(0xffD3D3D3),
    //                       ),
    //                     ),
    //                     child: TextFormField(
    //                       textInputAction: TextInputAction.next,
    //                       obscureText: isShowPassword,
    //                       textAlignVertical: TextAlignVertical.center,
    //                       decoration: InputDecoration(
    //                         border: InputBorder.none,
    //                         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    //                         counterText: "",
    //                         isCollapsed: true,
    //                         suffixIcon: CupertinoButton(
    //                           onPressed: () {
    //                             setState(() {
    //                               isShowPassword = !isShowPassword;
    //                             });
    //                           },
    //                           child: isShowPassword
    //                               ? const Icon(
    //                             Icons.visibility_off,
    //                             color: Colors.grey,
    //                           )
    //                               : const Icon(
    //                             Icons.visibility,
    //                             color: Colors.grey,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 20),
    //                   Align(
    //                     alignment: Alignment.centerRight,
    //                     child: InkWell(
    //                       onTap: () {
    //                         Navigator.pushNamed(context, Routes.forgotPasswordRoute);
    //                       },
    //                       child: const Text('forgetPassword').tr(),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 20),
    //                   getPrimaryAppButton(context, 'signIn', onPressed: () {
    //                     Navigator.pushNamed(context, Routes.dashboardRoute);
    //                   }),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 30),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 const Text('dontHaveAccount').tr(),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.pushNamed(context, Routes.registerRoute);
    //                   },
    //                   child: const Text('registerNow', style: TextStyle(color: CupertinoColors.systemBlue, fontWeight: FontWeight.bold)),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 20),
    //             Center(
    //               child: const Text.rich(
    //                 TextSpan(
    //                   text: 'termsAndConditions1',
    //                   style: TextStyle(color: AppColors.fontShadeColor, fontSize: 14, fontWeight: FontWeight.w500),
    //                   children: [
    //                     TextSpan(
    //                       text: 'termsAndConditions2',
    //                       style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
    //                     ),
    //                     TextSpan(
    //                       text: 'termsAndConditions3',
    //                       style: TextStyle(color: AppColors.fontShadeColor, fontSize: 14, fontWeight: FontWeight.bold),
    //                     ),
    //                     TextSpan(
    //                       text: 'termsAndConditions4',
    //                       style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.bold),
    //                     ),
    //                   ],
    //                 ),
    //               ).tr(),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

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
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: const Color(0xffD3D3D3),),
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
                      const Text("Password",style: TextStyle(fontWeight: FontWeight.w600),),
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
                            Navigator.pushNamed(context, Routes.dashboardRoute);
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
                        child: const Text("Register Now",style: TextStyle(color: CupertinoColors.systemBlue,fontWeight: FontWeight.bold),))
                  ],
                ),
                const SizedBox(height: 20,),
                const Center(
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
