import 'package:ble_positioning_system/nwarehouse-flow/services/mqtt.dart';
import 'package:ble_positioning_system/nwarehouse-flow/services/mqtt_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NwareHouseScreen extends StatefulWidget {
  const NwareHouseScreen({Key? key}) : super(key: key);

  @override
  State<NwareHouseScreen> createState() => _NwareHouseScreenState();
}

class _NwareHouseScreenState extends State<NwareHouseScreen> {
  bool triggerNode = false;
  List<bool> nodeLED = [false, false];
  bool isMQTTConnected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mqtt_local.instance.connect();
    isMQTTConnected = mqtt_local.instance.checkMQTT();
    // mqtt.instance.connect();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Text("Activate Node"),
              FlutterSwitch(
                width: 125.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: triggerNode,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    mqtt.instance.nodePublish(!val);
                    triggerNode = val;
                  });
                },
              ),
              Container(
                height: 10,
                width: 10,
                color: isMQTTConnected ? Colors.green : Colors.red,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                child:
                    Text('${isMQTTConnected ? "Connected" : "Disconnected"}'),
              ),
              Text("Node Alert LED"),
              Text(
                "RED LED",
                style: TextStyle(fontSize: 20),
              ),
              FlutterSwitch(
                width: 125.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: nodeLED[0],
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    mqtt_local.instance.publish("esp32/led", !val, "red");
                    nodeLED[0] = val;
                  });
                },
              ),
              Text(
                "GREEN LED",
                style: TextStyle(fontSize: 20),
              ),
              FlutterSwitch(
                width: 125.0,
                height: 55.0,
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: nodeLED[1],
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    mqtt_local.instance.publish("esp32/led", !val, "green");
                    nodeLED[1] = val;
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
