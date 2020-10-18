import 'package:flutter/material.dart';
import 'package:flutter_flashcards/ui/deck.dart';
class DeckCard extends StatelessWidget {
    final Deck deck;
    DeckCard({this.deck}); //constructor

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Card(
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
                      style: TextStyle(fontSize: 24, letterSpacing: 0.4, color: Colors.blueGrey)
                  ),
                ),
                Container(
                  child: Text(
                    'Cards: ${this.deck.numberOfCards.toString()}',
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                ),
                Container(
                  child: Text(
                    'Performance: ${this.deck.performance.toString()}%',
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                )
              ],
            )
          )
        )
      );
    }
}