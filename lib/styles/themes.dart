import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlashCardTheme {
  static ThemeData standard = new ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline1: TextStyle(fontFamily: 'Merriweather', fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
      )
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontFamily: 'Merriweather', fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
      headline2: TextStyle(fontFamily: 'Merriweather', fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
      bodyText1: TextStyle(fontFamily: 'Montserrat', fontSize: 18, color: Colors.black26),
    ),
  );
}