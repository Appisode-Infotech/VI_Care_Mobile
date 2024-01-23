import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/main.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocale.profile.getString(context), style: const TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/img_1.png"),
                    radius: 40,
                  ),
                  SizedBox(width: 10,),
                  Text("Dr. Albert Raj",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)
                ],
              ),
               const SizedBox(height:10),
               Divider(color: Colors.grey.shade200,),
              const SizedBox(height:10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Icon(Icons.settings_outlined,color: AppColors.primaryColor,),),
                      const SizedBox(width: 10),
                       Text(AppLocale.scanSettings.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward,color: Colors.grey,)
                ],
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, Routes.offlineTestRoute);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: const Icon(Icons.cloud_off,color: AppColors.primaryColor,),),
                        const SizedBox(width: 10),
                         Text(AppLocale.offlineSaved.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    const Icon(Icons.arrow_forward,color: Colors.grey,)
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Icon(Icons.edit_outlined,color: AppColors.primaryColor,),),
                      const SizedBox(width: 10),
                       Text(AppLocale.editProfile.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward,color: Colors.grey,)
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Icon(Icons.lock_outline,color: AppColors.primaryColor,),),
                      const SizedBox(width: 10),
                       Text(AppLocale.changePassword.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward,color: Colors.grey,)
                ],
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () async {
                  await showLanguageBottomSheet(context,onLanguageChange);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: const Icon(Icons.language,color: AppColors.primaryColor,),),
                        const SizedBox(width: 10),
                        Text(AppLocale.changeLanguage.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    const Icon(Icons.arrow_forward,color: Colors.grey,)
                  ],
                ),
              ),
              const SizedBox(height:10),
              Divider(color: Colors.grey.shade200,),
              const SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Icon(Icons.description_outlined,color: AppColors.primaryColor,),),
                      const SizedBox(width: 10),
                       Text(AppLocale.termsConditions.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const Icon(Icons.call_made,color: Colors.grey,)
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Icon(Icons.newspaper,color: AppColors.primaryColor,),),
                      const SizedBox(width: 10),
                       Text(AppLocale.newsBlog.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const Icon(Icons.call_made,color: Colors.grey,)
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Icon(Icons.headset_mic_outlined,color: AppColors.primaryColor,),),
                      const SizedBox(width: 10),
                       Text(AppLocale.support.getString(context),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                    ],
                  ),
                  const Icon(Icons.call_made,color: Colors.grey,)
                ],
              ),
              const SizedBox(height: 30,),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: screenSize!.width,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                  child:  Center(child: Text(AppLocale.logOut.getString(context),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.w600),))),
            ],
          ),
        ),
      ),
    );
  }

  onLanguageChange(String languageCode) {
    localization.translate(languageCode);
  }
}
