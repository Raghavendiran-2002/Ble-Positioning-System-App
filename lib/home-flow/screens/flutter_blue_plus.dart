import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Flutter_Blue_Plus extends StatefulWidget {
  const Flutter_Blue_Plus({Key? key}) : super(key: key);

  @override
  State<Flutter_Blue_Plus> createState() => _Flutter_Blue_PlusState();
}

class _Flutter_Blue_PlusState extends State<Flutter_Blue_Plus> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  Timer? timer;
  List<String> DeviceID = ["94:B9:7E:D5:CD:F6", "24:0A:C4:0B:2A:D2"];
  List<ScanResult> scanResult = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    scanSpecificDevice();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      isScanning ? scanSpecificDevice() : null;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void scanSpecificDevice() {
    flutterBlue.startScan(timeout: Duration(seconds: 1));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print("Running");
        setState(() {
          isScanning = true;
        });
        if (r.device.id.toString() == DeviceID[0]) {
          // print("${r.device.name} ${r.rssi}");
          if (!scanResult.contains(r)) {
            scanResult.add(r);
          } else {
            setState(() {
              scanResult[scanResult.indexOf(r)] = r;
            });
          }
        } else if (r.device.id.toString() == DeviceID[1]) {
          // print("${r.device.name} ${r.rssi}");
          if (!scanResult.contains(r)) {
            scanResult.add(r);
          } else {
            setState(() {
              scanResult[scanResult.indexOf(r)] = r;
            });
          }
        }
      }
    });
    flutterBlue.stopScan();
    setState(() {
      isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(
                      color: Colors.blue.shade400,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text("${isScanning ? "Active" : "Inactive"}"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: IconButton(
                          color: Colors.blueAccent,
                          onPressed: () {
                            scanSpecificDevice();
                          },
                          icon: Icon(Icons.refresh),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListTileTheme(
                  iconColor: Colors.red,
                  textColor: Colors.black54,
                  tileColor: Colors.yellow[100],
                  style: ListTileStyle.list,
                  dense: true,
                  child: ListView.builder(
                    itemCount: scanResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: ListTile(
                          leading:
                              // Text("${BluetoothPackage.instance.scanResult[index].rssi}"),
                              Text("${scanResult[index].rssi}"),
                          trailing: Text(
                            '${scanResult[index].device.id}',
                            // '${BluetoothPackage.instance.scanResult[index].device.id}',
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text(
                              "${scanResult[index].device.name}"), // Text("${BluetoothPackage.instance.scanResult[index].device.name}"),
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
