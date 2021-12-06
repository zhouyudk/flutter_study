
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/repositories/today_news_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  HomeViewModel();

  final todayNewsRepository = TodayNewsRepository();

  Stream<TodayNewsModel> get todayNewsContent  => todayNewsRepository.todayNewsSubject.stream;

  fetchTodayNews() {
    todayNewsRepository.queryTodayNews();
  }
}