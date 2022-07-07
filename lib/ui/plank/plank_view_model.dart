import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study/ui/plank/db/database_helper.dart';
import 'package:flutter_study/ui/plank/db/plank_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/plank_preferences.dart';

final plankDataProvider =
    StateNotifierProvider<PlankViewModel, PlankContent>((ref) {
  return PlankViewModel();
});

class PlankViewModel extends StateNotifier<PlankContent> {
  PlankViewModel() : super(PlankContent.defaultInstance()) {
    plankRecords();
    highestRecord();
  }

  final _colorList = [
    Colors.orange,
    Colors.redAccent,
    Colors.amber,
    Colors.blueAccent,
    Colors.cyanAccent
  ];

  Timer? _timer;

  //是否开始计时
  bool _isTiming = false;

  final _databaseHelper = DatabaseHelper();
  final _plankPrefs = PlankPreferences();

  void setPlankRecord(PlankRecord record) {
    _databaseHelper.insertPlankRecord(record);
  }

  void plankRecords() {
    _databaseHelper.plankRecords().asStream().listen((records) {
      state = state.copyWith(recordList: records);
    });
  }

  void setHighestRecord(int record) {
    _plankPrefs.setHighestRecord(record);
  }

  void highestRecord() {
    _plankPrefs.highestRecord().asStream().listen((record) {
      state = state.copyWith(highestRecord: record);
    });
  }

  ///点击计时控件是调用
  void onTimeClicked() {
    _isTiming = !_isTiming;
    if (_isTiming) {
      _startTiming();
    } else {
      if (state.time > state.highestRecord) {
        setHighestRecord(state.time);
      }
      _stopTiming();
    }
  }

  void _startTiming() {
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      _timer = timer;
      _updateTiming();
    });
  }

  void _stopTiming() {
    _timer?.cancel();
    _timer = null;
  }

  void _updateTiming() {
    final timing = state.time + 1;
    if ((timing / 1000).truncate() % 60 == 0 &&
        (timing / 1000).truncate() >= 60) {
      state = state.copyWith(
          backgroundColor: state.foregroundColor,
          foregroundColor: _colorList
              .elementAt((timing / 60 * 1000).truncate() % _colorList.length),
          timing: timing,
          progress: 0);
    } else {
      state = state.copyWith(
          timing: timing, progress: timing % (60 * 1000) / (60 * 1000));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stopTiming();
  }
}

@immutable
class PlankContent {
  //计时圆环的背景色
  final Color backgroundColor;

  //计时圆环的前景色
  final Color foregroundColor;

  //计时字段
  final int time;

  //计时圆环的进度
  final double progress;

  //最高记录
  final int highestRecord;

  final List<PlankRecord> recordList;

  const PlankContent(
      {required this.backgroundColor,
      required this.foregroundColor,
      required this.time,
      required this.progress,
      required this.highestRecord,
      required this.recordList});

  static PlankContent defaultInstance() {
    return PlankContent(
        backgroundColor: Colors.grey.withAlpha(33),
        foregroundColor: Colors.orange,
        time: 0,
        progress: 0.0,
        highestRecord: 0,
        recordList: const []);
  }

  PlankContent copyWith(
      {Color? backgroundColor,
      Color? foregroundColor,
      int? timing,
      double? progress,
      int? highestRecord,
      List<PlankRecord>? recordList}) {
    return PlankContent(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor: foregroundColor ?? this.foregroundColor,
        time: timing ?? this.time,
        progress: progress ?? this.progress,
        highestRecord: highestRecord ?? this.highestRecord,
        recordList: recordList ?? this.recordList);
  }
}
