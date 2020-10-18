import 'package:flutter/material.dart';

class FlashCardTheme {
  ThemeData build(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.transparent,
      accentColor: Colors.red,

      fontFamily: 'Georgia',

      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500),
      )
    );
  }
}