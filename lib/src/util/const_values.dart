import 'package:flutter/material.dart';

abstract class Styles {
  static const TextStyle toolbarItemName = TextStyle(
    color: Colors.black87,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontFamily: "Liberation Sans"
  );

  static const TextStyle settingsTitleName = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontFamily: "Liberation Sans"
  );

  static const TextStyle titleName = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontFamily: "Liberation Sans"
  );

  static const TextStyle taskTitleName = TextStyle(
    color: Colors.black87,
    fontSize: 17,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal
  );

  static const TextStyle timeName = TextStyle(
    color: Colors.black87,
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal
  );
}