import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      ),
    );
  }
}