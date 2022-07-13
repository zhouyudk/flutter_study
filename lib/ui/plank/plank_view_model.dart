import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study/ui/plank/db/database_helper.dart';
import 'package:flutter_study/ui/plank/db/plank_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/ui/plank/plank_home.dart';

import 'data/plank_preferences.dart';

final plankDataProvider =
    StateNotifierProvider<PlankViewModel, PlankContent>((ref) {
  return PlankViewModel();
});

class PlankViewModel extends StateNotifier<PlankContent> {
  PlankViewModel() : super(PlankContent.defaultInstance()) {
    refreshPlankRecords();
    refreshHighestRecord();
  }

  final _colorList = [
    Colors.orange,
    Colors.redAccent,
    Colors.amber,
    Colors.blueAccent,
    Colors.cyanAccent
  ];

  final _databaseHelper = DatabaseHelper();
  final _plankPrefs = PlankPreferences();

  void setPlankRecord(PlankRecord record) {
    _databaseHelper.insertPlankRecord(record);
  }

  void refreshPlankRecords() {
    _databaseHelper.plankRecords().asStream().listen((records) {
      List<PlankRecord> recordsReduce = [];
      //todo:按天叠加数据 数据间隔超过10天中间 增加一条空数据
      var lastDayDuration = 0;
      var lastRecordDate = DateTime.now().millisecondsSinceEpoch;
      for (int i = records.length-1; i >= 0; i--) {
        if (lastRecordDate.isSameDayWith(records[i].startTime)) {
          lastDayDuration += records[i].duration;
        } else {
          if (records.length > 20) break;
          recordsReduce.insert(
              0,
              PlankRecord(
                  startTime: lastRecordDate, duration: lastDayDuration));
          lastRecordDate = records[i].startTime;
          lastDayDuration = records[i].duration;
        }
      }
      //插入最后一条数据
      recordsReduce.insert(
          0, PlankRecord(startTime: lastRecordDate, duration: lastDayDuration));
      final chartDataList = recordsReduce
          .asMap()
          .entries
          .map((entry) => ChartData(
              index: entry.key,
              duration: entry.value.duration,
              durationStr: entry.value.duration.toSecondString(),
              dateStr: entry.value.startTime.toDateDayString()))
          .toList();
      state = state.copyWith(chartDataList: chartDataList);
    });
  }

  void setHighestRecord(int record) {
    _plankPrefs.setHighestRecord(record);
  }
//需要设置为流
  void refreshHighestRecord() {
    _plankPrefs.highestRecord().asStream().listen((record) {
      state = state.copyWith(highestRecord: record);
    });
  }

  void updateDuration() {
    final duration = state.duration + 1;
    if ((duration / 1000).truncate() % 60 == 0 &&
        (duration / 1000).truncate() >= 60) {
      state = state.copyWith(
          backgroundColor: state.foregroundColor,
          foregroundColor: _colorList
              .elementAt((duration / 60 * 1000).truncate() % _colorList.length),
          duration: duration,
          progress: 0);
    } else {
      state = state.copyWith(
          duration: duration, progress: duration % (60 * 1000) / (60 * 1000));
    }
  }

  void onTimingStop() {
    setHighestRecord(max(state.duration, state.highestRecord));
    _databaseHelper.insertPlankRecord( PlankRecord(startTime: state.startTime, duration: state.duration));
    _resetPlankContent();
  }

  void _resetPlankContent() {
    state = PlankContent.defaultInstance();
    refreshHighestRecord();
    refreshPlankRecords();
  }
}

@immutable
class PlankContent {
  //计时圆环的背景色
  final Color backgroundColor;

  //计时圆环的前景色
  final Color foregroundColor;

  //计时字段
  final int duration;

  final int startTime;

  //计时圆环的进度
  final double progress;

  //最高记录
  final int highestRecord;

  final List<ChartData> chartDataList;

  const PlankContent({
    required this.startTime,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.duration,
    required this.progress,
    required this.highestRecord,
    required this.chartDataList,
  });

  static PlankContent defaultInstance() {
    return PlankContent(
        startTime: 0,
        backgroundColor: Colors.grey.withAlpha(33),
        foregroundColor: Colors.orange,
        duration: 0,
        progress: 0.0,
        highestRecord: 0,
        chartDataList: const []);
  }

  PlankContent copyWith(
      {Color? backgroundColor,
      Color? foregroundColor,
      int? startTime,
      int? duration,
      double? progress,
      int? highestRecord,
      List<ChartData>? chartDataList}) {
    return PlankContent(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor: foregroundColor ?? this.foregroundColor,
        startTime: startTime ?? this.startTime,
        duration: duration ?? this.duration,
        progress: progress ?? this.progress,
        highestRecord: highestRecord ?? this.highestRecord,
        chartDataList: chartDataList ?? this.chartDataList);
  }
}

@immutable
class ChartData {
  final int index;
  final String durationStr;
  final int duration;
  final String dateStr;

  const ChartData(
      {required this.index,
      required this.duration,
      required this.durationStr,
      required this.dateStr});
}
