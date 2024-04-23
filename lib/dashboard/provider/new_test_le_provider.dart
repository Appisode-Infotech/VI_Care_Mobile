import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_locale.dart';

class NewTestLeProvider extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<void> connectToDevice(void Function(bool isConnected) onConnectionResult, Device? selectedDevice, BuildContext consumerContext) async {
    showLoaderDialog(consumerContext);
    try {
      await flutterBlue.startScan(timeout: Duration(seconds: 5));
      flutterBlue.scanResults.listen((results) async {
        for (ScanResult result in results) {
          if (selectedDevice!.deviceKey==result.device.id.id) {
            await result.device.connect();
            Navigator.pop(consumerContext); // Dismiss the loader
            onConnectionResult(true);
            return;
          }
        }
      });
    } catch (e) {
      Navigator.pop(consumerContext); // Dismiss the loader
      onConnectionResult(false);
      showErrorToast(consumerContext, '${AppLocale.errorConnecting.getString(consumerContext)} ${selectedDevice!.name}: $e');
    }
  }
}
