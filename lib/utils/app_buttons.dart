import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:vicare/create_patients/model/enterprise_response_model.dart';
import 'package:vicare/create_patients/model/individual_response_model.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';
import 'package:vicare/dashboard/model/duration_response_model.dart';
import 'package:vicare/dashboard/provider/new_test_le_provider.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';
import 'package:vicare/utils/routes.dart';

getPrimaryAppButton(BuildContext context, String label,
    {required Future<Null> Function() onPressed, Color? buttonColor}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 3,
      backgroundColor: buttonColor ?? AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child: SizedBox(
      // margin: const EdgeInsets.symmetric(horizontal: 2),
      width: screenSize!.width,
      height: 50,
      // decoration: BoxDecoration(
      //     color: buttonColor ?? AppColors.primaryColor,
      //     borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
          child: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      )),
    ),
  );
}

showLanguageBottomSheet(
    BuildContext context, Function(String languageCode) onLanguageChange) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: screenSize!.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                 Text(
                  AppLocale.selectLanguage.getString(context),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemCount: localization.supportedLanguageCodes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          onLanguageChange(
                              localization.supportedLanguageCodes[index]);
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${localization.getLanguageName(languageCode: localization.supportedLanguageCodes[index].toString())} - ${localization.supportedLanguageCodes[index]} ",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                localization.supportedLanguageCodes[index] ==
                                        localization.currentLocale!.languageCode
                                    ? const Icon(
                                        Icons.check,
                                        color: AppColors.primaryColor,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    }),
              ],
            ),
          ),
        );
      });
}

void showImageSourceDialog(BuildContext context,
    {required Future<Null> Function(dynamic value) onOptionSelected}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title:  Text(AppLocale.chooseImageSource.getString(context)),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () async {
              onOptionSelected(AppLocale.camera.getString(context));
              Navigator.pop(context);
            },
            child:  ListTile(
              leading: const Icon(Icons.camera),
              title: Text(AppLocale.camera.getString(context)),
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              onOptionSelected(AppLocale.gallery.getString(context));
              Navigator.pop(context);
            },
            child:  ListTile(
              leading: const Icon(Icons.image),
              title: Text(AppLocale.gallery.getString(context)),
            ),
          ),
        ],
      );
    },
  );
}

bool isToastShowing = false;
late Timer _toastTimer;

void showSuccessToast(BuildContext context, String content) {
  if (!isToastShowing) {
    isToastShowing = true;
  toastification.show(
    context: context, // optional if you use ToastificationWrapper
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 5),
    title: const Text("Success"),
    // you can also use RichText widget for title and description parameters
    description: RichText(text: TextSpan(text: content)),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    icon: const Icon(Icons.check),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
  );
    _toastTimer = Timer(const Duration(seconds: 5), () {
      isToastShowing = false;
    });
  }
}

void showErrorToast(BuildContext context, String content) {
  if (!isToastShowing) {
    isToastShowing = true;
    toastification.show(
      context: context,
      // optional if you use ToastificationWrapper
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text("Error"),
      // you can also use RichText widget for title and description parameters
      description: RichText(text: TextSpan(text: content)),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.error_outline),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
    _toastTimer = Timer(const Duration(seconds: 5), () {
      isToastShowing = false;
    });
  }
}

void showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => PopScope(
      canPop: true,
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset('assets/lottie/loading.json'),
            ),
            const SizedBox(height: 8),
             Text(
             AppLocale.loading.getString(context),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<CroppedFile?> cropImage(String imagePath) async {
  CroppedFile? croppedImage;
  try {
    croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: AppColors.primaryColor,
          toolbarTitle: AppLocale.cropImage,
          statusBarColor: AppColors.primaryColor,
          backgroundColor: Colors.white,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
    );
  } catch (e) {
    log('Error cropping image: $e');
  }
  return croppedImage;
}

Future<bool> showDisconnectWarningDialog(BuildContext context) async {
  bool result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(AppLocale.disconnectConfirm.getString(context)),
          backgroundColor: Colors.white,
          content: Text(AppLocale.disconnectMessage.getString(context)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(AppLocale.disconnect.getString(context),
                    style: const TextStyle(color: Colors.red))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(AppLocale.continueTest.getString(context),
                    style: const TextStyle(color: Colors.green)))
          ],
        );
      });
  return result; // Default to false if result is null
}

