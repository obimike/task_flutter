import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //  create a table function
  static Future<void> createTables(sql.Database database) async {
    /*
    **  Create Task table
    */
    await database.execute("""CREATE TABLE task(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        isDone TEXT,
        priority TEXT,
        createdAt TEXT
      )
      """);
  }
//

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'task.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> createItem(
      String title, String isDone, String priority, String createdAt) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'isDone': isDone,
      'priority': priority,
      'createdAt': createdAt,
    };
    final id = await db.insert('task', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String isDone) async {
    final db = await SQLHelper.db();

    final data = {
      'isDone': isDone,
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
