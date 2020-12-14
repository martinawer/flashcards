import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

///Possible States the UI can be in
abstract class CardState extends Equatable {
  const CardState();
}

class CardInitial extends CardState {
  const CardInitial();

  @override
  List<Object> get props => [];
}

class CardsLoading extends CardState {
  const CardsLoading();

  @override
  List<Object> get props => [];
}

class CardsLoaded extends CardState {
  final List<Flashcard> cards;
  const CardsLoaded(this.cards);

  @override
  List<Object> get props => [cards];
}

class CardError extends CardState {
  final String message;
  const CardError(this.message);

  @override
  List<Object> get props => [message];

}