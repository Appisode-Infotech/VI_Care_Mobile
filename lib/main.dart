import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vicare/auth/ui/forgot_reset_password.dart';
import 'package:vicare/create_patients/ui/change_password_screen.dart';
import 'package:vicare/create_patients/ui/edit_patient_screen.dart';
import 'package:vicare/create_patients/ui/patient_details_screen.dart';
import 'package:vicare/dashboard/dashboard_screen.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/dashboard/ui/manage_patients_screen.dart';
import 'package:vicare/dashboard/ui/offline_test_screen.dart';
import 'package:vicare/dashboard/ui/profile_screen.dart';
import 'package:vicare/dashboard/ui/take_test_screen.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';
import 'package:vicare/utils/routes.dart';

import 'WebViewScreen.dart';
import 'auth/auth_provider.dart';
import 'auth/ui/login_screen.dart';
import 'auth/ui/register_screen.dart';
import 'create_patients/provider/patient_provider.dart';
import 'create_patients/provider/profile_provider.dart';
import 'create_patients/ui/add_new_patient_screen.dart';
import 'create_patients/ui/edit_profile_screen.dart';
import 'create_patients/ui/summary_screen.dart';
import 'dashboard/provider/devices_provider.dart';
import 'dashboard/ui/all_reports_screen.dart';
import 'dashboard/ui/bluetooth_scan_page.dart';
import 'dashboard/ui/devices_screen.dart';
import 'dashboard/ui/duration_screen.dart';
import 'database/app_pref.dart';
import 'database/models/pref_model.dart';
import 'onboarding/ui/on_boarding_screen.dart';
import 'onboarding/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.getInstance();
  runApp(
    const MyApp(),
  );
}

Size? screenSize;
PrefModel prefModel = AppPref.getPref();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final FlutterLocalization localization = FlutterLocalization.instance;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    prefModel.offlineSavedTests ??= [];
    localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.EN,
          countryCode: 'US',
          fontFamily: 'Font EN',
        ),
        const MapLocale(
          'kn',
          AppLocale.KN,
          countryCode: 'US',
          fontFamily: 'Font kn',
        ),
        const MapLocale(
          'hi',
          AppLocale.HI,
          countryCode: 'US',
          fontFamily: 'Font hi',
        ),
        const MapLocale(
          'de',
          AppLocale.de,
          countryCode: 'US',
          fontFamily: 'Font de',
        ),
        const MapLocale(
          'te',
          AppLocale.TE,
          countryCode: 'US',
          fontFamily: 'Font te',
        ),
        const MapLocale(
          'ta',
          AppLocale.TA,
          countryCode: 'US',
          fontFamily: 'Font ta',
        ),
        const MapLocale(
          'ml',
          AppLocale.ML,
          countryCode: 'US',
          fontFamily: 'Font ml',
        ),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => PatientProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ChangeNotifierProvider(create: (context) => DeviceProvider()),
          ChangeNotifierProvider(create: (context) => TakeTestProvider()),
        ],
        child: MaterialApp(
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
                bodyMedium:
                    GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
              ),
              primaryColor: AppColors.primaryColor,
              scaffoldBackgroundColor: AppColors.scaffoldColor,
            ),
            title: "Vi Care",
            initialRoute: Routes.splashRoute,
            routes: <String, WidgetBuilder>{
              Routes.splashRoute: (context) => const SplashScreen(),
              Routes.onBoardingRoute: (context) => const OnBoardingScreen(),
              Routes.dashboardRoute: (context) => const DashboardScreen(),
              Routes.loginRoute: (context) => const LoginScreen(),
              Routes.registerRoute: (context) => const RegisterScreen(),
              Routes.webViewRoute: (context) => const WebViewScreen(),
              Routes.addNewPatientRoute: (context) =>
                  const AddNewPatientScreen(),
              Routes.managePatientsRoute: (context) =>
                  const ManagePatientsScreen(),
              Routes.reportsRoute: (context) => const ReportScreen(),
              Routes.forgotResetPasswordRoute: (context) =>
                  const ForgotResetPassword(),
              Routes.patientDetailsRoute: (context) =>
                  const PatientDetailsScreen(),
              Routes.summaryRoute: (context) => const SummaryScreen(),
              Routes.takeTestRoute: (context) => const TakeTestScreen(),
              Routes.offlineTestRoute: (context) => const OfflineTestScreen(),
              Routes.editPatientsRoute: (context) => const EditPatientScreen(),
              Routes.editProfileRoute: (context) => const EditProfileScreen(),
              Routes.changePasswordRoute: (context) =>
                  const ChangePasswordScreen(),
              Routes.devicesRoute: (context) => const DeviceScreen(),
              Routes.profileRoute: (context) => const ProfileScreen(),
              Routes.durationsRoute: (context) => const DurationScreen(),
              Routes.bluetoothScanRoute: (context) => const BluetoothScanPage()
            }));
  }
}
