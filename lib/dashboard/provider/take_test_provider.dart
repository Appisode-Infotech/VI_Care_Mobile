import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vicare/dashboard/model/add_device_response_model.dart';
import 'package:vicare/dashboard/model/reports_detail_model.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_locale.dart';

import '../../network/api_calls.dart';
import '../../utils/app_colors.dart';
import '../model/detailed_report_ddf_model.dart';
import '../model/device_data_response_model.dart';
import '../model/my_reports_response_model.dart';

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
  final addDeviceFormKey = GlobalKey<FormState>();

  TextEditingController serialNumberController = TextEditingController();
  List<StreamSubscription> subscriptions = [];
  DetailedReportPdfModel? documentResp;
  ReportUser? reportUserData;

  void listenToConnectedDevice() {
    _bluetoothStateSubscription =
        flutterBlue.state.listen((BluetoothState state) async {
      bluetoothStatus = state == BluetoothState.on;
      if (!bluetoothStatus) {
        isConnected = false;
        connectedDevice = null;
        for (var subscription in subscriptions) {
          subscription.cancel(); // cancel all subscriptions
        }
      } else {
        flutterBlue.connectedDevices.then((List<BluetoothDevice> devices) {
          if (devices.isNotEmpty) {
            connectedDevice = devices.first;
            isConnected = true;
          } else {
            isConnected = false;
            connectedDevice = null;
            for (var subscription in subscriptions) {
              subscription.cancel(); // cancel all subscriptions
            }
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
      showSuccessToast(context, "${AppLocale.connectedTo.getString(context)} ${device.name}");
    } catch (e) {
      Navigator.pop(context); // Dismiss the loader
      showErrorToast(context,
          '${AppLocale.errorConnecting.getString(context)} ${device.name}: $e');
    }
  }

  Future<void> connectDeviceToAdd(
      BluetoothDevice device, BuildContext context) async {
    showLoaderDialog(context);
    try {
      await device.connect();
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        if (service.uuid.toString() == "0000180d-0000-1000-8000-00805f9b34fb") {
          Navigator.pop(context); // Dismiss the loader
          askDeviceDetails(context, device);
        }
      }
      device.disconnect();
    } catch (e) {
      Navigator.pop(context); // Dismiss the loader
      showErrorToast(context,
          '${AppLocale.errorConnecting.getString(context)} ${device.name}: $e');
    }
  }

  askDeviceDetails(BuildContext oldContext, BluetoothDevice device) {
    showDialog(
        context: oldContext,
        builder: (BuildContext dialogContext) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              title:  Text(AppLocale.addDeviceDetails.getString(dialogContext)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       Text(
                        "${AppLocale.deviceName.getString(dialogContext)}: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(device.name),
                    ],
                  ),
                   Row(
                    children: [
                      Text(
                        "${AppLocale.deviceManufacturer.getString(dialogContext)} : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(AppLocale.smartLab.getString(dialogContext)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(AppLocale.serialNumber.getString(dialogContext)),
                  Form(
                    key: addDeviceFormKey,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: serialNumberController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocale.enterSNumber.getString(dialogContext);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: AppLocale.serialNumber.getString(dialogContext),
                        counterText: "",
                        isCollapsed: true,
                        errorStyle: const TextStyle(color: Colors.red),
                        errorMaxLines: 2,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      Navigator.pop(oldContext);
                    },
                    child: Text(AppLocale.close.getString(dialogContext))),
                TextButton(
                    onPressed: () async {
                      if (addDeviceFormKey.currentState!.validate()) {
                        showLoaderDialog(dialogContext);
                        AddDeviceResponseModel res = await apiCalls.addDevice(
                            device.name,
                            device.id.id,
                            "le",
                            serialNumberController.text,
                            dialogContext,
                            oldContext);
                        serialNumberController.clear();
                        Navigator.pop(dialogContext);
                        Navigator.pop(oldContext);
                        Navigator.pop(oldContext);
                        if(res.result==null){
                          showErrorToast(oldContext, res.message!);
                        }else{
                          showSuccessToast(oldContext, res.message!);
                        }
                      }
                    },
                    child:  Text(AppLocale.proceedToAdd.getString(dialogContext))),
              ],
            ),
          );
        });
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

  Future<void> disconnect(BuildContext context, bool isTimerRunning,
      Null Function(bool val) disconnected) async {
    if (connectedDevice != null) {
      if (isTimerRunning) {
        try {
          bool disconnectConfirmed = await showDisconnectWarningDialog(context);
          if (disconnectConfirmed) {
            await connectedDevice!.disconnect().then((value) {
              connectedDevice = null;
              isConnected = false;
              notifyListeners();
              return null;
            });
            for (var subscription in subscriptions) {
              subscription.cancel(); // cancel all subscriptions
            }
            isConnected = false;
            connectedDevice = null;
            disconnected(true);
            showSuccessToast(
                context, AppLocale.deviceDisconnected.getString(context));
            log('Disconnected from device');
          } else {
            disconnected(false);
            log('Disconnect cancelled by user');
          }
        } catch (e) {
          for (var subscription in subscriptions) {
            subscription.cancel(); // cancel all subscriptions
          }
          disconnected(false);
          log('Error disconnecting from device: $e');
        }
      } else {
        await connectedDevice!.disconnect().then((value) {
          connectedDevice = null;
          isConnected = false;
          notifyListeners();
          disconnected(true);
          return null;
        });
        for (var subscription in subscriptions) {
          subscription.cancel(); // cancel all subscriptions
        }
        isConnected = false;
        connectedDevice = null;
        showSuccessToast(
            context, AppLocale.deviceDisconnected.getString(context));
      }
    }
  }

  @override
  void dispose() {
    _bluetoothStateSubscription?.cancel();
    super.dispose();
  }

  requestDeviceData(BuildContext dataContext, File payload,
      String? deviceSerialNo, int? userAndDeviceId, String deviceId) async {
    showLoaderDialog(dataContext);
    // DeviceDataResponseModel response = await
    DeviceDataResponseModel response = await apiCalls.requestDeviceData(
        context: dataContext,
        details: "abc",
        fileType: "1",
        // durationName: prefModel.selectedDuration!.name,
        deviceSerialNumber: deviceSerialNo!,
        ipAddress: "192.168.0.1",
        userAndDeviceId: userAndDeviceId.toString(),
        subscriberGuid: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        deviceId: deviceId,
        // durationId: prefModel.selectedDuration!.id,
        userId: prefModel.userData!.id,
        roleId: prefModel.userData!.roleId,
        individualProfileId: prefModel.userData!.individualProfileId,
        enterpriseProfileId: prefModel.userData!.enterpriseUserId,
        uploadFile: payload);
    Navigator.pop(dataContext);
    if (response.result != null) {
      showSuccessToast(dataContext, AppLocale.testSuccessSendHRV);
    }
  }

  Future<MyReportsResponseModel>? myReports;
  getMyReports(String? reportTime, String? reportStatus) async {
   myReports = apiCalls.getMyReports(reportTime,reportStatus);
  }

  Future<MyReportsResponseModel>getMyReportsWithFilter(String? reportTime, String? reportStatus) async {
    return apiCalls.getMyReports(reportTime,reportStatus);
  }

  Future<ReportsDetailModel> getReportDetails(int? requestDeviceDataId, BuildContext context) async {
    documentResp = await apiCalls.getReportPdf(requestDeviceDataId,context);
    for(int i = 0;i<documentResp!.result!.length;i++){
      if(documentResp!.result![i].fileType==2){
        reportUserData = documentResp!.result![i].requestDeviceData!.user;
      }
    }

    return await apiCalls.getReport(requestDeviceDataId,context);
  }
  downloadReportPdf(String url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
