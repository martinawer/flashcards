import 'package:flutter/material.dart';
import 'package:flutter_flashcards/ui/header.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader('Settings', [],
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () { Navigator.pop(context); },
      )),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
