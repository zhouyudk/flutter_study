
import 'package:shared_preferences/shared_preferences.dart';

class PlankPreferences {
  /// AnalyticsManager Singleton
  PlankPreferences._internal();

  factory PlankPreferences() => _instance;
  static late final PlankPreferences _instance =
  PlankPreferences._internal();


  final _plankHighestRecord = 'pref_plank_highest_record';
  final _plankGoal = 'pref_plank_goal';

  void setHighestRecord(int record) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_plankHighestRecord, record);
  }

  Future<int> highestRecord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_plankHighestRecord) ?? 0;
  }
  ///设置单次Plank 目标
  void setPlankGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_plankGoal, goal);
  }
  ///如果没有设置过目标则默认返回120s
  Future<int> plankGoal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_plankGoal) ?? 120;
  }

}