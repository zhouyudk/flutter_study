import 'dart:io';

import 'package:flutter_study/ui/plank/db/database_helper.dart';
import 'package:flutter_study/ui/plank/db/plank_record.dart';

class PlankViewModel {

  final databaseHelper = DatabaseHelper();

  void setPlankRecord(PlankRecord record) {
    databaseHelper.insertPlankRecord(record);
  }

  Future<List<PlankRecord>> getPlankRecords() {
    return databaseHelper.plankRecords();
  }
}
