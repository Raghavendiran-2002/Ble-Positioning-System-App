import 'package:ble_positioning_system/bluetooth-flow/services/custom_ble/custom_ble.dart';
import 'package:ble_positioning_system/home-flow/screens/homescreen.dart';
import 'package:ble_positioning_system/home-flow/services/theming.dart';
import 'package:flutter/material.dart';

import '../../bluetooth-flow/screens/flutter_bluetooth_serial.dart';
import '../../museum-flow/screens/museum_homescreen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

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
            indicatorColor: Theming.instance.isLight
                ? Theming.instance.Light["navigationBarIndicatorColor"]
                : Theming.instance.Dark["navigationBarIndicatorColor"],
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Theming.instance.isLight
              ? Theming.instance.Light["navigationBarBackgroundColor"]
              : Theming.instance.Dark["navigationBarBackgroundColor"],
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.museum,
                color: Theming.instance.isLight
                    ? Theming.instance.Light["navigationBarIconColor"]
                    : Theming.instance.Dark["navigationBarIconColor"],
              ),
              label: Theming.instance.NavNames[0],
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bluetooth_audio_sharp,
                color: Theming.instance.isLight
                    ? Theming.instance.Light["navigationBarIconColor"]
                    : Theming.instance.Dark["navigationBarIconColor"],
              ),
              label: Theming.instance.NavNames[1],
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_bluetooth_sharp,
                color: Theming.instance.isLight
                    ? Theming.instance.Light["navigationBarIconColor"]
                    : Theming.instance.Dark["navigationBarIconColor"],
              ),
              label: Theming.instance.NavNames[2],
            ),
            NavigationDestination(
              icon: Icon(
                Icons.navigation_outlined,
                color: Theming.instance.isLight
                    ? Theming.instance.Light["navigationBarIconColor"]
                    : Theming.instance.Dark["navigationBarIconColor"],
              ),
              label: Theming.instance.NavNames[3],
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
          // SastraInfo(),
          // Flutter_Blue_Plus(),
          // EmbeddedInfo(),
          CustomBLE(),
          HomeScreen(),
          Museum(),
          // CustomBLE(),
          Flutter_Bluetooth_Serial(),
        ],
      ),
    );
  }
}
