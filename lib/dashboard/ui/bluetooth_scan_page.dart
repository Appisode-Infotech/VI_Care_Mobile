import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/utils/app_colors.dart';
import 'package:vicare/utils/app_locale.dart';

import 'bluetooth_classic_scan.dart';
import 'bluetooth_serial_scan.dart';

class BluetoothScanPage extends StatefulWidget {
  const BluetoothScanPage({super.key});

  @override
  State<BluetoothScanPage> createState() => _BluetoothScanPageState();
}

class _BluetoothScanPageState extends State<BluetoothScanPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: !takeTestProvider.isScanning
                ? Text(AppLocale.scanDevices.getString(context))
                :  Text(AppLocale.scanning.getString(context)),
          ),
          body: Column(
            children: [
              DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        // Change this color to the desired background color
                        child: TabBar(
                          tabs: [
                            Tab(text: AppLocale.bluetoothLe.getString(context)),
                            Tab(
                                text: AppLocale.bluetoothClassic
                                    .getString(context)),
                          ],
                          labelColor: AppColors.primaryColor,
                          indicatorColor: AppColors
                              .primaryColor, // Change this color to the desired selected tab indicator color
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            Center(
                              child: BluetoothSerialScan(),
                            ),
                            Center(
                              child: BluetoothClassicScan(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
