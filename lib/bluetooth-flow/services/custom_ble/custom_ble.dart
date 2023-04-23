import 'dart:async';

import 'package:ble_positioning_system/home-flow/services/theming.dart';
import 'package:ble_positioning_system/sastra-flow/screens/embeddedinfo.dart';
import 'package:ble_positioning_system/sastra-flow/screens/sastrainfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CustomBLE extends StatefulWidget {
  const CustomBLE({Key? key}) : super(key: key);

  @override
  State<CustomBLE> createState() => _CustomBLEState();
}

class _CustomBLEState extends State<CustomBLE> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<String> macAddresses = ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"];
  bool isScanning = false;
  Map<String, ScanResult> discoveredDevices = {};
  bool isEnteredBuilding = false;
  List<bool> isDisplayed = [true, true];
  FlutterTts ftts = FlutterTts();

  @override
  void initState() {
    super.initState();
    setStream(getScanStream());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Stream<ScanResult> getScanStream() {
    setState(() {
      isScanning = true;
    });
    return flutterBlue.scan(
      timeout: Duration(seconds: 3),
      macAddresses: ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"],
    );
  }

  // void getCalculatedDistance(double rssi1, int txAt1Meter) {
  //   print(txAt1Meter);
  //   var ratio = rssi1 * (1.0 / (txAt1Meter + 55));
  //   if (ratio < 1.0) {
  //     // return pow(ratio, 10);
  //   } else {
  //     // return (1.21112) * pow(ratio, 7.560861) + 0.251;
  //   }
  //   LogDistancePathLossModel(double rssiMeasured) {
  //     rssi1 = rssiMeasured;
  //   }
  //
  //   // RSSI
  //   double rssi;
  //   // Rssd0, rssi measured at chosen reference distance d0
  //   double referenceRssi = -55;
  //   //d0
  //   double referenceDistance = 0.944;
  //   // For line of sight in building
  //   // n
  //   double pathLossExponent = 0.3;
  //   // Set to zero, as no large obstacle, used to mitigate for flat fading
  //   // Sigma
  //   double flatFadingMitigation = 0;
  //   double getCalculatedDistance() {
  //     double distance;
  //     double rssiDiff = rssi1 - referenceRssi - flatFadingMitigation;
  //     double i = LogDistancePathLossModel(20.23) as double;
  //     double k = -(rssiDiff / 10 * pathLossExponent);
  //     distance = referenceDistance * i;
  //     return distance;
  //   }
  // }

  void addDevices(ScanResult result) {
    setState(() {
      discoveredDevices[result.device.id.toString()] = result;
    });
  }

  void setStream(Stream<ScanResult> stream) async {
    stream.listen((event) {
      // print("data received $event");
      setState(() {
        addDevices(event);
      });
    }, onDone: () async {
      // Scan is finished ****************
      // if (discoveredDevices.length == 2) {
      // compareBeacon(discoveredDevices[macAddresses[0]]!,
      //     discoveredDevices[macAddresses[1]]!);
      // } else {
      if (discoveredDevices[macAddresses[0]]?.device.name != null &&
          discoveredDevices[macAddresses[0]]!.rssi > -90) {
        isDisplayed[0]
            ? displaySnackBar("Welcome to Sastra",
                "${discoveredDevices[macAddresses[0]]!.device.id}", "tifac")
            : null;
        isEnteredBuilding = true;
        isDisplayed[0] = false;
      } // EmbeddedLab
      if (discoveredDevices[macAddresses[1]]?.device.name != null &&
          discoveredDevices[macAddresses[1]]!.rssi > -90) {
        isDisplayed[1]
            ? displaySnackBar(
                "Welcome to Embedded Lab",
                "${discoveredDevices[macAddresses[1]]!.device.id}",
                "EmbeddedLab")
            : null;
        isEnteredBuilding = true;
        isDisplayed[1] = false;
      }
      // }
      await flutterBlue.stopScan();
      setState(() {
        // discoveredDevices.clear();
        isScanning = false;
      });
      print(discoveredDevices[macAddresses[0]]?.device.name);
      // discoveredDevices.forEach((key, value) {
      //   print("${key} ${value.device.name} ${value.rssi}");
      // });
      setStream(getScanStream()); // New scan
    }, onError: (Object e) {
      print("Some Error " + e.toString());
    });
  }

  void compareBeacon(ScanResult r1, ScanResult r2) {
    if (r1.rssi > -90) {
      isDisplayed[0]
          ? displaySnackBar("Welcome to Sastra", "${r1.device.id}", "tifac")
          : null;
      // isEnteredBuilding = true;
      isDisplayed[0] = false;
    }
    // if (r2.rssi > -60 && isEnteredBuilding) {
    if (r2.rssi > -90) {
      isDisplayed[1]
          ? displaySnackBar(
              "Welcome to Embedded Lab", "${r2.device.id}", "EmbeddedLab")
          : null;
      isDisplayed[1] = false;
    }
    // if (r1.rssi > -40 && r2.rssi < -40) {
    //   displaySnackBar("${r1.device.name}", "img1");
    // }
    // if (r2.rssi > -40 && r1.rssi < -40) {
    //   displaySnackBar("${r2.device.name}", "shiva");
    // }
  }

  void speakText(String voice) async {
    var result = await ftts.speak(voice);
    if (result == 1) {
      //speaking
    } else {
      //not speaking
    }
  }

  void displaySnackBar(String message, String beaconID, String imgPath,
      {int durationInSeconds = 5}) {
    imgPath == "tifac"
        ? speakText("Welcome to Sastra")
        : speakText("Wecome to Embedded Lab");
    SnackBar snackBar = SnackBar(
      content: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theming.instance.isLight
                  ? Theming.instance.Light["snackBarTextColor"]
                  : Theming.instance.Dark["snackBarTextColor"],
            ),
          ),
          Text(
            beaconID,
            style: TextStyle(
              fontSize: 10,
              color: Theming.instance.isLight
                  ? Theming.instance.Light["snackBarTextColor"]
                  : Theming.instance.Dark["snackBarTextColor"],
            ),
          ),
          Image.asset(
            'assets/images/${imgPath}.png',
            width: 200,
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  imgPath == "tifac"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SastraInfo()),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmbeddedInfo()),
                        );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Text(
                  "Open",
                  style: TextStyle(
                    color: Theming.instance.isLight
                        ? Theming.instance.Light["snackBarTextColor"]
                        : Theming.instance.Dark["snackBarTextColor"],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Theming.instance.isLight
                          ? Theming.instance.Light["snackBarTextColor"]
                          : Theming.instance.Dark["snackBarTextColor"],
                    ),
                  )),
            ],
          )
        ],
      ),
      backgroundColor: Theming.instance.isLight
          ? Theming.instance.Light["snackBarBGcolor"]
          : Theming.instance.Dark["snackBarBGcolor"],
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
        appBar: AppBar(
          backgroundColor: Theming.instance.isLight
              ? Theming.instance.Light["appBarBgColor"]
              : Theming.instance.Dark["appBarBgColor"],
          title: Text(
            'Beacon 🛸',
            style: TextStyle(
                color: Theming.instance.isLight
                    ? Theming.instance.Light["appBarTextColor"]
                    : Theming.instance.Dark["appBarTextColor"],
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            isScanning
                ? FittedBox(
                    child: SpinKitWave(
                      color: Color(0xFFB99E6D),
                      size: 15.0,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.replay,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      flutterBlue.stopScan();
                    },
                  ),
            IconButton(
              icon: Icon(
                Icons.settings_bluetooth_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                print("cancel");
                flutterBlue.stopScan();
                isDisplayed[0] = true;
                isDisplayed[1] = true;
                isEnteredBuilding = false;
                setStream(getScanStream());
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Text(
                "WELCOME TO SASTRA",
                style: TextStyle(
                  fontSize: 30,
                  color: Theming.instance.isLight
                      ? Theming.instance.Light["welcomeTextColor"]
                      : Theming.instance.Dark["welcomeTextColor"],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/sastra1.png',
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              // Expanded(
              //     flex: 1,
              //     child: Lottie.asset('assets/animations/scanning.json')),  indoormap.png

              Expanded(
                child: ListTileTheme(
                  // iconColor: Colors.red,
                  // textColor: Colors.black54,
                  tileColor: Theming.instance.isLight
                      ? Theming.instance.Light["beaconTileColor"]
                      : Theming.instance.Dark["beaconTileColor"],
                  style: ListTileStyle.list,
                  dense: true,
                  child: ListView.builder(
                    itemCount: macAddresses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          leading:
                              discoveredDevices[macAddresses[index]] == null
                                  ? null
                                  : Text(
                                      "${discoveredDevices[macAddresses[index]]?.rssi}",
                                      style: TextStyle(color: Colors.green),
                                    ),
                          trailing:
                              discoveredDevices[macAddresses[index]] == null
                                  ? FittedBox(
                                      child: SpinKitWave(
                                        color: Color(0xFFAC5749),
                                        size: 15.0,
                                      ),
                                    )
                                  : Text(
                                      "${discoveredDevices[macAddresses[index]]?.device.id}",
                                      style: TextStyle(
                                          color: Theming.instance.isLight
                                              ? Theming.instance
                                                  .Light["beaconTextListColor"]
                                              : Theming.instance
                                                  .Dark["beaconTextListColor"],
                                          fontSize: 15),
                                    ),
                          title: Text(
                            discoveredDevices[macAddresses[index]] == null
                                ? ""
                                : "${discoveredDevices[macAddresses[index]]?.device.name}",
                            style: TextStyle(
                                color: Theming.instance.isLight
                                    ? Theming
                                        .instance.Light["beaconTextListColor"]
                                    : Theming
                                        .instance.Dark["beaconTextListColor"]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
