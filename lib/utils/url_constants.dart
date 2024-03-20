class UrlConstants {
  static const String imageBaseUrl = "http://103.208.228.42:8054/";
  static const String apiBaseUrl = "http://103.208.228.42:8054/api/";
  static const String sendOtpToRegister = "${apiBaseUrl}Account/SendOtp/";
  static const String getRoleMaster = "${apiBaseUrl}Role";
  static const String registerUser = "${apiBaseUrl}Account/Registration";
  static const String loginUser = "${apiBaseUrl}Account/LogIn";
  static const String sendOtpToResetPassword =
      "${apiBaseUrl}Account/ForgotPassword/";
  static const String resetPassword = "${apiBaseUrl}Account/ResetPassword";
  static const String addIndividualProfile = "${apiBaseUrl}IndividualProfile";
  static const String addEnterpriseProfile = "${apiBaseUrl}EnterpriseProfile";
  static const String getIndividualProfiles = "${apiBaseUrl}IndividualProfile";
  static const String getEnterpriseProfiles = "${apiBaseUrl}EnterpriseProfile";
  static const String userAndDevice = "${apiBaseUrl}UserAndDevice";
  static const String getAllDurations = "${apiBaseUrl}Duration";
  static const String updateProfile = "${apiBaseUrl}user";
}
