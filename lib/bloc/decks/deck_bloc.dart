import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_flashcards/bloc/decks/decks.dart';
import 'package:flutter_flashcards/data/deck_provider.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckProvider deckProvider;

  DeckBloc(this.deckProvider) : super(DeckInitial());

  @override
  Stream<DeckState> mapEventToState(DeckEvent event) async* {
    yield DecksLoading();
    if(event is GetDecks) {
      yield* _reloadDecks();
    } else if(event is AddDeck) {
      await deckProvider.create(event.newDeck);
      yield* _reloadDecks();
    } else if(event is UpdateDeck) {
      await deckProvider.update(event.updatedDeck);
      yield* _reloadDecks();
    } else if(event is DeleteDeck) {
      await deckProvider.delete(event.deckId);
      yield* _reloadDecks();
    } else if(event is GetDeck) {
      Deck deck = await deckProvider.get(event.id);
      yield DeckLoaded(deck);
    }
  }

  Stream<DeckState> _reloadDecks() async* {
    final List<Deck> decks = await deckProvider.getAll();
    yield DecksLoaded(decks);
  }
}