import 'package:flutter/material.dart';

class LeadingHeaderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () { Navigator.of(context).pop(); },
    );
  }
}
