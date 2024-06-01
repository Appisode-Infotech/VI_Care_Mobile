import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';
import 'package:vicare/main.dart';
import 'package:vicare/network/api_calls.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../../database/app_pref.dart';
import '../../utils/app_locale.dart';
import '../model/device_data_response_model.dart';
import '../model/offline_test_model.dart';

class NewTestLeProvider extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;
  ApiCalls apiCalls = ApiCalls();



  Future<void> connectToDevice(void Function(bool isConnected) onConnectionResult, Device? selectedDevice, BuildContext consumerContext) async {
    if(await flutterBlue.isOn){
      showLoaderDialog(consumerContext);
      for(var device in await flutterBlue.connectedDevices){
        await device.disconnect();
      }
      connectedDevice = null;
      try {
        List<ScanResult> scanResults = await flutterBlue.scan(timeout: const Duration(seconds: 5)).toList();
        BluetoothDevice? device;
        for (var result in scanResults) {
          if (result.device.id.id == selectedDevice!.deviceKey) {
            device = result.device;
            break;
          }
        }
        if (device != null) {
          await device.connect(autoConnect: false);
          connectedDevice = device;
          onConnectionResult(true);
          showSuccessToast(consumerContext, "${AppLocale.connectedTo.getString(consumerContext)}: ${device.name}");
          return;
        } else {
          onConnectionResult(false);
          showErrorToast(consumerContext, AppLocale.deviceNotInTheRange.getString(consumerContext));
          return;
        }
      } catch (e) {
        onConnectionResult(false);
        showErrorToast(consumerContext,"${AppLocale.couldNotConnect.getString}: $e");
        return;
      }
    }else{
      showErrorToast(consumerContext, AppLocale.bluetoothOffTurn.getString(consumerContext));
    }
  }

  requestDeviceData(BuildContext dataContext, File payload, String? deviceSerialNo, int? userAndDeviceId, String deviceId, int? durationId, String? durationName, String pId, Map<String, Object?> jsonData) async {
    DeviceDataResponseModel response = await apiCalls.requestDeviceData(
        context: dataContext,
        details: "abc",
        fileType: "1",
        durationName: durationName,
        deviceSerialNumber: deviceSerialNo!,
        ipAddress: "192.168.0.1",
        userAndDeviceId: userAndDeviceId.toString(),
        subscriberGuid: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        deviceId: deviceId,
        durationId: durationId,
        userId: prefModel.userData!.id,
        roleId: prefModel.userData!.roleId,
        pId: pId,
        uploadFile: payload);
    Navigator.pop(dataContext);
    if (response.result != null) {
      showSuccessToast(dataContext, AppLocale.testSuccessSendHRV.getString(dataContext));
    }else{
      showErrorToast(dataContext, response.message!);
            final String jsonString = json.encode(jsonData);
            OfflineTestModel testDetails = OfflineTestModel.fromJson(json.decode(jsonString));
            prefModel.offlineSavedTests!.add(testDetails);
            await AppPref.setPref(prefModel);
            showSuccessToast(dataContext,
                AppLocale.testSavedOffline.getString(dataContext));
            // Navigator.pop(dataContext);
    }
  }

}
