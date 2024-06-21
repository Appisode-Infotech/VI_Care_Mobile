import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_locale.dart';
import '../provider/take_test_provider.dart';

class ScanLeDevicesToAddScreen extends StatefulWidget {
  const ScanLeDevicesToAddScreen({super.key});

  @override
  State<ScanLeDevicesToAddScreen> createState() =>
      _ScanLeDevicesToAddScreenState();
}

class _ScanLeDevicesToAddScreenState extends State<ScanLeDevicesToAddScreen> {
  // bool isFirstOpen = true;

  @override
  void didChangeDependencies() {
    Provider.of<TakeTestProvider>(context, listen: false).scanLeDevices('2');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context,
        TakeTestProvider takeTestProvider, Widget? child) {
      // if(isFirstOpen){
      //   takeTestProvider.scanLeDevices('1');
      //   isFirstOpen = false;
      // }
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocale.chooseDeviceModel.getString(context),
            style: const TextStyle(fontSize: 22),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  scanLeDevices(takeTestProvider);
                },
                child: Text(
                  AppLocale.scanDevices.getString(context),
                  style: const TextStyle(fontSize: 16),
                ))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await takeTestProvider.scanLeDevices('2');
          },
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            itemCount: takeTestProvider.leDevices.length,
            itemBuilder: (BuildContext context, int index) {
              final device = takeTestProvider.leDevices.elementAt(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.platformName.isEmpty
                            ? AppLocale.undefined.getString(context)
                            : device.platformName,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        device.remoteId.str,
                        style: const TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (takeTestProvider.isScanning) {
                        showErrorToast(
                            context, AppLocale.waitScanning.getString(context));
                      } else {
                        takeTestProvider.connectDeviceToAdd(device, context);
                      }
                    },
                    child: Text(
                      AppLocale.addDevice.getString(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      );
    });
  }

  Future<Null> scanLeDevices(TakeTestProvider takeTestProvider) async {
    takeTestProvider.scanLeDevices('2');
  }
}
