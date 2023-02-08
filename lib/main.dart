import 'package:ble_positioning_system/home-flow/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';


import 'home-flow/screens/beacon_plugin.dart';
import 'home-flow/screens/flutter_blue_plus.dart';


void main() async{
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
      theme: ThemeData(useMaterial3: true),
      title: 'Smart Museum',
      initialRoute: "flutterBluePlus",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeScreen(),
        "flutterBeacon": (context) => Beacons_Plugin(),
        "flutterBluePlus" : (context) => Flutter_Blue_Plus(),
      },
    );
  }
  }


