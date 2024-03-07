import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.scanDevices.getString(context)),
      ),
      body:  Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: AppLocale.bluetoothLe.getString(context)),
                      Tab(text: AppLocale.bluetoothClassic.getString(context)),
                    ],
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
  }
}
