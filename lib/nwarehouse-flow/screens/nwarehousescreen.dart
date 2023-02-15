import 'package:ble_positioning_system/nwarehouse-flow/services/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NwareHouseScreen extends StatefulWidget {
  const NwareHouseScreen({Key? key}) : super(key: key);

  @override
  State<NwareHouseScreen> createState() => _NwareHouseScreenState();
}

class _NwareHouseScreenState extends State<NwareHouseScreen> {
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mqtt.instance.setup();
    mqtt.instance.connect();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Text("MQTT"),
              FlutterSwitch(
                width: 125.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: status,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    mqtt.instance.nodePublish(!val);
                    status = val;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
