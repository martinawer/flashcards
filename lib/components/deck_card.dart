import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckCard extends StatelessWidget {
  final Deck deck;
  DeckCard({this.deck}); //constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 300,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 3),
              child: Text(
                  this.deck.title,
                  style: Theme.of(context).textTheme.headline2
              ),
            ),
            Container(
              child: Text(
                'Cards: ${this.deck.size.toString()}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            ),
            Container(
              child: Text(
                'Performance: ${this.deck.performance.toString()}%',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            )
          ],
        )
      )
    );
  }
}