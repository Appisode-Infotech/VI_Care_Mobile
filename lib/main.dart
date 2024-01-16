import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vicare/utils/appcolors.dart';
import 'package:vicare/routes.dart';
import 'package:vicare/view/dashboard_screens/dashboard_screen.dart';
import 'package:vicare/view/dashboard_screens/manage_patients_screen.dart';
import 'package:vicare/view/forgot_password_screen.dart';
import 'package:vicare/view/dashboard_screens/home_screen.dart';
import 'package:vicare/view/login_screen.dart';
import 'package:vicare/view/onboarding_screen.dart';
import 'package:vicare/view/register_screen.dart';
import 'package:vicare/view/reset_password_screen.dart';
import 'package:vicare/view/splash_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();

  runApp(
    // EasyLocalization(
    //   supportedLocales: [Locale('en')],
    //   path: 'assets/translations',
    //   fallbackLocale: Locale('en'),
    //   startLocale: await initializeDeviceLocale(),
    //   child:
      const MyApp(),
    // ),
  );
}

Size? screenSize;

// Future<Locale> initializeDeviceLocale() async {
//   return Future.value(Locale('en'));
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
        ),
        primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.scaffoldColor,
        ),
        title: "Vi Care",
        // localizationsDelegates: context.localizationDelegates,
        // supportedLocales: context.supportedLocales,
        // locale: context.locale,
        initialRoute: Routes.splashRoute,

        routes: <String, WidgetBuilder>{
          Routes.splashRoute: (context) => const SplashScreen(),
          Routes.onboardingRoute: (context) => const OnboardingScreen(),
          Routes.dashboardRoute: (context) => const DashboardScreen(),
          Routes.loginRoute: (context) => const LoginScreen(),
          Routes.registerRoute: (context) => const RegisterScreen(),
          Routes.forgotPasswordRoute: (context) => const ForgotPasswordScreen(),
          Routes.resetPasswordRoute: (context) => const ResetPasswordScreen(),
          Routes.homeRoute: (context) => const HomeScreen(),
          Routes.myPatientsRoute: (context) => const ManagePatients(),
        }
    );
  }
}