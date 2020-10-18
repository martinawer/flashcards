import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flashcards/ui/homePage.dart';

void main() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

  runApp(FlashCardsApp());
}

class FlashCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(fontFamily: 'Josefin Sans'),
      home: HomePage(),
    );
  }
}
