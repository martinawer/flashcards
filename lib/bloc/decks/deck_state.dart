import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/models/deck.dart';

///Possible States the UI can be in
abstract class DeckState extends Equatable {
  const DeckState();
}

class DeckInitial extends DeckState {
  const DeckInitial();

  @override
  List<Object> get props => [];
}

class DecksLoading extends DeckState {
  const DecksLoading();

  @override
  List<Object> get props => [];
}

class DecksLoaded extends DeckState {
  final List<Deck> decks;
  const DecksLoaded(this.decks);

  @override
  List<Object> get props => [decks];
}

class DeckLoaded extends DeckState {
  final Deck deck;
  const DeckLoaded(this.deck);

  @override
  List<Object> get props => [deck];
}


class DeckError extends DeckState {
  final String message;
  const DeckError(this.message);

  @override
  List<Object> get props => [message];

}