

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_study/ui/plank/db/plank_record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "students_database.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE tb_plank(start_time INTEGER PRIMARY KEY, duration INTEGER)
            ''');
        });
  }

  Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      debugPrint(_database.toString());
      return _database;
    }

    _database = await initDB();
    debugPrint("创建新数据库");
    return _database;
  }

  void insertPlankRecord(PlankRecord record) async {
    final Database? db = await database;
    db?.insert('tb_plank', record.toJson());
  }

  Future<List<PlankRecord>> plankRecords() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db?.query('tb_plank') ?? [];
    return List.generate(maps.length, (i) => PlankRecord.fromJson(maps[i]));
  }

}
