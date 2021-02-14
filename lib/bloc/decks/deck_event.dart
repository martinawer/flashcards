import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/models/deck.dart';

///Events are Use cases of the bloc
abstract class DeckEvent extends Equatable {
  const DeckEvent();
}

class GetDecks extends DeckEvent {
  const GetDecks();

  @override
  List<Object> get props => [];
}

class GetDeck extends DeckEvent {
  final int id;
  const GetDeck(this.id);

  @override
  List<Object> get props => [id];
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