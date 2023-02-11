import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:beacons_plugin/beacons_plugin.dart';


class Beacons_Plugin extends StatefulWidget {
  const Beacons_Plugin({Key? key}) : super(key: key);

  @override
  State<Beacons_Plugin> createState() => _Beacons_PluginState();
}

class _Beacons_PluginState extends State<Beacons_Plugin> {
  String _beaconResult = 'Not Scanned Yet.';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();ListenBeacons();

  }
void Ranging()async{
  BeaconsPlugin.addRegion("myBeacon", "01022022-f88f-0000-00ae-9605fd9bb620")
      .then((result) {
    print("gf");
  });

  //Send 'true' to run in background [OPTIONAL]
  // await BeaconsPlugin.runInBackground(true);

  //IMPORTANT: Start monitoring once scanner is setup & ready (only for Android)
  if (Platform.isAndroid) {
    BeaconsPlugin.channel.setMethodCallHandler((call) async {
      if (call.method == 'scannerReady') {
        print("HIIi");
        await BeaconsPlugin.startMonitoring();
      }
    });
  } else if (Platform.isIOS) {
    await BeaconsPlugin.startMonitoring();
  }

}
  void ListenBeacons(){

    final StreamController<String> beaconEventsController = StreamController<String>.broadcast();
    BeaconsPlugin.listenToBeacons(beaconEventsController);
    print("********************");
    beaconEventsController.stream.listen(
            (data) {
          if (data.isNotEmpty) {
            setState(() {
              _beaconResult = data;
            });
            print("Beacons DataReceived: " + data);
          }
        },
        onDone: () {},
        onError: (error) {
          print("Error: $error");
        });
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
