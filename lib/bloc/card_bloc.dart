import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/card_event.dart';
import 'package:flutter_flashcards/bloc/card_state.dart';
import 'package:flutter_flashcards/data/card_provider.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardProvider cardProvider;

  CardBloc(this.cardProvider) : super(CardInitial());

  @override
  Stream<CardState> mapEventToState(CardEvent event) async* {
    yield CardsLoading();
    if(event is LoadCards) {
      yield* _reloadCards(event.deckId);
    } else if(event is UpdateCard) {
      await cardProvider.updateCard(event.updatedCard);
      yield* _reloadCards(event.updatedCard.deckId);
    } else if(event is DeleteCard) {
      await cardProvider.deleteCard(event.card.id);
      yield* _reloadCards(event.card.deckId);
    } else if(event is AddCard) {
      await cardProvider.newFlashcard(event.newCard);
      yield* _reloadCards(event.newCard.deckId);
    }
  }

  Stream<CardState> _reloadCards(int deckId) async* {
    final cards = await cardProvider.getAllFlashCardsFromDeck(deckId);
    yield CardsLoaded(cards);
  }
}