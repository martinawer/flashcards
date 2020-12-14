import 'dart:io';
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

  Future<Database> initDB() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'flashcards.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await _createDeckTable(db);
          await _createFlashcardTable(db);
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
        'FOREIGN KEY(deckId) REFERENCES Deck(id)'
        ')');
  }

  Future<void> _createDeckTable(Database db) async {
    await db.execute('CREATE TABLE Deck ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'size INTEGER NOT NULL,'
        'performance INTEGER NOT NULL,'
        'tags TEXT'
        ')');
  }

  Future<void> close() async {
    Database db = await database;
    return db.close();
  }
}
