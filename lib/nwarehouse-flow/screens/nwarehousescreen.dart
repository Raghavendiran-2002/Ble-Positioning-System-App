import 'package:ble_positioning_system/nwarehouse-flow/services/mqtt_service.dart';
import 'package:flutter/material.dart';

class NwareHouseScreen extends StatefulWidget {
  const NwareHouseScreen({Key? key}) : super(key: key);

  @override
  State<NwareHouseScreen> createState() => _NwareHouseScreenState();
}

class _NwareHouseScreenState extends State<NwareHouseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("HI"),
            ElevatedButton(
              onPressed: () {},
              child: Text(":hd"),
            )
          ],
        ),
      ),
    );
  }
}
