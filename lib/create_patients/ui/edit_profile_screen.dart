import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vicare/create_patients/provider/profile_provider.dart';
import 'package:vicare/main.dart';

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
                            if (value == AppLocale.camera.getString(context)) {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (image != null) {
                                CroppedFile? croppedImage =
                                    await cropImage(image.path);
                                if (croppedImage != null) {
                                  setState(() {
                                    profileProvider.editProfileSelectedImage =
                                        File(croppedImage.path);
                                  });
                                }
                              }
                            } else if (value ==
                                AppLocale.gallery.getString(context)) {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                CroppedFile? croppedImage =
                                    await cropImage(image.path);
                                if (croppedImage != null) {
                                  setState(() {
                                    profileProvider.editProfileSelectedImage =
                                        File(croppedImage.path);
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
                                              if (value ==
                                                  AppLocale.camera
                                                      .getString(context)) {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                if (image != null) {
                                                  CroppedFile? croppedImage =
                                                      await cropImage(
                                                          image.path);
                                                  if (croppedImage != null) {
                                                    setState(() {
                                                      profileProvider
                                                              .editProfileSelectedImage =
                                                          File(croppedImage
                                                              .path);
                                                    });
                                                  }
                                                }
                                              } else if (value ==
                                                  AppLocale.gallery
                                                      .getString(context)) {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (image != null) {
                                                  CroppedFile? croppedImage =
                                                      await cropImage(
                                                          image.path);
                                                  if (croppedImage != null) {
                                                    setState(() {
                                                      profileProvider
                                                              .editProfileSelectedImage =
                                                          File(croppedImage
                                                              .path);
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
                      Row(
                        children: [
                          Text(AppLocale.firstName.getString(context),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const Text(
                            ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller:
                            profileProvider.editProfileFirstNameController,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]')),
                        ],
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return AppLocale.validFirstName.getString(context);
                          }
                          // Additional validation if needed
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        maxLength: 74,
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
                      Row(
                        children: [
                          Text(AppLocale.lastName.getString(context),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const Text(
                            ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller:
                            profileProvider.editProfileLastNameController,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]')),
                        ],
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return AppLocale.validLastName.getString(context);
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        maxLength: 74,
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
                      Row(
                        children: [
                          Text(AppLocale.contactNumber.getString(context),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const Text(
                            ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller:
                            profileProvider.editProfileContactNumberController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                      Text(AppLocale.email.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocale.validEmail.getString(context);
                          }
                          if (profileProvider.isNotValidEmail(value)) {
                            return AppLocale.validEmail.getString(context);
                          }
                          return null;
                        },
                        controller: profileProvider.editProfileEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppLocale.email.getString(context),
                          hintStyle: const TextStyle(color: Colors.black),
                          counterText: "",
                          isCollapsed: true,
                          errorStyle: const TextStyle(color: Colors.red),
                          errorMaxLines: 2,
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
                      Row(
                        children: [
                          Text(AppLocale.bloodGroup.getString(context),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const Text(
                            ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          "B-ve",
                          "O-ve",
                          "A+ve",
                          "A-ve",
                          "B+ve",
                          "AB-ve"
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
                        children: [
                          Text(AppLocale.gender.getString(context),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const Text(
                            ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                ? 0
                                : 1;
                            profileProvider.editProfileGender = value!;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        items: <String>[
                          "Male",
                          "Female",
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                                width:screenSize!.width*.7,
                                child: Text(value)),
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
                                Row(
                                  children: [
                                    Text(
                                        AppLocale.dateOfBirth
                                            .getString(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    setState(() {
                                      profileProvider
                                              .editProfileDobController.text =
                                          DateFormat('dd-MM-yyyy')
                                              .format(picked!);
                                    });
                                  },
                                  child: TextFormField(
                                    // autovalidateMode:
                                    // AutovalidateMode.onUserInteraction,
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
                                  height: 10,
                                ),
                                prefModel.userData!.roleId == 2
                                    ? Text(AppLocale.height.getString(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600))
                                    : const SizedBox.shrink(),
                                prefModel.userData!.roleId == 2
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : const SizedBox.shrink(),
                                prefModel.userData!.roleId == 2
                                    ? TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: profileProvider
                                            .profileHeightController,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d*$')),
                                        ],
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: AppLocale.height
                                              .getString(context),
                                          counterText: "",
                                          isCollapsed: true,
                                          errorStyle: const TextStyle(
                                              color: Colors.red),
                                          errorMaxLines: 2,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 10),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                prefModel.userData!.roleId == 2
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : const SizedBox.shrink(),
                                prefModel.userData!.roleId == 2
                                    ? Text(AppLocale.weight.getString(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600))
                                    : const SizedBox.shrink(),
                                prefModel.userData!.roleId == 2
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : const SizedBox.shrink(),
                                prefModel.userData!.roleId == 2
                                    ? TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: profileProvider
                                            .profileWeightController,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d*\.?\d*$')),
                                        ],
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: AppLocale.weight
                                              .getString(context),
                                          counterText: "",
                                          isCollapsed: true,
                                          errorStyle: const TextStyle(
                                              color: Colors.red),
                                          errorMaxLines: 2,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 10),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                prefModel.userData!.roleId == 2
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : const SizedBox.shrink(),
                                Row(
                                  children: [
                                    Text(AppLocale.country.getString(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocale.validCountry
                                          .getString(context);
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade50,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16),
                                    focusColor: Colors.transparent,
                                    errorStyle:
                                        TextStyle(color: Colors.red.shade400),
                                  ),
                                  dropdownColor: Colors.white,
                                  value: profileProvider.editProfileCountryAs,
                                  hint: Text(
                                      AppLocale.country.getString(context)),
                                  onChanged: (String? value) async {
                                    var selectedCountry = profileProvider
                                        .countryMasterResponse!.result!
                                        .firstWhere(
                                            (country) => country.name == value);
                                    profileProvider
                                            .editProfileSelectedCountryId =
                                        selectedCountry.id;
                                    await profileProvider.getStateMaster(
                                        context, selectedCountry.uniqueGuid);
                                    setState(() {
                                      profileProvider.editProfileCountryAs =
                                          value!;
                                      profileProvider.editProfileStateAs = null;
                                    });
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  items: profileProvider
                                      .countryMasterResponse!.result!
                                      .map<DropdownMenuItem<String>>((country) {
                                    return DropdownMenuItem<String>(
                                      value: country.name,
                                      child: SizedBox(
                                          width:screenSize!.width*.7,
                                          child: Text(country.name.toString())),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(AppLocale.state.getString(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocale.stateValid
                                          .getString(context);
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade50,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16),
                                    focusColor: Colors.transparent,
                                    errorStyle:
                                        TextStyle(color: Colors.red.shade400),
                                  ),
                                  dropdownColor: Colors.white,
                                  value: profileProvider.editProfileStateAs,
                                  hint:
                                      Text(AppLocale.state.getString(context)),
                                  onChanged: (String? value) {
                                    var selectedState = profileProvider
                                        .editStateMasterResponse!.result!
                                        .firstWhere(
                                            (state) => state.name == value);

                                    profileProvider.editProfileSelectedStateId =
                                        selectedState.id;
                                    setState(() {
                                      profileProvider.editProfileStateAs =
                                          value!;
                                    });
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  items: profileProvider
                                          .editStateMasterResponse?.result
                                          ?.map<DropdownMenuItem<String>>(
                                              (state) {
                                        return DropdownMenuItem<String>(
                                          value: state.name,
                                          child: SizedBox(
                                            width:screenSize!.width*.7,

                                            child: Text(state.name.toString()),
                                          ),
                                        );
                                      }).toList() ??
                                      [],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(AppLocale.street.getString(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: profileProvider
                                      .editProfileStreetController,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return AppLocale.streetValid
                                  //         .getString(context);
                                  //   }
                                  //   return null;
                                  // },
                                  keyboardType: TextInputType.streetAddress,
                                  maxLength: 74,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText:
                                        AppLocale.street.getString(context),
                                    counterText: "",
                                    isCollapsed: true,
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    errorMaxLines: 2,
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(AppLocale.area.getString(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller:
                                      profileProvider.editProfileAreaController,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return AppLocale.areaValid
                                  //         .getString(context);
                                  //   }
                                  //   return null;
                                  // },
                                  keyboardType: TextInputType.streetAddress,
                                  maxLength: 74,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: AppLocale.area.getString(context),
                                    counterText: "",
                                    isCollapsed: true,
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    errorMaxLines: 2,
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(AppLocale.landMark.getString(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: profileProvider
                                      .editProfileLandMarkController,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return AppLocale.landMarkValid
                                  //         .getString(context);
                                  //   }
                                  //   return null;
                                  // },
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText:
                                        AppLocale.landMark.getString(context),
                                    counterText: "",
                                    isCollapsed: true,
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    errorMaxLines: 2,
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(AppLocale.city.getString(context),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    const Text(
                                      ' *',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller:
                                      profileProvider.editProfileCityController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocale.cityValid
                                          .getString(context);
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.streetAddress,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'^\s')),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z\s]')),
                                  ],
                                  maxLength: 74,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: AppLocale.city.getString(context),
                                    counterText: "",
                                    isCollapsed: true,
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    errorMaxLines: 2,
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(AppLocale.pinCode.getString(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: profileProvider
                                      .editProfilePinCodeController,
                                  validator: (value) {
                                    if (value!.isNotEmpty) {
                                      if (value.length < 4) {
                                        return AppLocale.pinCodeValid
                                            .getString(context);
                                      }
                                    }
                                    return null;
                                  },
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText:
                                        AppLocale.pinCode.getString(context),
                                    counterText: "",
                                    isCollapsed: true,
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    errorMaxLines: 2,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                getPrimaryAppButton(context,
                                    AppLocale.submit.getString(context),
                                    onPressed: () async {
                                  // if (profileProvider.editProfileSelectedImage == null) {
                                  //   showErrorToast(context, AppLocale.validImage.getString(context));
                                  //   return;
                                  // }
                                  profileProvider.editProfile();
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
