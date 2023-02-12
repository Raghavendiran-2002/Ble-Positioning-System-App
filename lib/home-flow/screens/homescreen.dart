import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Schools',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, "/");
        break;
      case 1:
        Navigator.pushNamed(context, "GeoFencing");
        break;
      case 2:
        Navigator.pushNamed(context, "flutterBluePlus");
        break;
      case 3:
        Navigator.pushNamed(context, "flutter_bluetooth_serial");
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.museum,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bluetooth_audio_sharp,
                color: Colors.black,
              ),
              label: 'GeoFencing',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_bluetooth_sharp,
                color: Colors.black,
              ),
              label: 'Discovery',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.navigation_outlined,
                color: Colors.black,
              ),
              label: 'Discovery',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
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
