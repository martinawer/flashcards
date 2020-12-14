import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/error/exceptions.dart';
import 'package:flutter_flashcards/models/tag.dart';
import 'package:meta/meta.dart';

class Flashcard extends Equatable{

  final int id;
  final String type;
  final String front;
  final String back;
  final int deckId;
  Set<Tag> tags = {};

  Flashcard({
    this.id,
    this.type,
    this.front,
    this.back,
    @required this.deckId,
    tags
  }) {
    tags = this.tags;
    if(deckId == null || deckId == 0) {
      throw CardException('There is no valid deck_id specified.');
    }
  }

  factory Flashcard.fromMap(Map<String, dynamic> cardJson) => Flashcard(
    id: cardJson['id'],
    type: cardJson['type'],
    front: cardJson['front'],
    back: cardJson['back'],
    deckId: cardJson['deckId'],
    tags: cardJson['tags']
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'front': front,
    'back': back,
    'deckId': deckId,
    'tags': tags.toString()
  };

  @override
  List<Object> get props => [id, type, front, back, deckId, tags];
}