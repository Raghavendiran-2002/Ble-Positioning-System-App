import 'dart:ui';

import 'package:flutter/material.dart';

class Theming {
  bool isLight = true;

  Map<String, Color> Light = {
    "scaffoldBackgroundColor": Color(0xFFDEDDDE),
    "navigationBarBackgroundColor": Color(0xFFF6F6F6),
    "navigationBarIndicatorColor": Color(0xFFB6ACCA),
    "navigationBarIconColor": Color(0xFF6F50C3),
    "snackBarBGcolor": Color(0xFFF6F6F6),
    "snackBarTextColor": Color(0xFF6F50C3),
    "appBarTextColor": Color(0xFF6F50C3),
    "appBarBgColor": Color(0xFFDEDDDE),
    "welcomeTextColor": Color(0xFF6F50C3),
    "beaconTextListColor": Colors.black,
    "beaconTileColor": Color(0xFFF6F6F6),
  };
  Map<String, Color> Dark = {
    "scaffoldBackgroundColor": Color(0xFF282828),
    "navigationBarBackgroundColor": Color(0xFF37256C),
    "navigationBarIndicatorColor": Color(0xFF282828),
    "navigationBarIconColor": Colors.white,
    "snackBarBGcolor": Color(0xFF282828),
    "snackBarTextColor": Color(0xFFEBEAEB),
    "appBarTextColor": Colors.white,
    "appBarBgColor": Color(0xFF37256C),
    "beaconTextListColor": Color(0xFF37256C),
    "welcomeTextColor": Color(0xFFA393C8),
    "beaconTileColor": Color(0xFFEBEAEB),
  };

  List<String> NavNames = ["Home", "GeoFencing", "Discovery", "Discovery"];

  Theming._();
  static final instance = Theming._();
}
