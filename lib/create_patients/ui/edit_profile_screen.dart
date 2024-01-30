import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = true;
  TextEditingController dobController = TextEditingController();

  String? registerAs;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.editProfile.getString(context), style: const TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 75,
        leading: IconButton(icon: const Icon(Icons.arrow_back,color: Colors.white,), onPressed: () { Navigator.pop(context); },),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(AppLocale.firstName.getString(context), style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocale.validFirstName.getString(context);
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: AppLocale.firstName.getString(context),
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
                Text(AppLocale.lastName.getString(context), style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 10,),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocale.validLastName.getString(context);
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: AppLocale.lastName.getString(context),
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
                Text(AppLocale.gender.getString(context), style: const TextStyle(fontWeight: FontWeight.w600)),
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
                  hint:  Text(AppLocale.selectGender.getString(context)),
                  value: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  items: <String>[AppLocale.male.getString(context), AppLocale.female.getString(context)].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocale.dateOfBirth.getString(context), style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1026),
                                lastDate: DateTime.now(),
                              );
                              setState(() {
                                dobController.text = "${picked!.day} / ${picked.month} / ${picked.year}";
                              });
                            },
                            child: TextFormField(
                              enabled: false,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color:   Color(0xffD3D3D3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_month),
                                  onPressed: () {},
                                ),
                                filled: true,
                                hintText: AppLocale.dateOfBirth.getString(context),
                                fillColor: Colors.white,
                              ),
                              controller: dobController,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          const SizedBox(height: 30,),
                          getPrimaryAppButton(context, AppLocale.submit.getString(context),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.profileRoute);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
