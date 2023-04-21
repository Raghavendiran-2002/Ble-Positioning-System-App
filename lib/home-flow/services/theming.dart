import 'dart:ui';

import 'package:flutter/material.dart';

class Theming {
  bool isLight = true;

  Map<String, Color> Light = {
    "scaffoldBackgroundColor": Color(0xFFEFEFE3),
    "navigationBarBackgroundColor": Color(0xFFAC5749),
    "navigationBarIndicatorColor": Color(0xFFABBDAF),
    "navigationBarIconColor": Colors.black,
    "snackBarBGcolor": Colors.white,
    "snackBarTextColor": Colors.black,
    "appBarTextColor": Color(0xFFABBDAF),
    "appBarBgColor": Color(0xFFAC5749),
    "welcomeTextColor": Color(0xFFAC5749),
    "beaconTextListColor": Colors.black,
    "beaconTileColor": Color(0xFFCBD8D2),
  };
  Map<String, Color> Dark = {
    "scaffoldBackgroundColor": Color(0xFF191B16),
    "navigationBarBackgroundColor": Color(0xFFAC5749),
    "navigationBarIndicatorColor": Color(0xFFABBDAF),
    "navigationBarIconColor": Colors.white,
    "snackBarBGcolor": Colors.white,
    "snackBarTextColor": Colors.black,
    "appBarTextColor": Colors.black,
    "appBarBgColor": Colors.white,
    "beaconTextListColor": Colors.white,
    "welcomeTextColor": Color(0xFFAC5749),
    "beaconTileColor": Color(0xFFD7F28E),
  };

  List<String> NavNames = ["Home", "GeoFencing", "Discovery", "Discovery"];

  Theming._();
  static final instance = Theming._();
}
