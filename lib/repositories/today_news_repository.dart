import 'dart:async';
import 'dart:convert';

import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/managers/api_manager.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:rxdart/rxdart.dart';

class TodayNewsRepository {
  static final TodayNewsRepository _todayNewsRepository =
      TodayNewsRepository._internal();

  factory TodayNewsRepository() => _todayNewsRepository;

  TodayNewsRepository._internal();

  final _apiManager = ApiManager();

  final todayNewsSubject = StreamController<Resource<TodayNewsModel>>();
  final newsSubject = StreamController<NewsModel>();
  final newsDetailSubject = StreamController<NewsModel>();

  fetchTodayNews() {
    return _apiManager
        .get(Api.todayNews)
        .map((data) => TodayNewsModel.fromJson(jsonDecode(data.toString())))
        .listen((model) => todayNewsSubject.add(Resource.success(data: model)),
            onError: (error) => todayNewsSubject.add(Resource.error(e: error)));
  }

  fetchNewsBeforeDate(String date) async {
    final newsData = await _apiManager.get(Api.newsBeforeDate, para: date);
    newsSubject.add(NewsModel.fromJson(jsonDecode(newsData.toString())));
  }

  fetchNewsDetail(String newsId) async {
    final newsData = await _apiManager.get(Api.newsDetail, para: newsId);
    newsDetailSubject.add(NewsModel.fromJson(jsonDecode(newsData.toString())));
  }
}
