import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/error/exceptions.dart';

class Deck extends Equatable{
  final String title;
  final int id;
  final int size;
  final int performance;

  Deck(this.title, {this.id, this.size, this.performance}) {
    if(title.isEmpty) {
      throw DeckException('There is no title specified.');
    }
  }

  factory Deck.fromMap(Map<String, dynamic> jsonMap) => Deck(jsonMap['title'],
    id: jsonMap['id'],
    size: jsonMap['size'],
    performance: jsonMap['performance'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'size': size,
    'performance': performance,
  };

  Deck copyWith({String title, String id, int size, int performance}) {
    return Deck(
      title ?? this.title,
      size: size ?? this.size,
      id: id ?? this.id,
      performance: performance ?? this.performance,
    );
  }

  @override
  List<Object> get props => [id, title, size, performance];
}