import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class TakeTestProvider extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> leDevices = [];
  int heartRate = 0;

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

  // Future<void> connectToDevice(BluetoothDevice device, BuildContext context) async {
  //   try {
  //     await device.connect(autoConnect: true);
  //     notifyListeners();
  //     Navigator.pop(context);
  //     print('Connected to ${device.name}');
  //   } catch (e) {
  //     print('Error connecting to ${device.name}: $e');
  //   }
  // }

  Future<void> connectToDevice(BluetoothDevice device, BuildContext context) async {
    try {
      await device.connect(autoConnect: true);
      bluetoothListener(device);
      device.state.listen((BluetoothDeviceState state) {
        if (state == BluetoothDeviceState.disconnected) {
          connectToDevice(device, context);
        }
      });
      notifyListeners();
      Navigator.pop(context);
      print('Connected to ${device.name}');
    } catch (e) {
      print('Error connecting to ${device.name}: $e');
    }
  }

  Future<void> bluetoothListener(BluetoothDevice connectedDevice) async {
    try {
      List<BluetoothService> services = await connectedDevice.discoverServices();
      for (BluetoothService service in services) {
        if (service.uuid.toString() == "0000180d-0000-1000-8000-00805f9b34fb") {
          for (BluetoothCharacteristic characteristic in service.characteristics) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              if (value.isNotEmpty) {
                heartRate = value[1];
                print("Heart Rate: $heartRate");
              }
            });
          }
        }
      }
    } catch (e) {
      print('Error discovering services: $e');
    }
  }
}
