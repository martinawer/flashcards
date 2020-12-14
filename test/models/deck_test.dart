import 'dart:convert';

import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

  void main() {
  final Map<String, dynamic> jsonMap = json.decode(fixture('deck.json'));
  final Deck deck = Deck('Test',
      id: 1,
      performance: 0,
      size: 0,
      tags: [],

  );

  test('fromMap() should convert JSON values to deck', () {
    final result = Deck.fromMap(jsonMap);
    expect(result.toMap(), deck.toMap());
  });

  test('toMap() should convert a deck to a valid JSON string', () {
    final result = deck.toMap();
    expect(result, jsonMap);
  });
}