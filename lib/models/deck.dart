import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Deck {

  int id;
  String title;
  int size;
  int performance;
  //List<CustomCard> cards;

  Deck({this.id, @required this.title, this.size, this.performance}) {
    this.size = 0;
    this.performance = 0;
  }


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

Deck deckFromJson(String str) {
  final jsonData = json.decode(str);
  return Deck.fromMap(jsonData);
}

String deckToJson(Deck data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}