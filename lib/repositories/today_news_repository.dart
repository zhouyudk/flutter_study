import 'dart:convert';

import 'package:flutter_study/managers/api_manager.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:rxdart/rxdart.dart';


class TodayNewsRepository {

  static final TodayNewsRepository _todayNewsRepository =
      TodayNewsRepository._internal();

  factory TodayNewsRepository() => _todayNewsRepository;

  TodayNewsRepository._internal();

  final _apiManager = ApiManager();

  final todayNewsSubject = BehaviorSubject<TodayNewsModel>();
  final newsSubject = BehaviorSubject<NewsModel>();
  final newsDetailSubject = BehaviorSubject<NewsModel>();

  fetchTodayNews() async {
    final todayNewsData = await _apiManager.get(Api.todayNews);
    todayNewsSubject
        .add(TodayNewsModel.fromJson(jsonDecode(todayNewsData.toString())));
  }

  fetchNewsBeforeDate(String date) async {
    final newsData = await _apiManager.get(Api.newsBeforeDate, para: date);
    newsSubject.add(NewsModel.fromJson(jsonDecode(newsData.toString())));
  }

  fetchNewsDetail(String newsId) async {
    final newsData = await _apiManager.get(Api.newsDetail, para: newsId);
    newsSubject.add(NewsModel.fromJson(jsonDecode(newsData.toString())));
  }
}
