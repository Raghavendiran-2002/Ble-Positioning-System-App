import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoFencing extends StatefulWidget {
  const GeoFencing({Key? key}) : super(key: key);

  @override
  State<GeoFencing> createState() => _GeoFencingState();
}

class _GeoFencingState extends State<GeoFencing> {
  double distanceBtwBeacon = 0;
  List<double> currentLocation = [0.24, 0435.3];
  Position? position;
  bool isReady = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPosition();
    setState(() {
      distanceBtwBeacon = Geolocator.distanceBetween(
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
    setState(() {
      currentLocation[0] = position!.toJson()["longitude"];
      currentLocation[1] = position!.toJson()["latitude"];
    });

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
                  child: Text(
                    "latitude : ${currentLocation[1]}\nlongitude : ${currentLocation[0]}",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text("${distanceBtwBeacon}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
