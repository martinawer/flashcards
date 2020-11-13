import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/leading_header_button.dart';

class Error404Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Page Not Found', style: Theme.of(context).appBarTheme.textTheme.headline1),
          leading: LeadingHeaderButton()
      ),
    );
  }
}
