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

  void fetchTodayNews() async {
    final todayNewsData = await _apiManager.get(Api.todayNews);
    todayNewsSubject
        .add(TodayNewsModel.fromJson(jsonDecode(todayNewsData.toString())));
  }

  void fetchNewsBeforeDate(String date) async {
    final newsData = await _apiManager.get(Api.newsBeforeDate, para: date);
    newsSubject.add(NewsModel.fromJson(jsonDecode(newsData.toString())));
  }

  void fetchNewsDetail(String newsId) async {
    final newsData = await _apiManager.get(Api.newsDetail, para: newsId);
    newsSubject.add(NewsModel.fromJson(jsonDecode(newsData.toString())));
  }

  String _apiPath(Api api) {
    switch (api) {
      case Api.todayNews:
        return "/news/latest";
      case Api.newsBeforeDate:
        return "/news/before/"; //拼接20140618 查询该日前一天的news
      case Api.newsDetail:
        return "/news/"; //拼接3977867 news id
    }
  }
}
