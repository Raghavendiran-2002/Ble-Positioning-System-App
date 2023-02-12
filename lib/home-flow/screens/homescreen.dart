import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              style: TextStyle(fontFamily: "RobotoMono", fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
