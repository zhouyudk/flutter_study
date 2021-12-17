import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/repositories/news_detail_repository.dart';
import 'package:flutter_study/repositories/today_news_repository.dart';

class DetailViewModel {
  final _newsDetailRepository = NewsDetailRepository();
  Stream<Resource<NewsDetailModel>> get newsDetail =>
      _newsDetailRepository.newsDetailSubject.stream;

  fetchNewsDetail(String newsId) {
    _newsDetailRepository.fetchNewsDetail(newsId);
  }
}