import 'dart:async';

import 'package:ble_positioning_system/sastra-flow/screens/embeddedinfo.dart';
import 'package:ble_positioning_system/sastra-flow/screens/sastrainfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lottie/lottie.dart';

class CustomBLE extends StatefulWidget {
  const CustomBLE({Key? key}) : super(key: key);

  @override
  State<CustomBLE> createState() => _CustomBLEState();
}

class _CustomBLEState extends State<CustomBLE> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  Timer? timer;
  List<String> macAddresses = ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"];
  bool isScanning = false;
  Map<String, ScanResult> discoveredDevices = {};
  bool isEnteredBuilding = false;
  List<bool> isDisplayed = [true, true];
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
      if (discoveredDevices.length == 2) {
        print(discoveredDevices.length);
        compareBeacon(discoveredDevices[macAddresses[0]]!,
            discoveredDevices[macAddresses[1]]!);
      } else {
        if (discoveredDevices[macAddresses[0]]?.device.name != null &&
            discoveredDevices[macAddresses[0]]!.rssi > -45) {
          isDisplayed[0]
              ? displaySnackBar(
                  "${discoveredDevices[macAddresses[0]]!.device.name}", "img1")
              : null;
          isEnteredBuilding = true;
          isDisplayed[0] = false;
        }
      }
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
    if (r1.rssi > -60) {
      isDisplayed[0] ? displaySnackBar("${r1.device.name}", "tifac") : null;
      isEnteredBuilding = true;
      isDisplayed[0] = false;
    }
    if (r2.rssi > -60 && isEnteredBuilding) {
      isDisplayed[1]
          ? displaySnackBar("${r2.device.name}", "EmbeddedLab")
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

  void displaySnackBar(String message, String imgPath,
      {Color color = Colors.white, int durationInSeconds = 5}) {
    SnackBar snackBar = SnackBar(
      content: Column(
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.black),
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
                child: Text("Open"),
              ),
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: Text("Close")),
            ],
          )
        ],
      ),
      backgroundColor: Color(0xFFF6F5EE),
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
          backgroundColor: Colors.white,
          title: isScanning
              ? Text(
                  'Discovering devices',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              : Text(
                  'Discovered devices',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
          actions: <Widget>[
            isScanning
                ? FittedBox(
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
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
                Icons.cancel,
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
                  fontFamily: "RobotoMono",
                  fontSize: 30,
                  color: Color(0xFFAC5749),
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
              Expanded(
                  flex: 1,
                  child: Lottie.asset('assets/animations/scanning.json')),
              Expanded(
                child: ListTileTheme(
                  iconColor: Colors.red,
                  textColor: Colors.black54,
                  tileColor: Color(0xFFCBD8D2),
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
                            leading: Text(
                              "${discoveredDevices[macAddresses[index]]?.rssi}",
                              style: TextStyle(color: Colors.green),
                            ),
                            trailing: Text(
                              "${discoveredDevices[macAddresses[index]]?.device.id}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            title: Text(
                              "${discoveredDevices[macAddresses[index]]?.device.name}",
                            )),
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
