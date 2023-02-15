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
  List<String> DeviceID = [
    "94:B9:7E:D5:CD:F6",
    "24:0A:C4:0B:2A:D2",
    "72:7F:50:B3:92:E4"
  ];
  List<ScanResult> scanResult = [];
  bool isScanning = false;
  late bool isActive;
  @override
  void initState() {
    super.initState();
    isActive = true;
    scanSpecificDevice();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      scanSpecificDevice();
      // if (scanResult.length == 2 && isActive && isScanning) {
      if (scanResult.length == 3 && isActive) {
        print("Comparing");
        if (scanResult[0].rssi < scanResult[1].rssi) {
          displaySnackBar(scanResult[1].device.name, "img1");
        } else if (scanResult[0].rssi > scanResult[1].rssi) {
          displaySnackBar(scanResult[0].device.name, "img2");
        }
        isActive = false;
      }
      // isScanning ? null : scanSpecificDevice();
    });
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      setState(() {
        isActive = true;
      });
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

  void displaySnackBar(String message, String imgPath,
      {Color color = Colors.white, int durationInSeconds = 2}) {
    SnackBar snackBar = SnackBar(
      content: Column(
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "jdhg",
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

  void scanSpecificDevice() {
    flutterBlue.startScan(timeout: Duration(seconds: 1));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        // print("Running");
        // print("${r.device.name} ${r.rssi} ${r.device.id}");
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
        } else if (r.device.id.toString() == DeviceID[2]) {
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
                          shape: RoundedRectangleBorder(
                            //<-- SEE HERE
                            side: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
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
