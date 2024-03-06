import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/take_test_provider.dart';
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
        title: const Text("Scan devices"),
      ),
      body: const Column(
        children: [
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "Bluetooth LE"),
                      Tab(text: "Bluetooth Classic"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
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
