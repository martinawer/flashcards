import 'package:flutter/material.dart';
import 'package:flutter_flashcards/widgets/leading_header_button.dart';

class LearnOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        leading: LeadingHeaderButton(),
      ),
      body: Container(
        child: Center(
          child: Text('This is your Result'),
        ),
      )
    );
  }
}
