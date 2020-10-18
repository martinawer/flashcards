import 'deck.dart';
import 'package:flutter/material.dart';
import 'header.dart';

class DeckDetailsPage extends StatefulWidget {


  @override
  _DeckDetailsPageState createState() => _DeckDetailsPageState();
}

class _DeckDetailsPageState extends State<DeckDetailsPage> {
  Deck deck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(deck.title, []),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (deck != null) ...[
              Text(deck.title, style: TextStyle(fontSize: 25)),
              Text('${deck.numberOfCards}\n${deck.performance}%',
                  style: TextStyle(fontSize: 20)),
            ],
          ],
        ),
      ),
    );
  }
}