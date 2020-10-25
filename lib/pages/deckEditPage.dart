import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckEditPage extends StatelessWidget {
  final Deck deck;

  DeckEditPage(this.deck);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.deck.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () { Navigator.pop(context); },
        )
      ),
      body: Container(
        color: Colors.white,
        // child: GridView.count(
        //   crossAxisCount: 2,
        //   children: //this.deck.cards.map((card) => FlashCard(card)).toList(),
        // )
      ),
    );
  }
}
