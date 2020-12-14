import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/data/card_provider.dart';
import 'package:flutter_flashcards/models/flashcard.dart';
import 'cards.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardProvider cardProvider;
  CardBloc(this.cardProvider) : super(CardInitial());

  @override
  Stream<CardState> mapEventToState(CardEvent event) async* {
    yield CardsLoading();
    if(event is LoadCards) {
      yield* _reloadCards(event.deckId);
    } else if(event is UpdateCard) {
      await cardProvider.update(event.updatedCard);
      yield* _reloadCards(event.updatedCard.deckId);
    } else if(event is DeleteCard) {
      await cardProvider.delete(event.card.id);
      yield* _reloadCards(event.card.deckId);
    } else if(event is AddCard) {
      await cardProvider.insert(event.newCard);
      yield* _reloadCards(event.newCard.deckId);
    }
  }

  Stream<CardState> _reloadCards(int deckId) async* {
    final List<Flashcard> cards = await cardProvider.getFlashcardsFromDeck(deckId);
    yield CardsLoaded(cards);
  }
}