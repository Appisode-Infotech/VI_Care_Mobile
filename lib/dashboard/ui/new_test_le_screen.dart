import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/model/offline_test_model.dart';
import 'package:vicare/dashboard/provider/new_test_le_provider.dart';
import 'package:vicare/database/app_pref.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_buttons.dart';
import 'package:vicare/utils/app_colors.dart';

import '../../create_patients/model/enterprise_response_model.dart';
import '../../create_patients/model/individual_response_model.dart';
import '../../utils/app_locale.dart';
import '../model/device_response_model.dart';
import '../model/duration_response_model.dart';

class NewTestLeScreen extends StatefulWidget {
  const NewTestLeScreen({super.key});

  @override
  State<NewTestLeScreen> createState() => _NewTestLeScreenState();
}

class _NewTestLeScreenState extends State<NewTestLeScreen> {
  EnterpriseResponseModel? enterprisePatientData;
  IndividualResponseModel? individualPatientData;
  Device? selectedDevice;
  DurationClass? selectedDuration;
  bool isFirstTimeLoading = true;
  BluetoothDevice? connectedDevice;
  BluetoothDeviceState? deviceStatus;
  StreamSubscription? _bluetoothStateSubscription;
  BluetoothState? bluetoothState = BluetoothState.on;

  //timer declarations
  late Timer _timer;
  int elapsedSeconds = 0;
  int totalSeconds = 0;
  bool isRunning = false;

  //recordings declarations
  List<int> bpmList = [];
  List<int> rrIntervalList = [];
  int heartRate = 0;
  int energy = 0;
  List<StreamSubscription> subscriptions = [];
  List<FlSpot> rrIntervalChartData = [];

  @override
  void initState() {
    super.initState();
    // Subscribe to Bluetooth state changes
    _bluetoothStateSubscription =
        FlutterBlue.instance.state.listen((BluetoothState state) {
      setState(() {
        bluetoothState = state;
        // Reset device status when Bluetooth is turned off
        if (bluetoothState == BluetoothState.off) {
          connectedDevice = null;
          deviceStatus = null;
          isFirstTimeLoading = true;
          clearRecordingsData();
          _stopTimer();
        }
      });
    });
  }

  @override
  void dispose() async {
    for (var subscription in subscriptions) {
      subscription.cancel(); // Cancel each subscription
    }
    _bluetoothStateSubscription?.cancel();
    connectedDevice?.disconnect();
    clearRecordingsData();
    _stopTimer(); // Stop the timer here
    super.dispose();
  }

