import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vicare/auth/ui/forgot_reset_password.dart';
import 'package:vicare/dashboard/dashboard_screen.dart';
import 'package:vicare/create_patients/ui/patient_details_screen.dart';
import 'package:vicare/dashboard/ui/manage_patients_screen.dart';
import 'package:vicare/dashboard/ui/take_test_screen.dart';
import 'package:vicare/dashboard/ui/offline_test_screen.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';
import 'package:vicare/utils/routes.dart';

import 'WebViewScreen.dart';
import 'create_patients/ui/add_new_patient_screen.dart';
import 'auth/ui/login_screen.dart';
import 'auth/ui/register_screen.dart';
import 'create_patients/ui/summary_screen.dart';
import 'dashboard/ui/all_reports_screen.dart';
import 'onboarding/ui/on_boarding_screen.dart';
import 'onboarding/ui/splash_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

Size? screenSize;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
final FlutterLocalization localization = FlutterLocalization.instance;

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
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

    return MaterialApp(
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
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
          Routes.addNewPatientRoute: (context) => const AddNewPatientScreen(),
          Routes.managePatientsRoute: (context) => const ManagePatientsScreen(),
          Routes.reportsRoute: (context) => const ReportScreen(),
          Routes.forgotResetPasswordRoute: (context) => const ForgotResetPassword(),
          Routes.patientDetailsRoute: (context) => const PatientDetailsScreen(),
          Routes.summaryRoute: (context) => const SummaryScreen(),
          Routes.takeTestRoute: (context) => const TakeTestScreen(),
          Routes.offlineTestRoute: (context) => const OfflineTestScreen(),
        });
  }
}