Future<bool> showStopTestWarningDialog(BuildContext context) async {
  bool result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(AppLocale.abortConfirm.getString(context)),
          backgroundColor: Colors.white,
          content: Text(AppLocale.abortMessage.getString(context)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(AppLocale.abort.getString(context),
                    style: const TextStyle(color: Colors.red))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(AppLocale.continueTest.getString(context),
                    style: const TextStyle(color: Colors.green)))
          ],
        );
      });
  return result; // Default to false if result is null
}



Future<bool> showSaveTestDialog(BuildContext context) async {
  bool result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title:  Text(AppLocale.testCompleted.getString(context)),
            backgroundColor: Colors.white,
            content:  Text(AppLocale.testNext.getString(context)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child:  const Text('Discard',
                      style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child:  Text(AppLocale.saveOffline.getString(context),
                      style: const TextStyle(color: Colors.green)))
            ],
          ),
        );
      });
  return result; // Default to false if result is null
}


showTestFormBottomSheet(BuildContext context, DeviceResponseModel myDevices, DurationResponseModel myDurations, IndividualResponseModel? individualPatientData, EnterpriseResponseModel? enterprisePatientData,) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bottomSheetContext) {
      final testFormKey = GlobalKey<FormState>();
      Device? selectedDevice;
      DurationClass? selectedDuration;

      return Consumer(
        builder: (BuildContext consumerContext, NewTestLeProvider newTestLeProvider, Widget? child) {
          return  SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: screenSize!.width,
              child: Form(
                key: testFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         FittedBox(
                           child: Text(
                            AppLocale.selectOption.getString(context),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                   ),
                         ),
                        IconButton(
                          onPressed: (){
                            Navigator.pop(bottomSheetContext);
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child:  Text(AppLocale.selectDevice.getString(context)),
                    ),
                    DropdownButtonFormField<Device>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return AppLocale.pleaseSelectDevice.getString(context);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocale.device.getString(context),
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
                        errorStyle: TextStyle(color: Colors.red.shade400),
                      ),
                      items: myDevices.result!.map((device) {
                        return DropdownMenuItem<Device>(
                          value: device.device,
                          child: Text("${device.device!.name} - ${device.device!.serialNumber}"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        selectedDevice = val;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child:  Text(AppLocale.selectDuration.getString(context)),
                    ),
                    DropdownButtonFormField<DurationClass>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return AppLocale.pleaseSelectDuration.getString(context);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: AppLocale.duration.getString(context),
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
                        errorStyle: TextStyle(color: Colors.red.shade400),
                      ),
                      items: myDurations.result!.map((duration) {
                        return DropdownMenuItem<DurationClass>(
                          value: duration,
                          child: Text(duration.name!),
                        );
                      }).toList(),
                      onChanged: (val) {
                        selectedDuration = val;
                      },
                    ),
                    Container(
                      width: screenSize!.width,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child:  Text(AppLocale.devicePoweredOn.getString(context)),
                    ),
                    getPrimaryAppButton(
                      context,
                      AppLocale.connect.getString(context),
                      onPressed: () async {
                        if (testFormKey.currentState!.validate()) {
                          if(selectedDevice!.deviceCategory==2){
                            newTestLeProvider.connectToDevice((bool isConnected) {
                              Navigator.pop(consumerContext);
                              Navigator.pop(bottomSheetContext);
                              if (isConnected) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.newTestLeRoute,
                                  arguments: {
                                    'individualPatientData': individualPatientData,
                                    'enterprisePatientData': enterprisePatientData,
                                    'selectedDuration': selectedDuration,
                                    'selectedDevice': selectedDevice
                                  },
                                );
                              }
                            },selectedDevice,consumerContext);
                          }else{
                            showErrorToast(context, AppLocale.deviceTypeNotSupported.getString(context));
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

showInfoDialog(BuildContext context,String message){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Close"))
      ],
    );
  });
}
