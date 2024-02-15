import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class EditPatientScreen extends StatefulWidget {
  const EditPatientScreen({super.key});

  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController dobController = TextEditingController();
  TextEditingController mobileController = TextEditingController(
      text: '8765432345');
  TextEditingController emailController = TextEditingController(
      text: 'smitha@email.com');
  TextEditingController firstNameController = TextEditingController(
      text: 'smitha');
  TextEditingController lastNameController = TextEditingController(text: 'raj');
  TextEditingController addressController = TextEditingController(
      text: '123 Street, peenya,banglore');

  File? _selectedImage;

  String? gender;

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Choose Image Source"),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final image = await ImagePicker().pickImage(
                    source: ImageSource.camera);
                if (image != null) {
                  setState(() {
                    _selectedImage = File(image.path);
                  });
                }
              },
              child: const ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _selectedImage = File(image.path);
                  });
                }
              },
              child: const ListTile(
                leading: Icon(Icons.image),
                title: Text("Gallery"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.editPatients.getString(context),
            style: const TextStyle(color: Colors.white),),
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: 75,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocale.editPatientsDetails.getString(context),
                    style: const TextStyle(
                        color: AppColors.fontShadeColor, fontSize: 13),),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      _showImageSourceDialog(context);
                    },
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
                                      onPressed: () {
                                        _showImageSourceDialog(context);
                                      },
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        size: 15,
                                      ),
                                      color: Colors.white))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(AppLocale.mobile.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocale.validPhone.getString(context);
                      }
                      return null;
                    },
                    controller: mobileController,
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
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor),
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
                  Text(AppLocale.email.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocale.validEmail.getString(context);
                      }
                      return null;
                    },
                    controller: emailController,
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
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocale.dateOfBirth.getString(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
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
                                  dobController.text =
                                  "${picked!.day} / ${picked.month} / ${picked
                                      .year}";
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
                                    borderSide: const BorderSide(
                                        color: Color(0xffD3D3D3)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryColor),
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
                                  hintText: AppLocale.dateOfBirth.getString(
                                      context),
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

                  const SizedBox(height: 10,),

                  Text(AppLocale.firstName.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocale.validFirstName.getString(context);
                      }
                      return null;
                    },
                    controller: firstNameController,
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
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor),
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
                  Text(AppLocale.lastName.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocale.validLastName.getString(context);
                      }
                      return null;
                    },
                    controller: lastNameController,
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
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor),
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
                  Text(AppLocale.gender.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    hint: Text(AppLocale.selectGender.getString(context)),
                    value: gender,
                    onChanged: (String? value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    items: <String>[
                      AppLocale.male.getString(context),
                      AppLocale.female.getString(context)
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 10,),
                  Text(AppLocale.address.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocale.validAddress.getString(context);
                      }
                      return null;
                    },
                    controller: addressController,
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
                        borderSide: const BorderSide(
                            color: AppColors.primaryColor),
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
                  getPrimaryAppButton(
                      context, AppLocale.submit.getString(context),
                      onPressed: ()async {
                        Navigator.pushNamed(
                            context, Routes.patientDetailsRoute);
                      }),
                ],
              ),
            ),
          ),
        )
    );
  }
}
