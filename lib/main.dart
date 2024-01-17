import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/routes.dart';
import 'package:vicare/dashboard/dashboard_screen.dart';
import 'package:vicare/dashboard/ui/home_screen.dart';

import 'WebViewScreen.dart';
import 'auth/ui/forgot_password_screen.dart';
import 'auth/ui/login_screen.dart';
import 'auth/ui/register_screen.dart';
import 'auth/ui/reset_password_screen.dart';
import 'onboarding/ui/onboarding_screen.dart';
import 'onboarding/ui/splash_screen.dart';

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
          Routes.onBoardingRoute: (context) => const OnboardingScreen(),
          Routes.dashboardRoute: (context) => const DashboardScreen(),
          Routes.loginRoute: (context) => const LoginScreen(),
          Routes.registerRoute: (context) => const RegisterScreen(),
          Routes.forgotPasswordRoute: (context) => const ForgotPasswordScreen(),
          Routes.resetPasswordRoute: (context) => const ResetPasswordScreen(),
          Routes.homeRoute: (context) => const HomeScreen(),
          Routes.webViewRoute: (context) => const WebViewScreen(),
          // Routes.managePatientsRoute: (context) => const ManagePatients(),
        }
    );
  }
}