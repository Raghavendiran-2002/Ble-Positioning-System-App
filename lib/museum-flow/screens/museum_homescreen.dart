import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Museum extends StatefulWidget {
  const Museum({Key? key}) : super(key: key);

  @override
  State<Museum> createState() => _MuseumState();
}

class _MuseumState extends State<Museum> {
  String beaconAvailable = "NO BEACONS FOUND";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "WELCOME TO MUSEUM",
                // style: Theme.of(context).textTheme.displayMedium,
                style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontSize: 30,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text("${beaconAvailable}"),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: ["img1", "shiva"].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(
                          "assets/images/${i}.png",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
