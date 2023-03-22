import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class FindBeacon {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<String> DeviceID = [
    "60:77:71:8E:74:1B", // Beacon 1
    "60:77:71:8E:63:12", // Beacon 2
    "72:7F:50:B3:92:E4"
  ];
  List<ScanResult> scanResult = [];

  bool scanSpecificDevice() {
    flutterBlue.startScan(
        scanMode: ScanMode.lowPower,
        macAddresses: ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"],
        timeout: Duration(seconds: 2));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        // print("${r.device.name} ${r.rssi} ${r.device.id}");
        if (r.device.id.toString() == DeviceID[0]) {
          // print("${r.device.name} ${r.rssi}");
          if (!scanResult.contains(r)) {
            scanResult.add(r);
          } else {
            scanResult[scanResult.indexOf(r)] = r;
          }
        } else if (r.device.id.toString() == DeviceID[1]) {
          // print("${r.device.name} ${r.rssi}");
          if (!scanResult.contains(r)) {
            scanResult.add(r);
          } else {
            scanResult[scanResult.indexOf(r)] = r;
          }
        }
      }
    });
    if (scanResult.length == 2 || scanResult.length == 1) return true;
    flutterBlue.stopScan();
    return false;
  }

  void FoundBeacon() {
    if (scanResult.length == 2) {
      print("Comparing");
      if (scanResult[0].rssi < scanResult[1].rssi) {
        print(scanResult[1].device.name);
        // displaySnackBar(scanResult[1].device.name, "shiva");
      } else if (scanResult[0].rssi > scanResult[1].rssi) {
        print(scanResult[0].device.name);
        // displaySnackBar(scanResult[0].device.name, "img1");
      }
    }
  }

  FindBeacon._();

  static final instance = FindBeacon._();
}
