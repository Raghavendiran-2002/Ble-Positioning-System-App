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
  List<ScanResult> scanResult = [];

  @override
  void initState() {
    super.initState();
    // BluetoothPackage.instance.scanSpecificDevice();
    scanSpecificDevice();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      print("********************");
      scanSpecificDevice();
      // BluetoothPackage.instance.scanSpecificDevice();
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
        if (r.device.id.toString() == "94:B9:7E:D5:CD:F6") {
          if (scanResult.isEmpty) {
            scanResult.add(r);
          } else {
            setState(() {
              scanResult[0] = r;
            });
          }
        }
      }
    });
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: scanResult.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
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
            );
          },
        ),
      ),
    );
  }
}
