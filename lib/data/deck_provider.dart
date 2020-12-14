import 'package:flutter_flashcards/data/table_provider.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:sqflite/sqflite.dart';

class DeckProvider extends TableProvider {
  const DeckProvider();

  Future<void> create(Deck newDeck) async {
    final Database db = await database;
    await db.insert('Deck', newDeck.toMap());
  }

  Future<List<Deck>> getAll() async {
    final Database db = await database;
    List<Map<String, dynamic>> res = await db.rawQuery(
        'SELECT deck.*, count(flashcard.deckId) as size '
        'from deck '
        'left join flashcard '
        'on (deck.id = flashcard.deckId) '
        'group by '
        'deck.id');
    return res.isNotEmpty ? res.map((d) => Deck.fromMap(d)).toList() : [];
  }
  
  Future<Deck> get(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> res = await db.query('Deck', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Deck.fromMap(res.first) : [];
  }
  

  Future<void> update(Deck newDeck) async {
    final Database db = await database;
    await db.update('Deck', newDeck.toMap(), where: 'id = ?', whereArgs: [newDeck.id]);
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    await db.delete('Deck', where: 'id = ?', whereArgs: [id]);
  }
}