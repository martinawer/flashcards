import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_flashcards/widgets/leading_header_button.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  ErrorPage(this.message, {
    Key key,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(message, style: Theme.of(context).appBarTheme.textTheme.headline1),
          leading: LeadingHeaderButton()
      ),
    );
  }
}
