import 'dart:io';

import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/models/flashcard.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'mainDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
    onCreate: (Database db, int version) async {
      await _createDeckTable(db);
      await _createFlashcardTable(db);
    });
  }

  _createFlashcardTable(Database db) async {
    await db.execute('CREATE TABLE Flashcard ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'type TEXT NOT NULL,'
        'front TEXT NOT NULL,'
        'back TEXT NOT NULL,'
        'deckId INTEGER,'
        'FOREIGN KEY(deckId) REFERENCES Deck(id)'
        ')');
  }

  _createDeckTable(Database db) async {
    await db.execute('CREATE TABLE Deck ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'size INTEGER,'
        'performance INTEGER'
        ')');
    }

  newDeck(Deck newDeck) async {
    final db = await database;
    var res = await db.insert('Deck', newDeck.toMap());
    return res;
  }

  newFlashcard(Flashcard newFlashcard) async {
    final db = await database;
    var res = await db.insert('Flashcard', newFlashcard.toMap());
    return res;
  }

  Future<List<Deck>> getAllDecks() async {
    final db = await database;
    var res = await db.query('Deck');
    List<Deck> list = res.isNotEmpty ? res.map((d) => Deck.fromMap(d)).toList() : [];
    return list;
  }

  Future<List<Flashcard>> getAllFlashCardsFromDeck(int deckId) async {
    final db = await database;
    var res = await db.query('Flashcard', where: 'deckId = ?', whereArgs: [deckId]);
    List<Flashcard> list = res.isNotEmpty ? res.map((fc) => Flashcard.fromMap(fc)).toList() : [];
    return list;
  }

  updateDeck(Deck newDeck) async {
    final db = await database;
    var res = db.update('Deck', newDeck.toMap(),
      where: 'id = ?', whereArgs: [newDeck.id]);
    return res;
  }

  updateCard(Flashcard newFlashcard) async {
    final db = await database;
    var res = db.update('Flashcard', newFlashcard.toMap(),
      where: 'id= ?', whereArgs: [newFlashcard.id]);
    return res;
  }

  deleteDeck(int id) async {
    final db = await database;
    var res = db.delete('Deck', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  cardExists(int id) async {
    final db = await database;
    var res = db.query('Flashcard', where: 'id = ?', whereArgs: [id]);
    print(res);
    return res;
  }

  deleteCard(int id) async {
    final db = await database;
    var res = db.delete('Flashcard', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future close() async {
    var db = await database;
    return db.close();
  }
}
