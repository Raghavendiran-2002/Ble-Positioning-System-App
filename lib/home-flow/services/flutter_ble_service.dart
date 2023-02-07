
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
class BluetoothPackage {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  void discoverDevice() async {
      flutterBlue.startScan(timeout: Duration(seconds: 1));
      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          print('name : ${r.device.name} id : ${r.device.id}  found! rssi: ${r.rssi}');
          // if (r.device.name.toString() == "ESP32" ) {
          //     print(r.rssi);
          //     print("************************");
          // }
        }
      });
  }

  BluetoothPackage._();

  static final instance = BluetoothPackage._();
}