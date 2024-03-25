import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_locale.dart';

class TakeTestProvider extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isConnected = false;
  bool bluetoothStatus = false;
  Timer? _timer;
  bool isScanning = false;
  List<BluetoothDevice> leDevices = [];
  BluetoothDevice? connectedDevice;
  int? heartRate = 0;

  void listenToConnectedDevice() {
    checkBluetoothStatus();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkBluetoothStatus();
    });
  }

  Future<void> connectToDevice(
      BluetoothDevice device, BuildContext context) async {
    showLoaderDialog(context);
    try {
      await device.connect();
      connectedDevice = device;
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

 checkBluetoothStatus() async {
    bool bluetoothOn = await flutterBlue.isOn;
    bluetoothStatus = bluetoothOn;
    if (bluetoothOn) {
      List<BluetoothDevice> connectedDevices =
          await flutterBlue.connectedDevices;
      if (connectedDevices.isNotEmpty) {
        isConnected = true;
        connectedDevice = connectedDevices[0];
      } else {
        isConnected = false;
        connectedDevice = null;
      }
    } else {
      isConnected = false;
      connectedDevice = null;
    }
    notifyListeners();
  }

  Future<void> scanLeDevices(String scanType) async {
    isScanning = true;
    if (scanType != '1') {
      notifyListeners();
    }
    leDevices.clear();
    try {
      await flutterBlue.startScan(timeout: const Duration(seconds: 5));
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
        await connectedDevice!.disconnect();
        showSuccessToast(
            context, AppLocale.deviceDisconnected.getString(context));
        log('Disconnected from device');
      } catch (e) {
        log('Error disconnecting from device: $e');
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
