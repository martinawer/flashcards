import 'dart:async';

import 'package:flutter_flashcards/components/database.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class CardBloc {
  final int deckId;

  CardBloc(this.deckId) {
    getCards(this.deckId);
  }

  final _cardController = StreamController<List<Flashcard>>.broadcast();
  get cards => _cardController.stream;

  dispose() {
    _cardController.close();
  }

  getCards(int deckId) async {
    if(!_cardController.isClosed) {
      _cardController.sink.add(await DBProvider.db.getAllFlashCardsFromDeck(deckId));
    }
  }

  add(Flashcard card) async {
    DBProvider.db.newFlashcard(card);
    getCards(card.deckId);
  }

  update(Flashcard card) async {
    DBProvider.db.updateCard(card);
    getCards(card.deckId);
  }

  Future<bool> cardExistsInDeck(Flashcard card) async {
    var res = DBProvider.db.cardExists(card.id);
    if( res == null) {
      print('Empty');
      return false;
    }
    print('Not Empty');
    return true;
  }

  remove(Flashcard card) async {
    if(!_cardController.isClosed) {
      DBProvider.db.deleteCard(card.id);
      getCards(this.deckId);
    }
  }
}