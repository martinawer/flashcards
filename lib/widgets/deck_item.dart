import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckItem extends StatelessWidget {
  final Deck deck;

  DeckItem({
    Key key,
    @required this.deck
  }) : super(key : key); //constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(deck.id.toString()),
      child: Container(
        width: 300,
        height: 100,
        child: Column(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              key: Key('deckTitle'),
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(deck.title,
                  style: Theme.of(context).textTheme.headline2
              ),
            ),
            Container(
              key: Key('deckSize'),
              child: Text('Cards: ${deck.size.toString()}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            ),
            Container(
              key: Key('deckPerformance'),
              child: Text('Performance: ${deck.performance.toString()}%',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            ),
          ],
        )
      )
    );
  }


}