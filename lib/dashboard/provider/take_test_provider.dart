import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
import '../model/my_reports_response_model.dart';

class TakeTestProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  FlutterBluePlus flutterBluePlus = FlutterBluePlus();
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

  Map? reportUserData;
  void listenToConnectedDevice() {
    _bluetoothStateSubscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
      bluetoothStatus = state == BluetoothAdapterState.on;
      if (!bluetoothStatus) {
        isConnected = false;
        connectedDevice = null;
        for (var subscription in subscriptions) {
          subscription.cancel();
        }
      } else {
        List devices = FlutterBluePlus.connectedDevices;
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
      showSuccessToast(context, "${AppLocale.connectedTo.getString(context)} ${device.platformName}");
    } catch (e) {
      Navigator.pop(context); // Dismiss the loader
      showErrorToast(context,
          '${AppLocale.errorConnecting.getString(context)} ${device.platformName}: $e');
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
          '${AppLocale.errorConnecting.getString(context)} ${device.platformName}: $e');
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
                      Text(device.platformName),
                    ],
                  ),
                   FittedBox(
                     child: Row(
                      children: [
                        Text(
                          "${AppLocale.deviceManufacturer.getString(dialogContext)} : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(AppLocale.smartLab.getString(dialogContext)),
                      ],
                                       ),
                   ),
                  const SizedBox(
                    height: 15,
                  ),
                   Text(AppLocale.serialNumber.getString(dialogContext)),
                  SizedBox(height: 5,),
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
                      serialNumberController.clear();
                      Navigator.pop(dialogContext);
                      Navigator.pop(oldContext);
                    },
                    child: Text(AppLocale.close.getString(dialogContext))),
                TextButton(
                    onPressed: () async {
                      if (addDeviceFormKey.currentState!.validate()) {
                        showLoaderDialog(dialogContext);
                        AddDeviceResponseModel res = await apiCalls.addDevice(
                            device.platformName,
                            device.remoteId.str,
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
    notifyListeners();
    leDevices.clear();

    try {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          final manufacturerData = result.advertisementData.manufacturerData;
          const companyId = 65292;
          if (manufacturerData.containsKey(companyId)) {
            if (!leDevices.any((r) {
              return r.remoteId.str == result.device.remoteId.str;
            })) {
              leDevices.add(result.device);
              notifyListeners();
            }
          }
        }
      },onDone: (){
        isScanning = false;
        notifyListeners();
      },onError: (var e){
        log(e.toString());
      }
      );
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

  Future<MyReportsResponseModel>? myReports;
  getMyReports(String? reportTime, String? reportStatus) async {
   myReports = apiCalls.getMyReports(reportTime,reportStatus,null);
  }

  Future<MyReportsResponseModel>getMyReportsWithFilter(String? reportTime, String? reportStatus, String? pId) async {
    return apiCalls.getMyReports(reportTime,reportStatus,pId);
  }

  Future<ReportsDetailModel> getReportDetails(int? requestDeviceDataId, BuildContext context) async {
    documentResp = await apiCalls.getReportPdf(requestDeviceDataId,context);
    for(int i = 0;i<documentResp!.result!.length;i++){
      if(prefModel.userData!.roleId==2){
        if(documentResp!.result![i].fileType==2){
          reportUserData = documentResp!.result![i].requestDeviceData!.individualProfile!.toJson();
        }
      }else{
        if(documentResp!.result![i].fileType==2){
          reportUserData = documentResp!.result![i].requestDeviceData!.enterpriseProfile!.toJson();
        }
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
