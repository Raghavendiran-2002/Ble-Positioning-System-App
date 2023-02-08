import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothPackage {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResult = [];
  var SERVICE_UUID = "1c4956ac-ec89-48dd-806e-47275a6f7f94";
  var CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  var deviceID = "94:B9:7E:D5:CD:F6";

  void scanSpecificDevice() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.id.toString() == deviceID) {
          if (!scanResult.contains(r)) {
            scanResult.add(r);
          } else {
            scanResult.insert(scanResult.indexOf(r), r);
          }
        }
      }
    });
  }

  void showAllDevices() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print(
            '${r.device.id.toString()} ${r.device.name}  found! rssi: ${r.rssi}');
        scanResult.add(r);
      }
    });
  }

  BluetoothPackage._();

  static final instance = BluetoothPackage._();
}
