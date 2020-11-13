import 'package:flutter/cupertino.dart';

class Deck {
  int id;
  String title;
  int size;
  int performance;

  Deck({@required this.title, this.id, this.size, this.performance}) {
    this.size = 0;
    this.performance = 0;
  }

  /// DB Conversions

  factory Deck.fromMap(Map<String, dynamic> json) => new Deck(
    id: json['id'],
    title: json['title'],
    size: json['size'],
    performance: json['performance'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'size': size,
    'performance': performance,
  };
}