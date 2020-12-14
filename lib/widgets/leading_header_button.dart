import 'package:flutter/material.dart';

class LeadingHeaderButton extends StatelessWidget {
  final Function onPressed;

  const LeadingHeaderButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('LeadingHeaderButton'),
      icon: Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () {
        if(onPressed == null) {
          Navigator.of(context).pop();
        } else {
          onPressed();
        }
      },
    );
  }
}
