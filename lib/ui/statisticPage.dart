import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/ui/header.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader('Statistics', []),
    );
  }
}