import 'package:flutter/material.dart';

TextStyle getTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: getFontSize(context),
  );
}

TextStyle getH1TextStyle(BuildContext context) {
  return TextStyle(fontSize: getH1FontSize(context));
}

double getH1FontSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return H1FontSize.desktop;
  if (deviceWidth > 600) return H1FontSize.tablet;
  if (deviceWidth > 300) return H1FontSize.phone;
  //throw Exception("Your screen so small, I don't support you, lol");
  return H1FontSize.phone;
}

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getFontSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return FontSize.desktop;
  if (deviceWidth > 600) return FontSize.tablet;
  if (deviceWidth > 300) return FontSize.phone;
  //throw Exception("Your screen so small, I don't support you, lol");
  return FontSize.phone;
}

class NotesListItemPadding {
  static const double desktop = 50;
  static const double tablet = 40;
  static const double phone = 25;
}

class H1FontSize {
  static const double desktop = 26;
  static const double tablet = 19;
  static const double phone = 13;
}

class FontSize {
  static const double desktop = 15;
  static const double tablet = 10;
  static const double phone = 5;
}