import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_86/grocery.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstractor();
  static DatabaseHelper instance = DatabaseHelper._privateConstractor();

  static Database? _database;
  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'grocery.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE groceries(
        id INTEGER PRIMARY KEY,
        name TEXT
      )
      ''');
  }

  Future<List<Grocery>> getGrocery() async {
    Database db = await instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Grocery> groceryList = groceries.isEmpty
        ? []
        : groceries.map((grocery) => Grocery.fromMap(grocery)).toList();

    return groceryList;
  }

  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert('groceries', grocery.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('groceries', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(Grocery grocery) async {
    Database db = await instance.database;
    return await db.update('groceries', grocery.toMap(),
        where: 'id=?', whereArgs: [grocery.id]);
  }
}
