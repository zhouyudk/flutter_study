import 'dart:async';

import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/repositories/today_news_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  HomeViewModel();

  final _todayNewsRepository = TodayNewsRepository();

  Stream<Resource<HomeNewsContent>> get todayNewsContent =>
      _todayNewsRepository.homeNewsContentSubject.stream;

  void onRefresh() {
    _todayNewsRepository.fetchTodayNews();
  }

  loadMore() {
    _todayNewsRepository.fetchNewsBeforeDate();
  }
}

class HomeNewsContent {
  final TodayNewsModel? todayNews;
  final List<DailyNewsModel>? dailyNews;

  const HomeNewsContent({this.todayNews, this.dailyNews});

  HomeNewsContent copy(
      {TodayNewsModel? todayNews, List<DailyNewsModel>? dailyNews}) {
    return HomeNewsContent(
        todayNews: todayNews ?? this.todayNews,
        dailyNews: dailyNews ?? this.dailyNews);
  }
}
