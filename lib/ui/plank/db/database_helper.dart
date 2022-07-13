import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_study/ui/plank/db/plank_record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  final _databaseName = 'plank_database.db';
  final _tbPlank = 'tb_plank';

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      await createTable(db, '''
            CREATE TABLE $_tbPlank (id INTEGER PRIMARY KEY AUTOINCREMENT, start_time INTEGER, duration INTEGER)
            ''');
      debugPrint("创建新数据库");
    });
  }

  //判断表是否存在
  Future<bool> isTableExits(Database db, String tableName) async {
    //内建表sqlite_master
    var sql =
        "SELECT * FROM sqlite_master WHERE TYPE = 'table' AND NAME = '$tableName'";
    var res = await db.rawQuery(sql);
    return res.isNotEmpty;
  }

  //创建表
  Future<void> createTable(Database db, String sql) async {
    await db.execute(sql);
  }

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      debugPrint(_database.toString());
      return _database;
    }

    _database = await initDB();
    debugPrint(_database.toString());
    return _database;
  }

  void insertPlankRecord(PlankRecord record) async {
    final Database? db = await database;
    db?.insert(_tbPlank, record.toJson());
  }

  Future<List<PlankRecord>> plankRecords() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db?.query(_tbPlank) ?? [];
    return List.generate(maps.length, (i) => PlankRecord.fromJson(maps[i]));
  }

  // Future<int> delete(int id) async {
  //   return await db.delete(tableTodo, where: '$colu mnId = ?', whereArgs: [id]);
  // }
  //
  // Future<int> update(Todo todo) async {
  //   return await db.update(tableTodo, todo.toMap(),
  //       where: '$columnId = ?', whereArgs: [todo.id]);
  // }
  //
  // Future close() async => db.close();
}
