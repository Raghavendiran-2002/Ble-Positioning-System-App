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
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      scanSpecificDevice();
      // isScanning ? null : scanSpecificDevice();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      timer?.cancel();
      flutterBlue.stopScan();
      super.dispose();
    }
  }

  void scanSpecificDevice() {
    flutterBlue.startScan(timeout: Duration(seconds: 1));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        // print("Running");
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

  String CompareNode(node1, node2) {
    if (node1 < node2) {
      return "Node1";
    }
    return "Node2";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: isScanning
              ? Text('Discovering devices')
              : Text('Discovered devices'),
          actions: <Widget>[
            isScanning
                ? FittedBox(
                    child: Container(
                      margin: new EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(Icons.replay),
                    onPressed: () {
                      flutterBlue.stopScan();
                      scanSpecificDevice();
                    },
                  )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color:
                      isScanning ? Colors.green.shade200 : Colors.red.shade200,
                  border: Border.all(
                    color: Colors.blue.shade400,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "${isScanning ? "Active" : "Inactive"}",
                    textAlign: TextAlign.center,
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
                        padding: EdgeInsets.only(top: 10, bottom: 10),
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
              // Text("${CompareNode(scanResult[0].rssi, scanResult[1].rssi)}")
            ],
          ),
        ),
      ),
    );
  }
}
