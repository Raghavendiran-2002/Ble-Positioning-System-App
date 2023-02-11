import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoFencing extends StatefulWidget {
  const GeoFencing({Key? key}) : super(key: key);

  @override
  State<GeoFencing> createState() => _GeoFencingState();
}

class _GeoFencingState extends State<GeoFencing> {
  double currentLocation = 0;
  Position? position;
  bool isReady = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPosition();
    setState(() {
      currentLocation = Geolocator.distanceBetween(
          10.7797701, 79.1738468, 10.7797702, 79.1738485);
      // print(Geolocator.distanceBetween(
      //     10.7797702, 79.1738463, 10.7797701, 79.1738468));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("LOCATION => ${position!.toJson()}");
    isReady = (position != null) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: [
                Text("${currentLocation}"),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue.shade100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                  child: Text("Hi"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
