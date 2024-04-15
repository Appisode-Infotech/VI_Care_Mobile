import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_locale.dart';

import '../../network/api_calls.dart';
import '../model/device_data_response_model.dart';

class TakeTestProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isConnected = false;
  bool bluetoothStatus = false;

  // Timer? _timer;
  bool isScanning = false;
  List<BluetoothDevice> leDevices = [];
  BluetoothDevice? connectedDevice;
  int? heartRate = 0;
  StreamSubscription? _bluetoothStateSubscription;

  void listenToConnectedDevice() {
    _bluetoothStateSubscription =
        flutterBlue.state.listen((BluetoothState state) async {
      bluetoothStatus = state == BluetoothState.on;
      if (!bluetoothStatus) {
        isConnected = false;
        connectedDevice = null;
      } else {
        flutterBlue.connectedDevices.then((List<BluetoothDevice> devices) {
          if (devices.isNotEmpty) {
            connectedDevice = devices.first;
            isConnected = true;
          } else {
            isConnected = false;
            connectedDevice = null;
          }
        });
      }
      notifyListeners();
    });
  }

  Future<void> connectToDevice(
      BluetoothDevice device, BuildContext context) async {
    showLoaderDialog(context);
    try {
      await device.connect();
      connectedDevice = device;
      isConnected = true;
      Navigator.pop(context); // Dismiss the loader
      Navigator.pop(context); // Back to test screen
      showSuccessToast(context,
          "${AppLocale.connectedTo.getString(context)} ${device.name}");
    } catch (e) {
      Navigator.pop(context); // Dismiss the loader
      showErrorToast(context,
          '${AppLocale.errorConnecting.getString(context)} ${device.name}: $e');
    }
  }

  // void _checkBluetoothStatus() async {
  //   bool bluetoothOn = await flutterBlue.isOn;
  //   bluetoothStatus = bluetoothOn;
  //   if (bluetoothOn) {
  //     List<BluetoothDevice> connectedDevices =
  //         await flutterBlue.connectedDevices;
  //     if (connectedDevices.isNotEmpty) {
  //       isConnected = true;
  //       connectedDevice = connectedDevices[0];
  //     } else {
  //       isConnected = false;
  //       connectedDevice = null;
  //     }
  //   } else {
  //     isConnected = false;
  //     connectedDevice = null;
  //   }
  //   notifyListeners();
  // }

  Future<void> scanLeDevices(String scanType) async {
    isScanning = true;
    if (scanType != '1') {
      notifyListeners();
    }
    leDevices.clear();
    try {
      // await flutterBlue.startScan(timeout: const Duration(seconds: 5));
      flutterBlue.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (!leDevices.contains(result.device) &&
              result.device.type == BluetoothDeviceType.le) {
            leDevices.add(result.device);
          }
        }
      });
      isScanning = false;
      notifyListeners();
    } catch (e) {
      isScanning = false;
      notifyListeners();
      log('Error scanning for devices: $e');
    }
  }

  Future<void> disconnect(BuildContext context) async {
    if (connectedDevice != null) {
      try {
        bool disconnectConfirmed = await showDisconnectWarningDialog(context);
        if (disconnectConfirmed) {
          await connectedDevice!.disconnect().then((value) {
            print(value);
            connectedDevice = null;
            isConnected = false;
            notifyListeners();
            return null;
          });
          isConnected = false;
          connectedDevice = null;
          showSuccessToast(
              context, AppLocale.deviceDisconnected.getString(context));
          log('Disconnected from device');
        } else {
          print('Disconnect cancelled by user');
        }
      } catch (e) {
        log('Error disconnecting from device: $e');
      }
    }
  }

  @override
  void dispose() {
    _bluetoothStateSubscription?.cancel();
    super.dispose();
  }

  requestDeviceData(BuildContext dataContext, File payload) async {
    DeviceDataResponseModel response = await
    apiCalls.requestDeviceData(
      context: dataContext,
      details: "abc",
        fileType: "ecg",
        durationName: prefModel.selectedDuration!.name,
        deviceSerialNumber:"4050023853",
        ipAddress:"1234567890",
        userAndDeviceId: "1234",
        subscriberGuid: "1234567",
        deviceId: "1234",
        durationId:prefModel.selectedDuration!.id,
        userId:prefModel.userData!.id,
        roleId:prefModel.userData!.roleId,
        individualProfileId:prefModel.userData!.roleId==2?prefModel.userData!.individualProfileId:prefModel.userData!.enterpriseUserId,
        enterpriseProfileId:prefModel.userData!.roleId==2?prefModel.userData!.individualProfileId:prefModel.userData!.enterpriseUserId,
        uploadFile: payload
    );
    print("case2");
    if (response.result != null) {
      showSuccessToast(dataContext, "Test successful and saved to offline.");
    } else {
      Navigator.pop(dataContext!);
    }
  }
}
