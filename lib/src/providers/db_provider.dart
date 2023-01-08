import 'dart:io';
import 'package:api_to_sqlite/src/models/employee_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'PendingGames.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Game('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'platform TEXT'
          ')');
    });
  }

  // Insert employee on database
  createEmployee(Game newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db?.insert('Game', newEmployee.toJson());

    return res;
  }

  // Delete all employees
  Future<int?> deleteAllEmployees() async {
    final db = await database;
    final res = await db?.rawDelete('Delete FROM Game');

    return res;
  }

  Future<List<Game?>> getAllEmployees() async {
    final db = await database;
    final res = await db?.rawQuery("Select * FROM Game");

    List<Game> list =
        res!.isNotEmpty ? res.map((c) => Game.fromJson(c)).toList() : [];

    return list;
  }
}
