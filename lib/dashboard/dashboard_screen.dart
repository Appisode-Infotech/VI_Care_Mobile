import 'package:flutter/material.dart';
import 'package:vicare/dashboard/ui/all_reports_screen.dart';
import 'package:vicare/dashboard/ui/home_screen.dart';
import 'package:vicare/dashboard/ui/manage_patients_screen.dart';
import 'package:vicare/dashboard/ui/profile_screen.dart';
import 'package:vicare/utils/routes.dart';
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
      padding: EdgeInsets.all(8),
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
    );
  }

  Widget _buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.takeTestRoute); //
            // setState(() {
            //   selectedItemPosition = 2;
            // });
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.monitor_heart_outlined,
              color: Colors.white, size: 28),
        ),
      ),
    );
  }

  void changeScreen(int index) {
    setState(() {
      selectedItemPosition = index;
    });
  }
}
