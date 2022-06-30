import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PlankViewModel {

  PlankViewModel() {
    initDB().asStream().listen((db) {
      _database = db;
    });
  }

  Database? _database;

  Future<Database> get database async {
    _database = _database ?? await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'plank_database.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE tb_plank(start_time_stamp INTEGER PRIMARY KEY, duration INTEGER)
            ''');
    });
  }
}
