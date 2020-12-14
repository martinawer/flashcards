import 'dart:convert';

import 'package:flutter_flashcards/models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final Map<String, dynamic> jsonMap = json.decode(fixture('flashcard.json'));
  final Flashcard flashcard = Flashcard(id: null, front: 'test front', back: 'test back', type: 'Basic', deckId: 1);

  test('fromMap() should convert JSON values to deck', () {
    final result = Flashcard.fromMap(jsonMap);
    expect(result, flashcard);
  });

  test('toMap() should convert a deck to a valid JSON string', () {
    final result = flashcard.toMap();
    expect(result, jsonMap);
  });
}