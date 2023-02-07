import 'package:flutter/material.dart';
import '../services/flutter_ble_service.dart';

class Flutter_Blue_Plus extends StatefulWidget {
  const Flutter_Blue_Plus({Key? key}) : super(key: key);

  @override
  State<Flutter_Blue_Plus> createState() => _Flutter_Blue_PlusState();
}

class _Flutter_Blue_PlusState extends State<Flutter_Blue_Plus> {

  @override
  void initState() {
    BluetoothPackage.instance.discoverDevice();
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Center(child: Text("Hi")),));
  }
}
