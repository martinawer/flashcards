import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/leading_header_button.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: Theme.of(context).appBarTheme.textTheme.headline1),
        leading: LeadingHeaderButton()
      ),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
