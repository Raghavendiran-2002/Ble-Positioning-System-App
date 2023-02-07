import 'package:ble_positioning_system/home-flow/screens/homescreen.dart';
import 'package:ble_positioning_system/home-flow/services/requirement_state_controlle.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'home-flow/screens/flutter_beacon.dart';
import 'home-flow/screens/flutter_blue_plus.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(RequirementStateController());
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Get.put(RequirementStateController());
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Smart Museum',
      initialRoute: "flutterBeacon",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeScreen(),
        "flutterBeacon": (context) => Flutter_Beacon(),
        "flutterBluePlus" : (context) => Flutter_Blue_Plus(),
      },
    );
  }
  }


