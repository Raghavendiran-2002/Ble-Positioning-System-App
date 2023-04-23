import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BeaconDetection {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<String> macAddresses = ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"];
  bool isScanning = false;
  Map<String, ScanResult> discoveredDevices = {};
  List<bool> isDisplayed = [true, true];
  bool isEnteredBuilding = false;
  int snackBarID = 0;

  Stream<ScanResult> getScanStream() {
    isScanning = true;
    return flutterBlue.scan(
      timeout: Duration(seconds: 3),
      macAddresses: ["60:77:71:8E:74:1B", "60:77:71:8E:63:12"],
    );
  }

  void addDevices(ScanResult result) {
    discoveredDevices[result.device.id.toString()] = result;
  }

  setStream(Stream<ScanResult> stream) async {
    stream.listen((event) {
      // print("data received $event");

      addDevices(event);
    }, onDone: () async {
      // Scan is finished ****************
      // if (discoveredDevices.length == 2) {
      // compareBeacon(discoveredDevices[macAddresses[0]]!,
      //     discoveredDevices[macAddresses[1]]!);
      // } else {
      if (discoveredDevices[macAddresses[0]]?.device.name != null &&
          discoveredDevices[macAddresses[0]]!.rssi > -90) {
        isDisplayed[0] ? snackBarID = 1 : null;
        isEnteredBuilding = true;
        isDisplayed[0] = false;
      } // EmbeddedLab
      if (discoveredDevices[macAddresses[1]]?.device.name != null &&
          discoveredDevices[macAddresses[1]]!.rssi > -90) {
        isDisplayed[1] ? snackBarID = 2 : null;
        isEnteredBuilding = true;
        isDisplayed[1] = false;
      }
      await flutterBlue.stopScan();
      isScanning = false;
      print(discoveredDevices[macAddresses[0]]?.device.name);
      setStream(getScanStream()); // New scan
    }, onError: (Object e) {
      print("Some Error " + e.toString());
    });
  }

  BeaconDetection._();
  static final instance = BeaconDetection._();
}
