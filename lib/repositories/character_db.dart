import 'package:path/path.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';

class SharedPreferences {
  int? id;
  String? data;
  bool? isDark;

  SharedPreferences({this.id, this.data, this.isDark});

  SharedPreferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    isDark = json['isDark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    data['isDark'] = this.isDark;
    return data;
  }
}

class SharedPreferencesDB {
  late dynamic database;

  SharedPreferencesDB({database}) {
    database = null;
    initDB();
  }

  void initDB() async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    database = openDatabase(
      join(await getDatabasesPath(), "characters.db"),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE spreferences(id $idType, data $textType, isDark $boolType)");
      }, 
      version: 1
    );
  }

  Future<void> insertSharedPreferences(SharedPreferences sp) async {
    final db = await database;
    await db.insert(
      'spreferences',
      sp.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SharedPreferences>> readSharedPreferences() async {
    final db = await database;
    
    final List<Map<String, dynamic>> maps = await db.query('spreferences');
    
    return List.generate(maps.length, (i) {
      //return SharedPreferences.fromJson(maps[i]);
      return SharedPreferences(
        id: maps[i]['id'],
        data: maps[i]['data'],
        isDark: maps[i]['isDark'],
      );
    });
  }

  Future<void> updateSharedPreferences(SharedPreferences sp) async {
    final db = await database;
    
    await db.update(
      'spreferences',
      sp.toJson(),
      where: "id = ?",
      whereArgs: [sp.id],
    );
  }

  Future<void> deleteSharedPreferences(int id) async {
    final db = await database;
    
    await db.delete(
      'spreferences',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}


