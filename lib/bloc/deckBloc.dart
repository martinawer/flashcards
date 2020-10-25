import 'dart:async';

import 'package:flutter_flashcards/components/database.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckBloc {
  DeckBloc() {
    getDecks();
  }

  final _deckController = StreamController<List<Deck>>.broadcast();
  get decks => _deckController.stream;

  dispose() {
    _deckController.close();
  }

  getDecks() async {
    _deckController.sink.add(await DBProvider.db.getAllDecks());
  }

  add(Deck deck) async {
    DBProvider.db.newDeck(deck);
    getDecks();
  }
}