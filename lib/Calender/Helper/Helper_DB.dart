import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import '../Models/Events.dart';

class HelperDB {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'Events.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE eventsTable (id TEXT PRIMARY KEY , title TEXT , date TEXT , eventType TEXT , remainder TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(
      String tableName, Map<String, dynamic> data) async {
    final db = await HelperDB.database();
    await db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await HelperDB.database();
    return db.query(tableName);
  }

  static Future<void> remove(String tableName, String id) async {
    final db = await HelperDB.database();
    await db.rawDelete("DELETE FROM $tableName WHERE id = $id");
  }
}
