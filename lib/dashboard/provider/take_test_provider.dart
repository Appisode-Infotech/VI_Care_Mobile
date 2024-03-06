import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class TakeTestProvider extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> leDevices = [];

  Future<Map> checkTestPreRequests() async {
    List<BluetoothDevice> connectedDevices = await checkIfConnectionExist();
    if (connectedDevices.isNotEmpty) {
      return {"status": true, "stage": 0};
    } else {
      return {"status": false, "stage": 1};
    }
  }

  checkAddedDevice() {
    return [];
  }

  Future<List<BluetoothDevice>> checkIfConnectionExist() async {
    return await flutterBlue.connectedDevices;
  }

  void scanForLEDevices() {
    flutterBlue.startScan(timeout: const Duration(seconds: 5));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!leDevices.contains(result.device)) {
          leDevices.add(result.device);
          notifyListeners();
        }
      }
    });
  }

  Future<void> connectToDevice(BluetoothDevice device, BuildContext context) async {
    try {
      await device.connect(autoConnect: true);
      notifyListeners();
      Navigator.pop(context);
      print('Connected to ${device.name}');
    } catch (e) {
      print('Error connecting to ${device.name}: $e');
    }
  }
}
