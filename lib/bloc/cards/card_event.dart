import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

///Events are Use cases of the bloc
abstract class CardEvent extends Equatable {
    const CardEvent();
}

class LoadCards extends CardEvent {
  final int deckId;
  const LoadCards(this.deckId);

  @override
  List<Object> get props => [deckId];
}

class AddCard extends CardEvent {
  final Flashcard newCard;
  const AddCard(this.newCard);

  @override
  List<Object> get props => [newCard];
}

class UpdateCard extends CardEvent {
  final Flashcard updatedCard;
  const UpdateCard(this.updatedCard);

  @override
  List<Object> get props => [updatedCard];
}

class DeleteCard extends CardEvent {
  final Flashcard card;
  const DeleteCard(this.card);

  @override
  List<Object> get props => [card];
}