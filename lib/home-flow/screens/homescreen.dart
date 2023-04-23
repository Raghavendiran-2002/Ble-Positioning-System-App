import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/theming.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  final flutterReactiveBle = FlutterReactiveBle();
  FlutterTts ftts = FlutterTts();
  String beaconAvailable = "NO BEACONS FOUND";
  // final stack = Stack<ScanResult>();
  // final multipleBeacon = Stack<ScanResult>();

  List<String> beaconUUID = ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"];
  List<bool> isVisited = [false, false, false];
  bool isScanning = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // scanBeacon();
    // timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
    //   closestBeacon();
    // });
    // stack.isNotEmpty ? print(stack.peek.device.name) : null;
  }

  @override
  void dispose() {
    timer?.cancel();
    // flutterBlue.stopScan();
    super.dispose();
  }

  // void scanBeacon() {
  //   flutterBlue.startScan(
  //       scanMode: ScanMode.lowPower,
  //       macAddresses: beaconUUID,
  //       // );
  //       timeout: Duration(seconds: 2));
  //   flutterBlue.scanResults.listen((results) {
  //     for (ScanResult r in results) {
  //       setState(() {
  //         isScanning = true;
  //       });
  //       // print("${r.device.name} ${r.rssi} ${r.device.id}");
  //       if (r.device.id.toString() == beaconUUID[0] ||
  //           r.device.id.toString() == beaconUUID[1]) {
  //         // print("${r.device.name} ${r.rssi} ${r.device.id}");
  //         if (stack.isEmpty) stack.push(r);
  //         // if (multipleBeacon.isEmpty) multipleBeacon.push(r);
  //         // if (multipleBeacon.isNotEmpty && multipleBeacon.peek == r) {
  //         //   multipleBeacon.pop();
  //         //   multipleBeacon.push(r);
  //         // } else {
  //         //   multipleBeacon.push(r);
  //         // }
  //         if (stack.peek == r) {
  //           stack.pop();
  //           stack.push(r);
  //         }
  //         // print("***************");
  //         print("${stack.peek.device.id}  ${stack.peek.device.name}");
  //       }
  //     }
  //   });
  //   flutterBlue.stopScan();
  //   setState(() {
  //     isScanning = false;
  //   });
  // }

  // void closestBeacon() {
  //   scanBeacon();
  //   if (stack.size == 1) {
  //     print("*********************");
  //     setState(() {
  //       stack.peek.device.id.toString() == beaconUUID[0]
  //           ? beaconAvailable = "SASTRA"
  //           : beaconAvailable = "Embedded System";
  //     });
  //     String imgurl = stack.peek.device.id.toString() == beaconUUID[0]
  //         ? "sastra1"
  //         : "sastra2";
  //     String speaktext = stack.peek.device.id.toString() == beaconUUID[0]
  //         ? "Welcome to SASTRA"
  //         : "Welcome to Embedded System Lab";
  //     print("${imgurl} ${speaktext}  ${stack.peek.device.id}");
  //     if (-80 < stack.peek.rssi) {
  //       if (!isVisited[2]) {
  //         print(
  //             "Beacon Near : ${stack.peek.device.id} ${stack.peek.device.name}");
  //         displaySnackBar(stack.peek.device.name, imgurl);
  //         speakText(speaktext);
  //         isVisited[0] = true;
  //       }
  //       setState(() {
  //         beaconAvailable = "SCANNING FOR BEACONS";
  //       });
  //     }
  //     stack.pop();
  //   }
  //   // if (multipleBeacon.size == 2) {
  //   //   if (-40 < multipleBeacon.peek.rssi && -40 > multipleBeacon.peekmin.rssi) {
  //   //     if (!isVisited[1]) {
  //   //       displaySnackBar(multipleBeacon.peek.device.name, "img1");
  //   //       speakText("Welcome to Sastra");
  //   //       isVisited[1] = true;
  //   //     }
  //   //   } else if (-40 < multipleBeacon.peek.rssi &&
  //   //       -40 > multipleBeacon.peekmin.rssi) {
  //   //     if (!isVisited[0]) {
  //   //       displaySnackBar(multipleBeacon.peekmin.device.name, "shiva");
  //   //       speakText("Welcome to Embedded System Lab");
  //   //       isVisited[0] = true;
  //   //     }
  //   //   }
  //   // }
  // }

  void speakText(String voice) async {
    var result = await ftts.speak("${voice}");
    if (result == 1) {
      //speaking
    } else {
      //not speaking
    }
  }

  void displaySnackBar(String message, String imgurl,
      {Color color = Colors.white, int durationInSeconds = 2}) {
    SnackBar snackBar = SnackBar(
      content: Column(
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
          Image.asset(
            'assets/images/${imgurl}.png',
            width: 200,
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Open"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Close")),
            ],
          )
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: durationInSeconds),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.bluetooth_searching_rounded,
                  color: isScanning ? Colors.green : Colors.red,
                ),
                IconButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn().signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "login", (Route<dynamic> route) => false);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              "WELCOME TO SASTRA",
              style: TextStyle(
                fontFamily: "RobotoMono",
                fontSize: 30,
                color: Theming.instance.isLight
                    ? Theming.instance.Light["welcomeTextColor"]
                    : Theming.instance.Dark["welcomeTextColor"],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //   child: Text("${beaconAvailable}"),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            CarouselSlider(
              options: CarouselOptions(autoPlay: true, height: 300.0),
              items: ["sastra1", "sastra2", "sastra3"].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: 60,
                      width: 300,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.asset(
                        "assets/images/${i}.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;
  E get peekmin => _list.elementAt(0);
  int get size => _list.length;
  //void get sort => _list.sort;
  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
