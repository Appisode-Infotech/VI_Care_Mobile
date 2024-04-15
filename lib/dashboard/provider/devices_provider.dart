import 'package:flutter/cupertino.dart';
import 'package:vicare/dashboard/model/device_delete_response_model.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';

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
  Future<DurationResponseModel>? allDurations;

  clearDevicePopUp() {
    serialNumberController.clear();
    deviceType = null;
    notifyListeners();
  }


  //duration page declarations

  getAllDuration() async {
    allDurations = apiCalls.getAllDurations();
  }

  Future<DeviceResponseModel>getMyDevices() {
    return apiCalls.getMyDevices();
  }

  Future<void> deleteDevice(int? userAndDeviceId, BuildContext context) async {
    showLoaderDialog(context);
    DeviceDeleteResponseModel response = await apiCalls.deleteMyDevice(userAndDeviceId,context);
    if(response.result!=null){
      Navigator.pop(context);
      showSuccessToast(context, response.message!);
      notifyListeners();
    }else{
      Navigator.pop(context);
      showErrorToast(context, response.message!);
      notifyListeners();
    }
  }
}
