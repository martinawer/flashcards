import 'package:sqflite/sqflite.dart';

import 'package:flutter_flashcards/data/table_provider.dart';
import 'package:flutter_flashcards/models/tag.dart';

class TagProvider extends TableProvider {
  const TagProvider();

  Future<int> insert(Tag newTag) async {
    final Database db = await database;
    //await db.insert('Tag', newTag.toMap());
    //List<Map<String, dynamic>> result = await db.rawQuery(
    //    'SELECT Tag.name, COUNT(Tag.name) as exists FROM Tag ');
    List<Map<String, dynamic>> result = await db.query(
        'Tag', columns: ['name'], where: 'name = ? AND deck_id = ?', whereArgs: [newTag.name, newTag.deck_id]);
    return result.isNotEmpty ? await db.insert('Tag', newTag.toMap()) : -1;
  }

  Future<void> insertCard(int tag_id, int card_id) async {
    final Database db = await database;
    await db.insert('Card_Tag', { 'tag_id': tag_id, 'card_id': card_id });
  }

  Future<List<Tag>> getTags(int deck_id) async {
    final Database db = await database;

    List<Map<String, dynamic>> res = await db.query('Tag', where: 'deck_id = ?', whereArgs: [deck_id]);
    return res.isNotEmpty ? res.map((tag) => Tag.fromMap(tag)).toList() : [];

  }

  Future<List<Tag>> getTagsFromCard(int cardId) async {
    final Database db = await database;

    List<Map<String, dynamic>> res = await db.query('Card_Tag', where: 'card_id = ?', whereArgs: [cardId]);
    return res.isNotEmpty ? res.map((tag) => Tag.fromMap(tag)).toList() : [];
  }

  Future<void> update(Tag newTag) async {
    final Database db = await database;
    await db.update('Tag', newTag.toMap(), where: 'id= ?', whereArgs: [newTag.id]);
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    await db.delete('Tag', where: 'id = ?', whereArgs: [id]);
  }

}