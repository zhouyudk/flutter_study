import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/repositories/today_news_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  HomeViewModel();

  final _todayNewsRepository = TodayNewsRepository();

  Stream<TodayNewsModel> get todayNewsContent =>
      _todayNewsRepository.todayNewsSubject.stream;

  void onRefresh() {
    _todayNewsRepository.fetchTodayNews();
  }
}
