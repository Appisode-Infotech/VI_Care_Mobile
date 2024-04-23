import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vicare/dashboard/model/device_response_model.dart';
import 'package:vicare/dashboard/model/duration_response_model.dart';
import 'package:vicare/dashboard/provider/devices_provider.dart';
import 'package:vicare/dashboard/ui/all_reports_screen.dart';
import 'package:vicare/dashboard/ui/home_screen.dart';
import 'package:vicare/dashboard/ui/manage_patients_screen.dart';
import 'package:vicare/dashboard/ui/profile_screen.dart';
import 'package:vicare/utils/app_buttons.dart';

import '../main.dart';
import '../utils/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedItemPosition = 0;

  List screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(changeScreen: changeScreen),
      const ReportScreen(),
      const ManagePatientsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: screens[selectedItemPosition],
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Set splash color to transparent
        ),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: selectedItemPosition,
          onTap: (index) {
            if (index == 2) {
              // If "Take Test" is tapped, call changeScreen with the index directly
              changeScreen(index);
            } else {
              // For other tabs, set the selectedItemPosition
              setState(() => selectedItemPosition = index);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airline_seat_recline_extra_outlined),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Consumer(
      builder: (BuildContext context, DeviceProvider deviceProvider,
          Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: FloatingActionButton(
              onPressed: () async {
                showLoaderDialog(context);
                DeviceResponseModel myDevices = await deviceProvider
                    .getMyDevices();
                DurationResponseModel myDurations = await deviceProvider
                    .getAllDuration();
                Navigator.pop(context);
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bottomSheetContext) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: screenSize!.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select options",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                IconButton(onPressed: (){
                                  Navigator.pop(bottomSheetContext);
                                }, icon: Icon(Icons.close))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              items: [
                                for (int i = 0; i < myDevices.result!.devices!.length; i++)
                                  DropdownMenuItem<String>(
                                    value: myDevices.result!.devices![i].serialNumber!.toString(),
                                    child: Text(myDevices.result!.devices![i].serialNumber!.toString()),
                                  ),
                              ],
                              onChanged: (val) {},
                            ),
                            DropdownButtonFormField<String>(
                              items: [
                                for (int i = 0; i < myDurations.result!.length; i++)
                                  DropdownMenuItem<String>(
                                    value: myDurations.result![i].name!.toString(),
                                    child: Text(myDurations.result![i].name!.toString()),
                                  ),
                              ],
                              onChanged: (val) {},
                            )
                          ],
                        ),
                      );
                    });
                // if (myDevices.result!.devices!.isEmpty) {
                //   showErrorToast(context, myDevices.message!);
                // } else {
                //   Navigator.pushNamed(context, Routes.takeTestRoute,
                //       arguments: {
                //         'enterprisePatientData': null,
                //         'deviceData': myDevices.result!.devices![0]
                //       });
                // }
              },
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.monitor_heart_outlined,
                  color: Colors.white, size: 28),
            ),
          ),
        );
      },
    );
  }

  void changeScreen(int index) {
    setState(() {
      selectedItemPosition = index;
    });
  }
}
