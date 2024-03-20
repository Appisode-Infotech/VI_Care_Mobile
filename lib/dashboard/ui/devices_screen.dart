import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/provider/devices_provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_locale.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, DeviceProvider deviceProvider, Widget? child) {
        deviceProvider.devicePageContext=context;
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
          body:  Center(
            child: Text(
              AppLocale.noDevicesFound.getString(context),
              style: const TextStyle(fontSize: 18,color: AppColors.fontShadeColor),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                showAddDialog(deviceProvider);
              },
              backgroundColor: Colors.teal.shade100,
              child: Icon(Icons.add,color: Colors.teal.shade800,)
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  void showAddDialog(DeviceProvider deviceProvider) {
    deviceProvider.clearDevicePopUp();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppLocale.addDevice.getString(context)),
          content:  SingleChildScrollView(
            child: ListBody(
              children:[
                 Text(AppLocale.type.getString(context)),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  hint:  Text(AppLocale.type.getString(context)),
                  value: deviceProvider.deviceType,
                  onChanged: (String? value) {
                    setState(() {
                      deviceProvider.deviceType = value!;
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  items: <String>[
                    "Faros Bittium",
                    "Smart Lab"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 10,),
                 Text(AppLocale.serialNumber.getString(context)),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: deviceProvider.serialNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: AppLocale.serialNumber.getString(context),
                    hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                    counterText: "",
                    isCollapsed: true,
                    errorStyle: const TextStyle(color: Colors.red),
                    errorMaxLines: 2,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  ),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text(AppLocale.cancel.getString(context),style: const TextStyle(color: Colors.teal),),
            ),
            TextButton(
              onPressed: () {
                  deviceProvider.addDevice();
                  // Navigator.of(context).pop();
              },
              child:  Text(AppLocale.connect.getString(context),style: const TextStyle(color: Colors.teal),),
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
