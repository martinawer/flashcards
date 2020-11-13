import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/leading_header_button.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics', style: Theme.of(context).appBarTheme.textTheme.headline1),
        leading: LeadingHeaderButton(),
      ),
      body: Center(
        child: Text('Statistics')
      )
    );
  }
}