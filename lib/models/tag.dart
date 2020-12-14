import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Tag extends Equatable{
  final String name;
  final Color color = Colors.deepPurple;

  Tag(this.name);

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(json['name']);

  Map<String, dynamic> toMap() => {
    'name': name,
  };

  @override
  List<Object> get props => [name];
}