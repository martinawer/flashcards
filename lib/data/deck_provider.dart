import 'package:flutter_flashcards/data/table_provider.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckProvider extends TableProvider {
  const DeckProvider();

  newDeck(Deck newDeck) async {
    final db = await database;
    var res = await db.insert('Deck', newDeck.toMap());
    return res;
  }

  Future<List<Deck>> getAllDecks() async {
    final db = await database;
    var res = await db.query('Deck');
    List<Deck> list = res.isNotEmpty ? res.map((d) => Deck.fromMap(d)).toList() : [];
    return list;
  }

  updateDeck(Deck newDeck) async {
    final db = await database;
    var res = await db.update('Deck', newDeck.toMap(), where: 'id = ?', whereArgs: [newDeck.id]);
    return res;
  }

  deleteDeck(int id) async {
    final db = await database;
    var res = await db.delete('Deck', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}