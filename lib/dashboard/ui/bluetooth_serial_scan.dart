import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../../utils/app_locale.dart';

class BluetoothSerialScan extends StatefulWidget {
  const BluetoothSerialScan({super.key});

  @override
  State<BluetoothSerialScan> createState() => _BluetoothSerialScanState();
}

class _BluetoothSerialScanState extends State<BluetoothSerialScan> {
  bool isFirstOpen = true;

  // @override
  // void didChangeDependencies() {
  //   Provider.of<TakeTestProvider>(context, listen: false).scanLeDevices('1');
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider,
          Widget? child) {
        // if(isFirstOpen){
        //   takeTestProvider.scanLeDevices('1');
        // }
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => scanLeDevices(takeTestProvider),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              itemCount: takeTestProvider.leDevices.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          takeTestProvider.leDevices[index].platformName.isEmpty
                              ? AppLocale.undefined.getString(context)
                              : takeTestProvider.leDevices[index].platformName,
                          style: const TextStyle(fontSize: 16),
                        ),
                        // Text(
                        //   takeTestProvider.leDevices[index].type.toString(),
                        //   style: const TextStyle(fontSize: 16),
                        // ),
                        Text(
                          takeTestProvider.leDevices[index].remoteId.toString(),
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          if (takeTestProvider.isScanning) {
                            showErrorToast(context,
                                AppLocale.waitScanning.getString(context));
                          } else {
                            takeTestProvider.connectToDevice(
                                takeTestProvider.leDevices[index], context);
                          }
                        },
                        child: Text(
                          AppLocale.connect.getString(context),
                          style: const TextStyle(fontSize: 16),
                        ))
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        );
      },
    );
  }

  Future<Null> scanLeDevices(TakeTestProvider takeTestProvider) async {
    takeTestProvider.scanLeDevices('2');
  }
}
