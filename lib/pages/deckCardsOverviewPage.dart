import 'package:flutter/material.dart';
import 'package:flutter_flashcards/bloc/cardBloc.dart';
import 'package:flutter_flashcards/components/flashCard.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

import 'flashcardEditPage.dart';

class DeckCardsOverviewPage extends StatefulWidget {
  Deck deck;
  DeckCardsOverviewPage(this.deck);

  @override
  _DeckCardsOverviewPageState createState() => _DeckCardsOverviewPageState();
}

class _DeckCardsOverviewPageState extends State<DeckCardsOverviewPage> {
  CardBloc cardBloc;

  @override
  void initState() {
    super.initState();
    cardBloc = new CardBloc(widget.deck.id);
  }

  @override
  void dispose() {
    super.dispose();
    this.cardBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.deck.title, style: Theme.of(context).appBarTheme.textTheme.headline1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () { Navigator.pop(context); },
          )
      ),
      body: StreamBuilder<List<Flashcard>>(
        stream: cardBloc.cards,
        builder: (BuildContext context, AsyncSnapshot<List<Flashcard>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                Flashcard item = snapshot.data[index];
                return InkWell(
                  child: FlashCardComponent(item),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CardEditPage(item.deckId, card: item)))
                      .then((updatedCard) => cardBloc.update(updatedCard)),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
            CardEditPage(widget.deck.id))).then((newCard) => { cardBloc.add(newCard)});
        },
      ),
    );
  }
}