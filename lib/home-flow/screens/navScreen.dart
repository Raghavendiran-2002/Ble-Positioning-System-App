import 'package:ble_positioning_system/bluetooth-flow/screens/flutter_blue_plus.dart';
import 'package:ble_positioning_system/geofencing-flow/screens/geofencing.dart';
import 'package:ble_positioning_system/home-flow/screens/homescreen.dart';
import 'package:flutter/material.dart';

import '../../bluetooth-flow/screens/flutter_bluetooth_serial.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Schools',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, "/");
        break;
      case 1:
        Navigator.pushNamed(context, "GeoFencing");
        break;
      case 2:
        Navigator.pushNamed(context, "flutterBluePlus");
        break;
      case 3:
        Navigator.pushNamed(context, "flutter_bluetooth_serial");
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: Colors.grey,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.museum,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bluetooth_audio_sharp,
                color: Colors.black,
              ),
              label: 'GeoFencing',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_bluetooth_sharp,
                color: Colors.black,
              ),
              label: 'Discovery',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.navigation_outlined,
                color: Colors.black,
              ),
              label: 'Discovery',
            ),
          ],
          selectedIndex: _selectedIndex,
          // selectedItemColor: Colors.amber[800],
          onDestinationSelected: (index) {
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 500), curve: Curves.ease);
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: PageView(
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: _pageController,
        children: [
          HomeScreen(),
          GeoFencing(),
          Flutter_Blue_Plus(),
          Flutter_Bluetooth_Serial(),
        ],
      ),
    );
  }
}
