import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';

class Flutter_Blue_Plus extends StatefulWidget {
  const Flutter_Blue_Plus({Key? key}) : super(key: key);

  @override
  State<Flutter_Blue_Plus> createState() => _Flutter_Blue_PlusState();
}

class _Flutter_Blue_PlusState extends State<Flutter_Blue_Plus> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  FlutterTts flutterTts = FlutterTts();
  Timer? timer;
  Map<String, String> beaconInfos = {
    "60:77:71:8E:74:1B": "img1",
    "60:77:71:8E:63:12": "shiva"
  };
  List<String> DeviceID = [
    // "94:B9:7E:D5:CD:F6",
    "60:77:71:8E:74:1B", // Beacon 1
    // "24:0A:C4:0B:2A:D2",
    "60:77:71:8E:63:12", // Beacon 2
    "72:7F:50:B3:92:E4"
  ];
  FlutterTts ftts = FlutterTts();

  List<bool> isVisited = [false, false];
  List<ScanResult> scanResult = [];
  bool isScanning = false;
  final stack = Stack<ScanResult>();

  // myStack.push('Green Eggs and Ham');
  // myStack.push('War and Peace');
  // myStack.push('Moby Dick');
  // while (myStack.isNotEmpty) {
  // print(myStack.pop());
  // }

  @override
  void initState() {
    super.initState();
    scanSpecificDevice();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      displayBeacon();
    });
  }

  @override
  void dispose() {
    // if (mounted) {
    //   timer?.cancel();
    //   flutterBlue.stopScan();
    //   super.dispose();
    // }
    timer?.cancel();
    flutterBlue.stopScan();
    super.dispose();
  }

  void displayBeacon() {
    scanSpecificDevice();
    if (scanResult.length == 1) {
      if (-50 < scanResult[0].rssi) {
        if (!isVisited[0]) {
          displaySnackBar(scanResult[0].device.name, "img1");
          speakText("image1");
          isVisited[0] = true;
        }
      }
    }
    if (scanResult.length == 2) {
      if (-40 < scanResult[1].rssi && -40 > scanResult[0].rssi) {
        if (!isVisited[1]) {
          displaySnackBar(scanResult[1].device.name, "img1");
          speakText("image1");
          isVisited[1] = true;
        }
      } else if (-40 < scanResult[0].rssi && -40 > scanResult[1].rssi) {
        if (!isVisited[0]) {
          displaySnackBar(scanResult[1].device.name, "shiva");
          speakText("image2");
          isVisited[0] = true;
        }
      }
    }
  }

  void speakText(String voice) async {
    var result = await ftts.speak(" ${voice}");
    if (result == 1) {
      //speaking
    } else {
      //not speaking
    }
  }

  void displaySnackBar(String message, String imgPath,
      {Color color = Colors.white, int durationInSeconds = 1}) {
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
                onPressed: () {},
                child: Text("Open"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Close")),
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

  void scanSpecificDevice() {
    flutterBlue.startScan(
        scanMode: ScanMode.lowPower,
        macAddresses: ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"],
        timeout: Duration(seconds: 2));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        // print("${r.device.name} ${r.rssi} ${r.device.id}");
        setState(() {
          isScanning = true;
        });
        if (r.device.id.toString() == DeviceID[0] ||
            r.device.id.toString() == DeviceID[1]) {
          if (stack.isEmpty) stack.push(r);
          if (stack.peek == r) {
            stack.pop();
            stack.push(r);
          }
          print("***************");
          print(stack.peek);
        }

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
                      scanSpecificDevice();
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
                    itemCount: scanResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading:
                              // Text("${BluetoothPackage.instance.scanResult[index].rssi}"),
                              Text(
                            "${scanResult[index].rssi}",
                            style: TextStyle(color: Colors.green),
                          ),
                          trailing: Text(
                            '${scanResult[index].device.id}',
                            // '${BluetoothPackage.instance.scanResult[index].device.id}',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          title: Text(
                              "${scanResult[index].device.name}"), // Text("${BluetoothPackage.instance.scanResult[index].device.name}"),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Lottie.asset('assets/animations/scanning.json'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();
  bool contains(K) => _list.contains(K);

  E get peek => _list.last;
  int get size => _list.length;
  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

// https://stackoverflow.com/questions/64060944/how-to-implement-a-stack-with-push-and-pop-in-dart