  void _startTimer(NewTestLeProvider newTestLeProvider) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (mounted) {
        // Check if the widget is still mounted
        if (elapsedSeconds < totalSeconds) {
          setState(() {
            elapsedSeconds++;
          });
        } else {
          stopTestRecording();
          _stopTimer();
          saveRecording(newTestLeProvider);
        }
      }
    });
    setState(() {
      isRunning = true;
    });
  }

  void _stopTimer() async {
    _timer.cancel();
    if (mounted) {
      setState(() {
        isRunning = false;
        elapsedSeconds = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    enterprisePatientData = arguments['enterprisePatientData'];
    individualPatientData = arguments['individualPatientData'];
    selectedDevice = arguments['selectedDevice'];
    selectedDuration = arguments['selectedDuration'];
    double progressPercent = elapsedSeconds / totalSeconds;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.takeTest.getString(context)),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(context: context, builder: (BuildContext infoSheetContext){
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("FAQ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                         GestureDetector(
                             onTap: (){
                               Navigator.pop(context);
                             },
                             child: Icon(Icons.close)),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Text("Throughout the day, your body is exposed to a flood of constantly changinng demands of a physical, psychological and social nature. The survival and functioning of your organism is closely dependent on its ability to adopt to the demands of acute stress phases on the one hand, and on the other hand to find a relaxed state of rest after these phases have subsided so that it can regenerate. With the autonomic nervous system(ANS), your organism has a highly effective regulatory system that is able to fulfill precisely this task autonomously (on its own) to the greatest possible extent. The Readyness Score is a summary parameter that evaluates your body's regulatory abilities. It tells you how well your body, with the help of the autonomic nervous system , is basically able to adjust to stress and to what extent this ability is being called upon at the time of the measurement. The Readyness Score shows you how well you can cope with your day."),
                   ],
                 )
                ),
              );
            });
          }, icon: Icon(Icons.info_outline_rounded))
        ],
      ),
      body: Consumer(
        builder: (BuildContext context, NewTestLeProvider newTestLeProvider,
            Widget? child) {
          if (isFirstTimeLoading) {
            connectedDevice = newTestLeProvider.connectedDevice;
            totalSeconds = selectedDuration!.durationInMinutes! * 60;
            newTestLeProvider.connectedDevice!.state.listen((state) {
              if (mounted) {
                // Check if the widget is still mounted
                if (state == BluetoothDeviceState.disconnected) {
                  clearRecordingsData();
                  _stopTimer();
                  // Await reset new test
                  newTestLeProvider.connectedDevice!.disconnect().then((_) {
                    if (mounted) {
                      setState(() {
                        deviceStatus = state;
                      });
                    }
                  });
                } else {
                  if (mounted) {
                    setState(() {
                      deviceStatus = state;
                    });
                  }
                }
              }
            });
            isFirstTimeLoading = false;
          }
          if (deviceStatus == BluetoothDeviceState.disconnected ||
              bluetoothState == BluetoothState.off) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Center(
                      child: Icon(
                    Icons.bluetooth_disabled_outlined,
                    size: screenSize!.width * .25,
                    color: AppColors.primaryColor,
                  )),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize!.width * .2),
                  child: Text(
                    AppLocale.deviceDisconnectedRange.getString(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.fontShadeColor, fontSize: 16),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: getPrimaryAppButton(
                        context, AppLocale.reconnect.getString(context),
                        onPressed: () async {
                      newTestLeProvider.connectToDevice((isConnected) {
                        Navigator.pop(context);
                        if (isConnected) {
                          setState(() {
                            isFirstTimeLoading = true;
                          });
                        }
                      }, selectedDevice, context);
                    }),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 15.0,
                    percent: progressPercent,
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenSize!.width * .15,
                          child: Text(
                            maxLines: 1,
                            '${(elapsedSeconds ~/ 60).toString().padLeft(2, '0')}:${(elapsedSeconds % 60).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.timer_outlined,
                              color: AppColors.primaryColor,
                            ))
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$heartRate BPM',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  isRunning
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize!.width * .3),
                          child: getPrimaryAppButton(
                              context, AppLocale.stop.getString(context),
                              onPressed: () async {
                            bool userWantsToAbort =
                                await showStopTestWarningDialog(context);
                            if (userWantsToAbort) {
                              await stopTestRecording();
                              await clearRecordingsData();
                              _stopTimer();
                            }
                          }),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize!.width * .3),
                          child: getPrimaryAppButton(
                              context, AppLocale.start.getString(context),
                              onPressed: () async {
                            await startRecordingReadings();
                            _startTimer(newTestLeProvider);
                          }),
                        ),

                  // Container(
                  //   child: ,
                  // )


                  const SizedBox(
                    height: 20,
                  ),
                  rrIntervalChartData.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 16.0),
                            child: LineChart(
                              LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: rrIntervalChartData,
                                    isCurved: true,
                                    barWidth: 2.0,
                                    color: Colors.teal.withOpacity(
                                        0.7), // Adjust fill color with transparency
                                  ),
                                ],
                                borderData: FlBorderData(
                                  show: true,
                                  border: const Border(
                                    left: BorderSide(
                                        width: 1, color: Colors.grey),
                                    // Adjust border color for better contrast
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  rightTitles: AxisTitles(
                                    axisNameSize: 28,
                                    axisNameWidget: Text(AppLocale.rrInterval
                                        .getString(context)),
                                  ),
                                  topTitles: AxisTitles(
                                    axisNameSize: 28,
                                    axisNameWidget: Text(
                                        AppLocale.seconds.getString(context)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  stopTestRecording() {
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
  }

  Future<void> startRecordingReadings() async {
    bpmList.clear(); // Clear existing values
    rrIntervalList.clear(); // Clear existing values
    rrIntervalChartData.clear(); // Clear existing values
    subscriptions.clear(); // Clear existing subscriptions
    heartRate = 0;
    energy = 0;

    List<BluetoothService> services = await connectedDevice!.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == "0000180d-0000-1000-8000-00805f9b34fb") {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          try {
            await characteristic.setNotifyValue(true);
          } catch (e) {
            log(e.toString());
          }
          StreamSubscription subscription =
              characteristic.value.listen((value) {
            if (value.isNotEmpty) {
              int flag = value[0];
              bpmList.add(value[1]);
              int offset = 1;

              // Parse Heart Rate
              if ((flag & 0x01) != 0) {
                heartRate = (value[offset + 1] << 8) + value[offset];
                offset += 2;
              } else {
                heartRate = value[offset];
                offset += 1;
              }

              // Parse Energy
              if ((flag & 0x08) != 0) {
                energy = (value[offset + 1] << 8) + value[offset];
                offset += 2;
              }
              int rrValue = 0;
              // Parse RR Intervals
              if ((flag & 0x10) != 0) {
                int rrCount = (value.length - offset) ~/ 2;
                for (int i = 0; i < rrCount; i++) {
                  rrValue = (value[offset + 1] << 8) + value[offset];
                  offset += 2;
                }
                rrIntervalList.add(rrValue);
                rrIntervalChartData
                    .add(FlSpot(elapsedSeconds.toDouble(), rrValue.toDouble()));
              }
            }
          });
          subscriptions.add(subscription);
        }
      }
    }
  }

  clearRecordingsData() {
    bpmList.clear(); // Clear existing values
    rrIntervalList.clear(); // Clear existing values
    rrIntervalChartData.clear(); // Clear existing values
    subscriptions.clear(); // Clear existing subscriptions
    heartRate = 0;
    energy = 0;
  }

  Future<void> saveRecording(NewTestLeProvider newTestLeProvider) async {
    showSuccessToast(context, AppLocale.testCompleted.getString(context));
    if (enterprisePatientData == null && individualPatientData == null) {
      bool isSave = await showSaveTestDialog(context);
      if (isSave) {

        final Map<String, dynamic> jsonData = {
          "MyRoleId": prefModel.userData!.roleId,
          "bpmList": bpmList,
          "rrIntervalList": rrIntervalList,
          "scanDuration": selectedDuration!.durationInMinutes,
          "scanDurationName": selectedDuration!.name,
          "deviceName": selectedDevice!.name,
          "deviceId": selectedDevice!.serialNumber,
          "userAndDeviceId": selectedDevice!.id,
          "selectedDurationId": selectedDuration!.id,
          "enterprisePatientData": enterprisePatientData,
          "individualPatientData": individualPatientData,
          "created": DateTime.now().toIso8601String() // Convert DateTime to String
        };

        final String jsonString = json.encode(jsonData);
        OfflineTestModel testDetails = OfflineTestModel.fromJson(json.decode(jsonString));
        prefModel.offlineSavedTests!.add(testDetails);
        await AppPref.setPref(prefModel);
        showSuccessToast(context, AppLocale.testSavedOffline.getString(context));
      } else {
        showErrorToast(context, AppLocale.testDiscarded.getString(context));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return PopScope(
              canPop: false,
              child: AlertDialog(
                title: Text(AppLocale.testCompleted.getString(context)),
                content:
                    Text(AppLocale.testCompletedSuccessful.getString(context)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Discard')),
                  TextButton(
                      onPressed: () async {

                        final Map<String, dynamic> jsonData = {
                          "MyRoleId": prefModel.userData!.roleId,
                          "bpmList": bpmList,
                          "rrIntervalList": rrIntervalList,
                          "scanDuration": selectedDuration!.durationInMinutes,
                          "scanDurationName": selectedDuration!.name,
                          "deviceName": selectedDevice!.name,
                          "deviceId": selectedDevice!.serialNumber,
                          "userAndDeviceId": selectedDevice!.id,
                          "selectedDurationId": selectedDuration!.id,
                          "enterprisePatientData": enterprisePatientData,
                          "individualPatientData": individualPatientData,
                          "created": DateTime.now().toIso8601String() // Convert DateTime to String
                        };

                        final String jsonString = json.encode(jsonData);
                        OfflineTestModel testDetails = OfflineTestModel.fromJson(json.decode(jsonString));
                        prefModel.offlineSavedTests!.add(testDetails);
                        await AppPref.setPref(prefModel);

                        showSuccessToast(context,
                            AppLocale.testSavedOffline.getString(context));
                        Navigator.pop(context);
                      },
                      child: const Text("Save offline")),
                  TextButton(
                      onPressed: () async {
                        showLoaderDialog(context);
                        var jsonString = jsonEncode({
                          "fileVersion": "IBIPOLAR",
                          "appVersion": "ViCare_1.0.0",
                          "serialNumber": selectedDevice!.serialNumber,
                          "guid": "46184141-00c6-46ee-b927-4218085e85fd",
                          "age": prefModel.userData!.roleId == 2
                              ? calculateAge(individualPatientData!
                                  .result!.contact!.doB
                                  .toString())
                              : calculateAge(enterprisePatientData!
                                  .result!.contact!.doB
                              .toString()),
                          "gender": prefModel.userData!.roleId == 2
                              ? ( individualPatientData!.result!.contact!.gender == 1 ? 0 : 1)
                              : (enterprisePatientData!.result!.contact!.gender == 1 ? 0 : 1),
                          "date": DateTime.now().toIso8601String(),
                          "countryCode": "IN",
                          "intervals": rrIntervalList
                        });
                        var directory = await getExternalStorageDirectory();
                        var viCareDirectory =
                            Directory('${directory!.path}/vicare');

                        if (!(await viCareDirectory.exists())) {
                          await viCareDirectory.create(recursive: true);
                        }
                        var now = DateTime.now();
                        var timestamp = now.millisecondsSinceEpoch;
                        var filename = 'data_$timestamp.json';
                        var filePath = '${viCareDirectory.path}/$filename';
                        File payload = File(filePath);
                        await payload.writeAsString(jsonString);
                        if (await payload.exists()) {
                          String pId = prefModel.userData!.roleId == 2
                              ? individualPatientData!.result!.id.toString()
                              : enterprisePatientData!.result!.id.toString();
                          await newTestLeProvider.requestDeviceData(
                              context,
                              payload,
                              selectedDevice!.serialNumber,
                              selectedDevice!.id,
                              connectedDevice!.id.id,
                              selectedDuration!.id,
                              selectedDuration!.name,
                              pId);
                        } else {
                          showErrorToast(context,
                              AppLocale.somethingWentWrong.getString(context));
                        }
                        Navigator.pop(context);
                      },
                      child: Text(AppLocale.upload.getString(context)))
                ],
              ),
            );
          });
    }
  }

  int calculateAge(String dateOfBirthString) {
    DateTime dateOfBirth = DateTime.parse(dateOfBirthString).toLocal();
    DateTime currentDate = DateTime.now().toLocal();
    Duration difference = currentDate.difference(dateOfBirth);
    int ageInYears = (difference.inDays / 365).floor();
    return ageInYears;
  }
}
