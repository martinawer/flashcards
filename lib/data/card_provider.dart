import 'package:flutter_flashcards/data/table_provider.dart';
import 'package:flutter_flashcards/models/flashcard.dart';
import 'package:sqflite/sqflite.dart';

class CardProvider extends TableProvider {
  const CardProvider();

  Future<void> insert(Flashcard newFlashcard) async {
    final Database db = await database;
    await db.insert('Flashcard', newFlashcard.toMap());
  }

  Future<List<Flashcard>> getFlashcardsFromDeck(int deckId) async {
    final Database db = await database;
    List<Map<String, dynamic>> res = await db.query('Flashcard', where: 'deckId = ?', whereArgs: [deckId]);
    return res.isNotEmpty ? res.map((fc) => Flashcard.fromMap(fc)).toList() : [];
  }

  Future<void> update(Flashcard newFlashcard) async {
    final Database db = await database;
    await db.update('Flashcard', newFlashcard.toMap(), where: 'id= ?', whereArgs: [newFlashcard.id]);
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    await db.delete('Flashcard', where: 'id = ?', whereArgs: [id]);
  }

}