import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import '../../utils/app_buttons.dart';
import '../../utils/app_locale.dart';
import '../provider/take_test_provider.dart';

class ScanLeDevicesToAddScreen extends StatefulWidget {
  const ScanLeDevicesToAddScreen({super.key});

  @override
  State<ScanLeDevicesToAddScreen> createState() => _ScanLeDevicesToAddScreenState();
}

class _ScanLeDevicesToAddScreenState extends State<ScanLeDevicesToAddScreen> {
  bool isFirstOpen = true;

  @override
  void didChangeDependencies() {
    Provider.of<TakeTestProvider>(context, listen: false).scanLeDevices('1');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(takeTestProvider.isScanning?AppLocale.scanning.getString(context):AppLocale.findYourDevice.getString(context),style: const TextStyle(fontSize: 22),),
            actions: [
              !takeTestProvider.isScanning?TextButton(onPressed: (){
                scanLeDevices(takeTestProvider);
              }, child: Text(AppLocale.scanDevices.getString(context),style: const TextStyle(fontSize: 16),)):const SizedBox.shrink()
            ],
          ),
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
                          takeTestProvider.leDevices[index].name.isEmpty
                              ? AppLocale.undefined.getString(context)
                              : takeTestProvider.leDevices[index].name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          takeTestProvider.leDevices[index].type.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          takeTestProvider.leDevices[index].id.toString(),
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
                            takeTestProvider.connectDeviceToAdd(
                                takeTestProvider.leDevices[index], context);
                          }
                        },
                        child:  Text(
                          AppLocale.addDevice.getString(context),
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
