import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/repositories/today_news_repository.dart';

class DetailViewModel {
  final _todayNewsRepository = TodayNewsRepository();
  Stream<Resource<NewsDetailModel>> get newsDetail =>
      _todayNewsRepository.newsDetailSubject.stream;

  fetchNewsDetail(String newsId) {
    _todayNewsRepository.fetchNewsDetail(newsId);
  }
}