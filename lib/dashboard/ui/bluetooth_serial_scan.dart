import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/provider/take_test_provider.dart';
import 'package:vicare/utils/app_locale.dart';

class BluetoothSerialScan extends StatefulWidget {
  const BluetoothSerialScan({super.key});

  @override
  State<BluetoothSerialScan> createState() => _BluetoothSerialScanState();
}

class _BluetoothSerialScanState extends State<BluetoothSerialScan> {
  bool isFirstOpen = true;
  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (BuildContext context, TakeTestProvider takeTestProvider, Widget? child) {
        if(isFirstOpen){
          scanLeDevices(takeTestProvider);
          isFirstOpen=false;
        }
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => scanLeDevices(takeTestProvider),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
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
                        Text(takeTestProvider.leDevices[index].name,style: const TextStyle(fontSize: 16),),
                        Text(takeTestProvider.leDevices[index].id.toString(),style: const TextStyle(fontSize: 14),)
                      ],
                    ),
                    TextButton(onPressed: (){
                      takeTestProvider.connectToDevice(takeTestProvider.leDevices[index],context);
                    }, child:  Text(AppLocale.connect.getString(context),style: TextStyle(fontSize: 16),))
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
    takeTestProvider.leDevices.clear();
    takeTestProvider.scanForLEDevices();
  }
}
