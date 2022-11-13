import 'package:flutter/material.dart';
import 'const_values.dart';

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

String toString(Duration duration) {
    var microseconds = duration.inMilliseconds;

    var hours = microseconds ~/ Duration.microsecondsPerHour;
    microseconds = microseconds.remainder(Duration.microsecondsPerHour);

    if (microseconds < 0) microseconds = -microseconds;

    var minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

    var minutesPadding = minutes < 10 ? "0" : "";

    var seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    var secondsPadding = seconds < 10 ? "0" : "";
    
    return "$hours:"
        "$minutesPadding$minutes:"
        "$secondsPadding";
  }