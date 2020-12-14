import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class LearnCard extends StatefulWidget {
  final List<Flashcard> cards;
  LearnCard({@required this.cards});

  @override
  _LearnCardState createState() => _LearnCardState();
}

class _LearnCardState extends State<LearnCard> {
  String displayText;
  bool isFront;
  List<Flashcard> nextCards;

  @override
  void initState() {
    isFront = true;
    nextCards = widget.cards;
    nextCards.shuffle();
    displayText = nextCards[0].front;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
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
                ),
                onTap: () {
                  _updateCard();
                },

              ),
            ]
          ),
          _buildReflectionButtons()
        ]
      ),
    );
  }

  void _updateCard() {
    if(isFront == true) {
      setState(() {
        isFront = false;
        displayText = nextCards[0].back;
      });
    } else {
      setState(() {
        nextCards.removeAt(0);
        if(nextCards.isEmpty) {
          Navigator.of(context).pushReplacementNamed('/learn_overview');
        } else {
          isFront = true;
          displayText = nextCards[0].front;
        }
      });
    }
  }

  Widget _buildReflectionButtons() {
    if(isFront == true) {
      return Row();
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              child: Text('Good'),
              textColor: Colors.green,
              onPressed: () {},
            ),
            FlatButton(
              child: Text('OK'),
              textColor: Colors.orangeAccent,
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Bad'),
              textColor: Colors.red,
              onPressed: () {},
            )
          ]
      );
    }
  }
}