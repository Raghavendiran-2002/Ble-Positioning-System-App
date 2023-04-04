import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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
  final Map<String, ScanResult> discoveredDevices = {};

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

  void updateDevices(ScanResult result) {
    setState(() {
      discoveredDevices.update(result.device.id.toString(), (value) => result);
    });
  }

  void setStream(Stream<ScanResult> stream) async {
    stream.listen((event) {
      print("data received $event");
      setState(() {
        addDevices(event);
      });
    }, onDone: () async {
      // Scan is finished ****************
      await flutterBlue.stopScan();
      setState(() {
        isScanning = false;
      });
      print("Task Done");
      print("second scan");
      discoveredDevices.forEach((key, value) {
        print("${key} ${value.device.name} ${value.rssi}");
      });

      setStream(getScanStream()); // New scan
    }, onError: (Object e) {
      print("Some Error " + e.toString());
    });
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
                      margin: new EdgeInsets.all(16.0),
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
                // scanSpecificDevice();
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
              // Lottie.asset('assets/animations/scanning.json'),
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
                              borderRadius: BorderRadius.circular(20),
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
