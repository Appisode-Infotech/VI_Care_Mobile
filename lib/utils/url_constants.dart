class UrlConstants{
  static const String apiBaseUrl = "http://103.208.228.42:8054/api/";
  static const String sendOtpToRegister = "${apiBaseUrl}Account/SendOtp/";
  static const String getRoleMaster = "${apiBaseUrl}Role";
  static const String registerUser = "${apiBaseUrl}Account/Registration";
  static const String loginUser = "${apiBaseUrl}Account/LogIn";
  static const String sendOtpToResetPassword = "${apiBaseUrl}Account/ForgotPasword/";
  static const String resetPassword = "${apiBaseUrl}Account/ResetPassword/";
  static const String addIndividualProfile = "${apiBaseUrl}IndividualProfile";
}