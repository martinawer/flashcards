import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/deck_event.dart';
import 'package:flutter_flashcards/bloc/deck_state.dart';
import 'package:flutter_flashcards/data/deck_provider.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckProvider deckProvider;

  DeckBloc(this.deckProvider) : super(DeckInitial());

  @override
  Stream<DeckState> mapEventToState(DeckEvent event) async* {
    yield DecksLoading();
    if(event is LoadDecks) {
      yield* _reloadDecks();
    } else if(event is AddDeck) {
      await deckProvider.newDeck(event.newDeck);
      yield* _reloadDecks();
    } else if(event is UpdateDeck) {
      await deckProvider.updateDeck(event.updatedDeck);
      yield* _reloadDecks();
    } else if(event is DeleteDeck) {
      await deckProvider.deleteDeck(event.deckId);
      yield* _reloadDecks();
    }
  }

  Stream<DeckState> _reloadDecks() async* {
    final decks = await deckProvider.getAllDecks();
    yield DecksLoaded(decks);
  }

}