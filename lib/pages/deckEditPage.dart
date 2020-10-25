import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/header.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckEditPage extends StatelessWidget {
  final Deck deck;

  DeckEditPage(this.deck);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(this.deck.title, [],
        IconButton(
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
