import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';
import 'package:vicare/utils/app_buttons.dart';

class NewTestLeProvider extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;


  Future<void> connectToDevice(void Function(bool isConnected) onConnectionResult, Device? selectedDevice, BuildContext consumerContext) async {
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
        showSuccessToast(consumerContext, "Connected to ${device.name}");
        return;
      } else {
        onConnectionResult(false);
        showErrorToast(consumerContext, "Device not in range. Please ensure that the device is powered on, worn, and ready to connect");
        return;
      }
    } catch (e) {
      onConnectionResult(false);
      showErrorToast(consumerContext, "Could not connect: $e");
      return;
    }
  }
}
