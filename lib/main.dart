import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/Maddin/AndroidStudioProjects/flutter_flashcards/lib/pages/homePage.dart';
import 'package:flutter_flashcards/styles/themes.dart';

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
      theme: FlashCardTheme.standard,
      home: HomePage(),
    );
  }
}
