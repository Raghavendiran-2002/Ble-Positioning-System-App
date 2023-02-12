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
  PageController _pageController = PageController(initialPage: 0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.museum,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bluetooth_audio_sharp,
              color: Colors.black,
            ),
            label: 'GeoFencing',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_bluetooth_sharp,
              color: Colors.black,
            ),
            label: 'Discovery',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.navigation_outlined,
              color: Colors.black,
            ),
            label: 'Discovery',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(microseconds: 500), curve: Curves.ease);
        },
      ),
      body: PageView(
        children: [
          HomeScreen(),
          GeoFencing(),
          Flutter_Bluetooth_Serial(),
          Flutter_Blue_Plus(),
        ],
      ),
    );
  }
}
