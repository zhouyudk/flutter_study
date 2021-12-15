import 'dart:async';
import 'dart:convert';

import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/managers/api_manager.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/ui/home/home_view_model.dart';
import 'package:flutter_study/utils/date_util.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class TodayNewsRepository {
  static final TodayNewsRepository _todayNewsRepository =
      TodayNewsRepository._internal();

  factory TodayNewsRepository() => _todayNewsRepository;

  TodayNewsRepository._internal();

  final _apiManager = ApiManager();

  final todayNewsSubject = StreamController<Resource<TodayNewsModel>>();
  final homeNewsContentSubject = BehaviorSubject.seeded(Resource<HomeNewsContent>.empty());
  final dailyNewsSubject = StreamController<List<DailyNewsModel>>();
  final newsDetailSubject = StreamController<NewsModel>();

  var _loadedDays = 0;
  var _isLoading = false;

  fetchTodayNews() {
    _loadedDays = 0;
    _apiManager
        .get(Api.todayNews)
        .map((data) => TodayNewsModel.fromJson(jsonDecode(data.toString())))
        .listen((model) => homeNewsContentSubject.add(Resource.success(data: HomeNewsContent(todayNews: model))),
            onError: (error) => homeNewsContentSubject.add(Resource.error(e: error)));
  }

  fetchNewsBeforeDate() {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    _apiManager
        .get(Api.newsBeforeDate, para: formatQueryDate())
        .map((data) => DailyNewsModel.fromJson(jsonDecode(data.toString())))
        .listen((model) {
      final currentData = homeNewsContentSubject.value.data;
      final newData = currentData?.copy(dailyNews: (currentData.dailyNews ?? []) + [model]);
      homeNewsContentSubject.add(Resource.success(data: newData));
      _isLoading = false;
      _loadedDays += 1;
    }, onError: (error) {
      // todayNewsSubject.add(Resource.error(e: error));
      _isLoading = false;
    });
  }

  fetchNewsDetail(String newsId) async {
    final newsData = await _apiManager.get(Api.newsDetail, para: newsId);
    newsDetailSubject.add(NewsModel.fromJson(jsonDecode(newsData.toString())));
  }

  String formatQueryDate() {
    final date = DateTime.now().subtract(Duration(days: _loadedDays));
    return DateFormat(DateUtil.yyyyMMdd).format(date);
  }
}
