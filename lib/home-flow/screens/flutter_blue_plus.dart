import 'package:ble_positioning_system/home-flow/services/flutter_ble_service.dart';
import 'package:flutter/material.dart';

class Flutter_Blue_Plus extends StatefulWidget {
  const Flutter_Blue_Plus({Key? key}) : super(key: key);

  @override
  State<Flutter_Blue_Plus> createState() => _Flutter_Blue_PlusState();
}

class _Flutter_Blue_PlusState extends State<Flutter_Blue_Plus> {
  @override
  void initState() {
    super.initState();
    BluetoothPackage.instance.scanSpecificDevice();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: BluetoothPackage.instance.scanResult.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading:
                  Text("${BluetoothPackage.instance.scanResult[index].rssi}"),
              trailing: Text(
                '${BluetoothPackage.instance.scanResult[index].device.id}',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              title: Text(
                  "${BluetoothPackage.instance.scanResult[index].device.name}"),
            );
          },
        ),
      ),
    );
  }
}
