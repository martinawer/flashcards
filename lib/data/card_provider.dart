import 'package:flutter_flashcards/data/table_provider.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class CardProvider extends TableProvider {
  const CardProvider();

  newFlashcard(Flashcard newFlashcard) async {
    print(newFlashcard.toMap());
    final db = await database;
    var res = await db.insert('Flashcard', newFlashcard.toMap());
    return res;
  }

  Future<List<Flashcard>> getAllFlashCardsFromDeck(int deckId) async {
    final db = await database;
    var res = await db.query('Flashcard', where: 'deckId = ?', whereArgs: [deckId]);
    List<Flashcard> list = res.isNotEmpty ? res.map((fc) => Flashcard.fromMap(fc)).toList() : [];
    return list;
  }

  updateCard(Flashcard newFlashcard) async {
    final db = await database;
    var res = await db.update('Flashcard', newFlashcard.toMap(), where: 'id= ?', whereArgs: [newFlashcard.id]);
    return res;
  }

  deleteCard(int id) async {
    final db = await database;
    var res = await db.delete('Flashcard', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}