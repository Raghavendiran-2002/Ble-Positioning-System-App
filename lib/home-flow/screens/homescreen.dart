import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPopup = true;
  @override
  void initState() {
    setState(() {
      isPopup = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void displaySnackBar(String message,
      {Color color = Colors.white, int durationInSeconds = 2}) {
    SnackBar snackBar = SnackBar(
      content: Column(
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
          // Text(
          //   "jdhg",
          //   style: TextStyle(color: Colors.black),
          // ),
          Image.asset(
            'assets/images/img2.png',
            width: 200,
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Open"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Close")),
            ],
          )
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: durationInSeconds),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      isPopup = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    GoogleSignIn().signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "login", (Route<dynamic> route) => false);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              "Welcome To Smart\n Museum",
              style: Theme.of(context).textTheme.displayMedium,
              // style: TextStyle(fontFamily: "RobotoMono", fontSize: 25),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                print("pressed");
                if (isPopup) {
                  print("activated");
                  displaySnackBar("gdfshg");
                }
              },
              child: Text("JKDFHG"),
            ),
          ],
        ),
      ),
    );
  }
}
