import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/models/deck.dart';

///Events are Use cases of the module
abstract class DeckEvent extends Equatable {
  const DeckEvent();
}

class LoadDecks extends DeckEvent {
  const LoadDecks();

  @override
  List<Object> get props => [];
}

class AddDeck extends DeckEvent {
  final Deck newDeck;
  const AddDeck(this.newDeck);

  @override
  List<Object> get props => [newDeck];
}

class UpdateDeck extends DeckEvent {
  final Deck updatedDeck;
  const UpdateDeck(this.updatedDeck);

  @override
  List<Object> get props => [updatedDeck];
}

class DeleteDeck extends DeckEvent {
  final int deckId;
  const DeleteDeck(this.deckId);

  @override
  List<Object> get props => [deckId];
}