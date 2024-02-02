import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';
import '../../network/api_calls.dart';

class AuthController{
  PrefModel prefModel = AppPref.getPref();

  ApiCalls apiCalls = ApiCalls();

  bool isNotValidEmail(String email) {
    const emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(emailRegex);
    return !regExp.hasMatch(email);
  }


  bool isNotValidName(String name) {
    const nameRegex =
        r'^[a-zA-Z\s]+$'; // This regex allows letters and spaces only
    final regExp = RegExp(nameRegex);

    if (!regExp.hasMatch(name) || name.trim().isEmpty) {
      return true;
    }

    final containsNumbers = name.contains(RegExp(r'[0-9]'));
    return containsNumbers;
  }
}