import 'package:flutter/material.dart';
import 'package:flutter_flashcards/ui/deck.dart';
import 'package:flutter_flashcards/ui/deckCard.dart';
import 'package:flutter_flashcards/ui/header.dart';
import 'package:flutter_flashcards/ui/settingsPage.dart';

class DeckListPage extends StatefulWidget {
  @override
  _DeckListPageState createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  final List<Deck> decks = [
    Deck(title: 'Piano', numberOfCards: 72, performance: 90),
    Deck(title: 'Physics', numberOfCards: 12, performance: 8)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader('Decks', [
        IconButton(
          icon: Icon(Icons.settings),
          color: Colors.blue,
          onPressed: () {
            navigateToSettings(context);
          },
        )
      ]),
      body: Column(
        children: decks.map((deck) => DeckCard(deck: deck)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          return showAddDeckDialog(context);
        },
      ),
    );
  }
}

showAddDeckDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Deck'),
          content: TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 0.5
                ),
              ),
              border: InputBorder.none,
              hintText: 'Deck Name: ',
            ),
          ),
          actions: [
            FlatButton(
              child: Text('Create'),
              onPressed: (){},
            ),
          ],
        );
      }
  );
}

Future navigateToSettings(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) =>
      SettingsPage()
  ));
}