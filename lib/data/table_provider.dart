import 'package:sqflite/sqflite.dart';
import 'package:flutter_flashcards/data/database.dart';

class TableProvider {
  const TableProvider();

  Future<Database> get database async {
    return await DBProvider.db.database;
  }
}