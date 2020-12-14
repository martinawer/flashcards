import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/error/exceptions.dart';
import 'tag.dart';

class Deck extends Equatable{
  final String title;
  final int id;
  final int size;
  final int performance;
  List<Tag> tags;


  Deck(this.title, {this.id, this.size, this.performance, this.tags}) {
    if(title.isEmpty) {
      throw DeckException('There is no title specified.');
    }
  }

  factory Deck.fromMap(Map<String, dynamic> jsonMap) {
    var list = jsonMap['tags'] as List;
    List<Tag> tags;

    if(list != null) {
      tags = list.map((tag) => Tag.fromMap(tag)).toList();
    } else {
      tags = [];
    }

    return Deck(jsonMap['title'],
        id: jsonMap['id'],
        size: jsonMap['size'],
        performance: jsonMap['performance'],
        tags: tags
    );
  }

  Deck copyWith({String title, String id, int size, int performance}) {
    return Deck(
      title ?? this.title,
      size: size ?? this.size,
      id: id ?? this.id,
      performance: performance ?? this.performance,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'size': size,
    'performance': performance,
    'tags': tags
  };

  @override
  List<Object> get props => [id, title, size, performance, tags];
}