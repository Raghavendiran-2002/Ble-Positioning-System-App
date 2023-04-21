import 'package:ble_positioning_system/home-flow/screens/homescreen.dart';
import 'package:ble_positioning_system/home-flow/services/theming.dart';
import 'package:ble_positioning_system/login-flow/screens/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bluetooth-flow/screens/beacon_plugin.dart';
import 'bluetooth-flow/screens/flutter_blue_plus.dart';
import 'bluetooth-flow/screens/flutter_bluetooth_serial.dart';
import 'bluetooth-flow/services/custom_ble/custom_ble.dart';
import 'firebase_options.dart';
import 'geofencing-flow/screens/geofencing.dart';
import 'home-flow/screens/navScreen.dart';
import 'museum-flow/screens/museum_homescreen.dart';
import 'nwarehouse-flow/screens/nwarehousescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "SFU",
        scaffoldBackgroundColor: Theming.instance.isLight
            ? Theming.instance.Light["scaffoldBackgroundColor"]
            : Theming.instance.Dark["scaffoldBackgroundColor"],
        textTheme: TextTheme(
          displayMedium: TextStyle(color: Colors.white),
        ),
      ),
      title: 'Smart Museum',
      initialRoute: "Nav",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeScreen(),
        "custom": (context) => CustomBLE(),
        "Nav": (context) => NavScreen(),
        "login": (context) => LoginPage(),
        "flutterBeacon": (context) => Beacons_Plugin(),
        "flutterBluePlus": (context) => Flutter_Blue_Plus(),
        "museum": (context) => Museum(),
        "GeoFencing": (context) => GeoFencing(),
        "flutter_bluetooth_serial": (context) => Flutter_Bluetooth_Serial(),
        "nwarehouse": (context) => NwareHouseScreen(),
      },
    );
  }
}
