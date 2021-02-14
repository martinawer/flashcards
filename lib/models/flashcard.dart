import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/error/exceptions.dart';

class Flashcard extends Equatable{

  final int id;
  final String type;
  final String front;
  final String back;
  final int deckId;

  Flashcard({
    this.id,
    this.type,
    this.front,
    this.back,
    @required this.deckId,
  }) {
    if(deckId == null || deckId == 0) {
      throw CardException('There is no valid deck_id specified.');
    }
  }

  factory Flashcard.fromMap(Map<String, dynamic> jsonMap) => Flashcard(
    id: jsonMap['id'],
    type: jsonMap['type'],
    front: jsonMap['front'],
    back: jsonMap['back'],
    deckId: jsonMap['deckId'],
  );

  Map<String, dynamic> toMap() => {
      'id': id,
      'type': type,
      'front': front,
      'back': back,
      'deckId': deckId,
  };

  @override
  List<Object> get props => [id, type, front, back, deckId];
}