import 'package:flutter/cupertino.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/header.dart';
import 'deckEditPage.dart';

class DeckDetailsPage extends StatelessWidget {
  final Deck deck;

  DeckDetailsPage(this.deck);

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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Learn ${this.deck.title}',
                  style: Theme.of(context).textTheme.headline2),
                SizedBox(
                    height: 15
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 46,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.play_arrow),
                    color: Colors.green,
                    onPressed: () => print('yes'),
                    textColor: Colors.white,
                    label: Text('Learn',
                      style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                SizedBox(
                  height: 8
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton.icon(
                    icon: Icon(Icons.edit),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DeckEditPage(this.deck) )),
                    label: Text('Edit',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
              ]
          ),
        )
      )
    );
  }
}