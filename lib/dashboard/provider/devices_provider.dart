import 'package:flutter/cupertino.dart';
import 'package:vicare/dashboard/model/add_device_response_model.dart';

import '../../network/api_calls.dart';
import '../../utils/app_buttons.dart';
import '../model/duration_response_model.dart';

class DeviceProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  //device page declaration
  final deviceFormKey = GlobalKey<FormState>();
  String? deviceType;
  TextEditingController serialNumberController = TextEditingController();
  BuildContext? devicePageContext;

  clearDevicePopUp() {
    serialNumberController.clear();
    deviceType = null;
    notifyListeners();
  }

  addDevice() async {
    AddDeviceResponseModel response = await apiCalls.addDevice(
        deviceType!, serialNumberController.text, devicePageContext!);
    if (response.result != null) {
      showSuccessToast(devicePageContext!, response.message!.toString());
      Navigator.pop(devicePageContext!);
      Navigator.pop(devicePageContext!);
    }
  }

  //duration page declarations

  Future<DurationResponseModel> getAllDuration() async {
    return await apiCalls.getAllDurations();
  }
}
