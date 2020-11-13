import 'package:sqflite/sqflite.dart';
import 'database.dart';

abstract class TableProvider {
  const TableProvider();

  Future<Database> get database async {
    return await DBProvider.db.database;
  }
}