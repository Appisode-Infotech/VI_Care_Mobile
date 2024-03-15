import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vicare/create_patients/provider/profile_provider.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ProfileProvider profileProvider,
          Widget? child) {
        profileProvider.editProfilePageContext = context;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocale.editProfile.getString(context),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 75,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Form(
            key: profileProvider.editProfileFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showImageSourceDialog(context,
                              onOptionSelected: (value) async {
                            if (value == 'Camera') {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (image != null) {
                                File? croppedImage =
                                    await cropImage(image.path);
                                if (croppedImage != null) {
                                  setState(() {
                                    profileProvider.editProfileSelectedImage =
                                        croppedImage;
                                  });
                                }
                              }
                            } else if (value == 'Gallery') {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                File? croppedImage =
                                    await cropImage(image.path);
                                if (croppedImage != null) {
                                  setState(() {
                                    profileProvider.editProfileSelectedImage =
                                        croppedImage;
                                  });
                                }
                              }
                            }
                          });
                        },
                        child: Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage:
                                    profileProvider.editProfileSelectedImage !=
                                            null
                                        ? FileImage(profileProvider
                                            .editProfileSelectedImage!)
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
                                            showImageSourceDialog(context,
                                                onOptionSelected:
                                                    (value) async {
                                              if (value == 'Camera') {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                if (image != null) {
                                                  File? croppedImage =
                                                      await cropImage(
                                                          image.path);
                                                  if (croppedImage != null) {
                                                    setState(() {
                                                      profileProvider
                                                              .editProfileSelectedImage =
                                                          croppedImage;
                                                    });
                                                  }
                                                }
                                              } else if (value == 'Gallery') {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (image != null) {
                                                  File? croppedImage =
                                                      await cropImage(
                                                          image.path);
                                                  if (croppedImage != null) {
                                                    setState(() {
                                                      profileProvider
                                                              .editProfileSelectedImage =
                                                          croppedImage;
                                                    });
                                                  }
                                                }
                                              }
                                            });
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
                      Text(AppLocale.firstName.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller:
                            profileProvider.editProfileFirstNameController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocale.validFirstName.getString(context);
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppLocale.firstName.getString(context),
                          counterText: "",
                          isCollapsed: true,
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(AppLocale.lastName.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller:
                            profileProvider.editProfileLastNameController,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocale.validLastName.getString(context);
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppLocale.lastName.getString(context),
                          counterText: "",
                          isCollapsed: true,
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(AppLocale.contactNumber.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller:
                            profileProvider.editProfileContactNumberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocale.validContact.getString(context);
                          }
                          if (profileProvider.isNotValidContactNumber(value)) {
                            return AppLocale.validContact.getString(context);
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppLocale.contactNumber.getString(context),
                          hintStyle:
                              const TextStyle(fontSize: 15, color: Colors.grey),
                          counterText: "",
                          isCollapsed: true,
                          errorStyle: const TextStyle(color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(AppLocale.bloodGroup.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocale.validBloodGroup.getString(context);
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xffD3D3D3),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16),
                          focusColor: Colors.transparent,
                          errorStyle: TextStyle(color: Colors.red.shade400),
                        ),
                        dropdownColor: Colors.white,
                        hint: Text(AppLocale.bloodGroup.getString(context)),
                        value: profileProvider.editProfileBloodGroup,
                        onChanged: (String? value) {
                          setState(() {
                            profileProvider.editProfileBloodGroup = value!;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        items: <String>[
                          "O+ve",
                          "AB+ve",
                          "B+ve",
                          "O-ve",
                          "A+ve",
                          "A-ve"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(AppLocale.gender.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0xffD3D3D3),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16),
                          focusColor: Colors.transparent,
                        ),
                        dropdownColor: Colors.white,
                        hint: Text(AppLocale.selectGender.getString(context)),
                        value: profileProvider.editProfileGender,
                        onChanged: (String? value) {
                          setState(() {
                            profileProvider.selectedGender = value == "Male"
                                ? 1
                                : value == "Female"
                                    ? 2
                                    : value == "Do not wish to specify"
                                        ? 3
                                        : 0;
                            profileProvider.editProfileGender = value!;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        items: <String>[
                          "Male",
                          "Female",
                          "Do not wish to specify"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1026),
                                      lastDate: DateTime.now(),
                                    );
                                    setState(() {
                                      profileProvider
                                              .editProfileDobController.text =
                                          "${picked!.year} - ${picked.month} - ${picked.day}";
                                    });
                                  },
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enabled: false,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      errorMaxLines: 2,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      hintText: AppLocale.dateOfBirth
                                          .getString(context),
                                      fillColor: Colors.white,
                                    ),
                                    controller: profileProvider
                                        .editProfileDobController,
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                getPrimaryAppButton(context,
                                    AppLocale.submit.getString(context),
                                    onPressed: () async {
                                  profileProvider.editProfile();
                                  // Navigator.pushNamed(
                                  //     context, Routes.profileRoute);
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
