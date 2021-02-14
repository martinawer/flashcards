import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Tag extends Equatable{
  final int id;
  final int deck_id;
  final String name;
  final Color color = Colors.deepPurple;

  Tag(this.name, {this.id, @required this.deck_id});

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(json['name'],
      id: json['id'],
      deck_id: json['deck_id']
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'deck_id': deck_id
  };

  @override
  List<Object> get props => [id, name, deck_id];
}