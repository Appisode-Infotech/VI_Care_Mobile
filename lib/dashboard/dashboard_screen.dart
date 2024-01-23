import 'package:flutter/material.dart';
import 'package:vicare/dashboard/ui/all_reports_screen.dart';
import 'package:vicare/dashboard/ui/home_screen.dart';
import 'package:vicare/dashboard/ui/manage_patients_screen.dart';
import 'package:vicare/dashboard/ui/profile_screen.dart';

import 'ui/take_test_screen.dart';
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
      const HomeScreen(),
      const ReportScreen(),
      const TakeTestScreen(),
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
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: selectedItemPosition,
            onTap: (index) => setState(() => selectedItemPosition = index),
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
                icon: Icon(Icons.monitor_heart_outlined,size: 30,),
                label: 'Take test',
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
      ),
    );
  }
}


