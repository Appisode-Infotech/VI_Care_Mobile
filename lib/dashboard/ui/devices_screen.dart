import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';
import 'package:vicare/dashboard/provider/devices_provider.dart';
import 'package:vicare/main.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';
import '../../utils/routes.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  int selectedDeviceIndex = 0;
  List<Map> availableDevices = [
    {
      "name": "Smart Lab Hrm W",
      "image": "assets/images/smartlab.png",
      "instructions":
          "1. Wear your smart Lab Hrm W device on your chest attached to provided flexible chest strap.\n"
              "2. Turn on bluetooth on your smart phone\n"
              "3. Press 'Start pairing' button below to start adding this device.",
    },
    {
      "name": "Bittium Faros 180",
      "image": "assets/images/bittium_180.png",
      "instructions":
          "1. Wear Bittium Faros 180 device on your chest attached to provided cables.\n"
              "2. Turn on bluetooth on your smart phone\n"
              "3. Press 'Start pairing' button below to start adding this device.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, DeviceProvider deviceProvider, Widget? child) {
        deviceProvider.devicePageContext = context;
        deviceProvider.getMyDevices();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocale.devices.getString(context),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 75,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (!connected) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "No Internet",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Please check your internet\n connection and try again.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500
                        ),
                      ),
                    ],
                  ),
                );
              }
              return FutureBuilder(
                future: deviceProvider.getMyDevices(),
                builder: (BuildContext context, AsyncSnapshot<DeviceResponseModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: screenSize!.width,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              width: screenSize!.width,
                              height: 80,
                              color: Colors.grey.shade300,
                            );
                          },
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return (snapshot.data!.result != null &&
                        snapshot.data!.result!.isNotEmpty)
                        ? ListView.separated(
                        itemBuilder: (BuildContext listViewContext, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenSize!.width * 0.7,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      _buildRow(
                                          AppLocale.deviceScreenName
                                              .getString(context),
                                          snapshot.data!.result![index].device!
                                              .name!),
                                      _buildRow(
                                          AppLocale.deviceScreenSNum
                                              .getString(context),
                                          snapshot.data!.result![index].device!
                                              .serialNumber!),
                                      _buildRow(
                                          AppLocale.bluetoothType
                                              .getString(context),
                                          snapshot.data!.result![index].device!
                                              .deviceCategory ==
                                              2
                                              ? 'LE'
                                              : 'Classic'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      deviceProvider.deleteDevice(
                                          snapshot.data!.result![index].id,
                                          context);
                                    },
                                    child: const CircleAvatar(
                                        child: Icon(Icons.delete_outline_rounded)))
                              ],
                            ),
                          );
                        },
                        separatorBuilder:
                            (BuildContext listViewContext, int index) {
                          return const SizedBox();
                        },
                        itemCount: snapshot.data!.result!.length)
                        : Center(
                      child: Text(
                        AppLocale.noDevicesFound.getString(context),
                        style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.fontShadeColor),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: Text(AppLocale.loading.getString(context)),
                    );
                  }
                },
              );
            },
            child: CircularProgressIndicator(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: showDeviceSelectionBottomSheet,
            backgroundColor: Colors.teal.shade100,
            child: Icon(
              Icons.add,
              color: Colors.teal.shade800,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );

          },
    );
  }

  showDeviceSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.chooseDeviceModel.getString(context),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: availableDevices.length,
                    itemBuilder: (context, index) {
                      final device = availableDevices[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDeviceIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            border: Border.all(
                              color: selectedDeviceIndex == index
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  device['image'],
                                  height: screenSize!.width * .35,
                                  width: screenSize!.width * .35,
                                ),
                              ),
                              Text(
                                device['name'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  Text(
                    AppLocale.instructions.getString(context),
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: screenSize!.width,
                    child: Text(
                      availableDevices[selectedDeviceIndex]['instructions'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  getPrimaryAppButton(
                      context, AppLocale.startPairing.getString(context),
                      onPressed: () async {
                    var bluetoothConnectStatus = await Permission.bluetoothConnect.request();
                    var bluetoothScanStatus = await Permission.bluetoothScan.request();
                    loc.Location location = new loc.Location();
                    bool _serviceEnabled;
                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {
                        return;
                      }
                    }
                    if (bluetoothConnectStatus == PermissionStatus.granted &&
                        bluetoothScanStatus == PermissionStatus.granted) {
                      FlutterBlue flutterBlue = FlutterBlue.instance;
                      if (await flutterBlue.isOn) {
                        if (selectedDeviceIndex == 0) {
                          Navigator.pushNamed(
                                  context, Routes.scanLeDevicesToAddRoute)
                              .then((value) => setState(() {}));
                        } else {
                          showErrorToast(context,
                              AppLocale.startPairingError.getString(context));
                        }
                      } else {
                        showErrorToast(context,
                            AppLocale.bluetoothIsOff.getString(context));
                      }
                    }
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "$value",
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
