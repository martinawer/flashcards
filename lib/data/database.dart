import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


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

  Future<Database> initDB() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'flashcards.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await _createDeckTable(db);
          await _createFlashcardTable(db);
          await _createTagTable(db);
          await _createCardTagJunctionTable(db);
        });
  }

  Future<void> _createFlashcardTable(Database db) async {
    await db.execute('CREATE TABLE Flashcard ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'type TEXT NOT NULL,'
        'front TEXT NOT NULL,'
        'back TEXT NOT NULL,'
        'deckId INTEGER,'
        'tags TEXT,'
        'FOREIGN KEY(deckId) REFERENCES Deck(id))'
    );
  }

  Future<void> _createDeckTable(Database db) async {
    await db.execute('CREATE TABLE Deck ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'size INTEGER NOT NULL,'
        'performance INTEGER NOT NULL,'
        'tags TEXT)'
    );
  }

  Future<void> _createTagTable(Database db) async {
    await db.execute('CREATE TABLE Tag ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL,'
        'deck_id INTEGER NOT NULL,'
        'FOREIGN KEY(deck_id) REFERENCES Deck(id))'
    );
  }

  Future<void> _createCardTagJunctionTable(Database db) async {
    await db.execute('CREATE TABLE Card_Tag ('
        'tag_id INTEGER NOT NULL,'
        'card_id INTEGER NOT NULL,'
        'PRIMARY KEY(tag_id, card_id),'
        'FOREIGN KEY(tag_id) REFERENCES Tag(id),'
        'FOREIGN KEY(card_id) REFERENCES Card(id))'
    );
  }

  Future<void> close() async {
    Database db = await database;
    return db.close();
  }
}
