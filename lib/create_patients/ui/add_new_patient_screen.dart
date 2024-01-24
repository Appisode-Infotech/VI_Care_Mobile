import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';
import 'package:vicare/utils/routes.dart';

class AddNewPatientScreen extends StatefulWidget {
  const AddNewPatientScreen({super.key});

  @override
  State<AddNewPatientScreen> createState() => _AddNewPatientScreenState();
}

class _AddNewPatientScreenState extends State<AddNewPatientScreen> {

  final formKey = GlobalKey<FormState>();

  int currentStep = 1;
  TextEditingController dobController = TextEditingController();
  String? gender;

  Color getIndicatorColor(int step) {
    return currentStep >= step ? AppColors.primaryColor : Colors.grey;
  }

  File? _selectedImage;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.addPatients.getString(context), style: const TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
      ),
      body:  Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              children: [
                StepProgressIndicator(
                  roundedEdges: const Radius.circular(20),
                  size: 7,
                  totalSteps: 3,
                  currentStep: currentStep,
                  selectedColor: AppColors.primaryColor,
                  unselectedColor: Colors.grey,
                ),
                const SizedBox(height: 20,),
                currentStep == 1?patientDetails(screenSize!):const SizedBox.shrink(),
                currentStep == 2?firstQuestion(screenSize!):const SizedBox.shrink(),
                currentStep == 3?secondQuestion(screenSize!):const SizedBox.shrink(),
                const SizedBox(height:10),
                Container(
                  color: Colors.white,
                  width: screenSize!.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      currentStep!=1?getPrimaryAppButton(context, AppLocale.previous.getString(context), onPressed: (){
                        setState(() {
                          currentStep=currentStep-1;
                        });
                      }):const SizedBox.shrink(),
                      const SizedBox(height: 10,),
                      (currentStep==1 || currentStep==2)?getPrimaryAppButton(context, AppLocale.next.getString(context),
                          onPressed: () {
                            setState(() {
                              currentStep = currentStep+1;
                            });
                          }):getPrimaryAppButton(context, AppLocale.submit.getString(context),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.patientDetailsRoute);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  patientDetails(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(AppLocale.fillNewPatients.getString(context),style: TextStyle(color: AppColors.fontShadeColor,fontSize: 13),),
        const SizedBox(height: 12,),
        GestureDetector(
          onTap: _getImageFromGallery,
          child: Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                Positioned(
                    bottom: 4,
                    right: 2,
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.primaryColor,
                        child: IconButton(
                            onPressed: _getImageFromGallery,
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 15,
                            ),
                            color: Colors.white))),
              ],
            ),
          ),
        ),
        const SizedBox(height:10),
         Text(AppLocale.mobile.getString(context), style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10,),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validPhone.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.mobile.getString(context),
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
        Text(AppLocale.email.getString(context), style: const TextStyle(fontWeight: FontWeight.w600)),
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
        const SizedBox(height: 20,),
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
                          borderSide: const BorderSide(color: Color(0xffD3D3D3)),
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
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20,),

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

        const SizedBox(height: 20,),
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


        const SizedBox(height: 20,),
        Text(AppLocale.gender.getString(context), style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10,),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.green,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
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

        const SizedBox(height:20),
         Text(AppLocale.address.getString(context), style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height:10),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocale.validAddress.getString(context);
            }
            return null;
          },
          keyboardType: TextInputType.streetAddress,
          maxLines: 3,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: AppLocale.address.getString(context),
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
    );
  }

  firstQuestion(Size size) {
    return Text(AppLocale.questionarie1.getString(context),style: TextStyle(fontWeight: FontWeight.w600),);
  }

  secondQuestion(Size size) {
    return Text(AppLocale.questionarie2.getString(context),style: TextStyle(fontWeight: FontWeight.w600),);
  }
}
