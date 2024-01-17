import 'package:flutter/material.dart';
import 'package:vicare/view/dashboard_screens/all_reports_screen.dart';
import 'package:vicare/view/dashboard_screens/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  int selectedItemPosition = 0;

  List screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      const ReportScreen(),
      const Scaffold(),
      const Scaffold(),
      const Scaffold(),
      // const Reports(),
      // const LiveScan(),
      // const Patients(),
      // const Profile(),

    ];
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: screens[selectedItemPosition],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 1,
          selectedItemColor: Colors.blue,
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
              icon: Icon(Icons.data_thresholding_outlined),
              label: 'Live Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'Patients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}


