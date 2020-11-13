import 'package:flutter/material.dart';

class LearnCard extends StatefulWidget {
  final String text;
  LearnCard({@required this.text});

  @override
  _LearnCardState createState() => _LearnCardState();
}

class _LearnCardState extends State<LearnCard> {
  String displayText;

  @override
  void initState() {
    super.initState();
    displayText = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.fromLTRB(0, 70, 0, 50),
      width: MediaQuery.of(context).size.height * 0.50,
      height: MediaQuery.of(context).size.width * 0.70,
      child: Card(
        elevation: 2,
        child: Center(
          child: Text(displayText),
        ),
      ),
    );
  }
}
