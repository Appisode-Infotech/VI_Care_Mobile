import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vicare/auth/model/send_otp_response_model.dart';
import 'package:vicare/create_patients/provider/profile_provider.dart';
import 'package:vicare/database/app_pref.dart';
import 'package:vicare/main.dart';

import '../../auth/model/register_response_model.dart';
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
  Future<RegisterResponseModel>? userData;
  bool eligibleToLoad = true;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ProfileProvider profileProvider,
          Widget? child) {
        if (eligibleToLoad) {
          userData = profileProvider.getUserProfile(context);
          eligibleToLoad = false;
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocale.profile.getString(context),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.primaryColor,
              toolbarHeight: 75,
              automaticallyImplyLeading: false,
            ),
            body: FutureBuilder(
              future: userData,
              builder: (BuildContext context,
                  AsyncSnapshot<RegisterResponseModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(children: [
                        Row(
                          children: [
                            prefModel.userData!.profilePicture != null
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.result!.profilePicture!.url
                                        .toString()),
                                  )
                                : const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data!.result!.contact!.firstName} ${snapshot.data!.result!.contact!.lastName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text('${snapshot.data!.result!.email}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 10),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.pushNamed(context, Routes.durationsRoute);
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Container(
                        //             padding: const EdgeInsets.all(6),
                        //             decoration: BoxDecoration(
                        //               color: Colors.teal.shade100,
                        //               borderRadius:
                        //                   const BorderRadius.all(Radius.circular(5)),
                        //             ),
                        //             child: const Icon(
                        //               Icons.settings_outlined,
                        //               color: AppColors.primaryColor,
                        //             ),
                        //           ),
                        //           const SizedBox(width: 10),
                        //           Text(
                        //             AppLocale.scanSettings.getString(context),
                        //             style: const TextStyle(
                        //                 fontSize: 15, fontWeight: FontWeight.w600),
                        //           ),
                        //         ],
                        //       ),
                        //       const Icon(
                        //         Icons.arrow_forward,
                        //         color: Colors.grey,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.devicesRoute);
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.device_hub_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.devices.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.offlineTestRoute);
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.cloud_off,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.offlineSaved.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            // await profileProvider.getCountryMaster(context);
                            await profileProvider.preFillEditProfile(context);
                            Navigator.pushNamed(
                                    context, Routes.editProfileRoute)
                                .then((value) {
                              setState(() {
                                eligibleToLoad = true;
                              });
                              return null;
                            });
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.editProfile.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            showLoaderDialog(context);
                            SendOtpResponseModel response =
                                await profileProvider.changePassword(context);
                            profileProvider.resetPasswordOtp =
                                response.result!.otp;
                            if (response.result != null) {
                              showSuccessToast(context, response.message!);
                            } else {
                              showErrorToast(context, response.message!);
                            }
                            profileProvider.changePasswordOtpController.clear();
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, Routes.changePasswordRoute);
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.lock_outline,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.changePassword.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            await showLanguageBottomSheet(
                                context, onLanguageChange);
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.language,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.changeLanguage.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url':
                                      "https://www.vcnrtech.in/ViCareterms.html",
                                  'title': AppLocale.termsAndConditions
                                      .getString(context),
                                });
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.description_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.termsConditions
                                        .getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.call_made,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url':
                                      "https://www.vcnrtech.in/ViCarePrivacyPolicy.html",
                                  'title': AppLocale.privacyPolicy
                                      .getString(context),
                                });
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.privacy_tip_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.privacyPolicy.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.call_made,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': "https://www.google.com",
                                  'title':
                                      AppLocale.newsBlog.getString(context),
                                });
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.newspaper,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.newsBlog.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.call_made,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrlString("tel://214324234");
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: const Icon(
                                      Icons.headset_mic_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    AppLocale.support.getString(context),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.call_made,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      AppLocale.confirmLogout
                                          .getString(context),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(AppLocale.sureLogout
                                        .getString(context)),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text(
                                          AppLocale.cancel.getString(context),
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Perform logout operation here
                                          prefModel.userData = null;
                                          // prefModel.offlineSavedTests!.clear();
                                          AppPref.setPref(prefModel);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  Routes.loginRoute,
                                                  (route) => false);
                                          showSuccessToast(
                                              context,
                                              AppLocale.logoutSuccess
                                                  .getString(context));
                                        },
                                        child: Text(
                                          AppLocale.logOut.getString(context),
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                width: screenSize!.width,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  AppLocale.logOut.getString(context),
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                )))),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "V 1.1.7",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                      child: Text(AppLocale.loading.getString(context)));
                }
              },
            ));
      },
    );
  }

  onLanguageChange(String languageCode) {
    localization.translate(languageCode);
  }
}
