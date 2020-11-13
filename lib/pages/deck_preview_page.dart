import 'package:flutter/cupertino.dart';
import 'package:flutter_flashcards/components/leading_header_button.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter/material.dart';

class DeckPreviewPage extends StatelessWidget {
  final Deck deck;
  DeckPreviewPage({@required this.deck});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.deck.title, style: Theme.of(context).appBarTheme.textTheme.headline1),
        leading: LeadingHeaderButton()
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Learn ${this.deck.title}', style: Theme.of(context).textTheme.headline2),
              SizedBox(height: 15),
              ButtonTheme(
                minWidth: 200,
                height: 46,
                child: RaisedButton.icon(
                  icon: Icon(Icons.play_arrow),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/learn', arguments: this.deck);
                  },
                  textColor: Colors.white,
                  label: Text('Learn',
                    style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              SizedBox(height: 8),
              ButtonTheme(
                minWidth: 200,
                height: 50,
                child: RaisedButton.icon(
                  icon: Icon(Icons.edit),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/edit', arguments: this.deck);
                  },
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