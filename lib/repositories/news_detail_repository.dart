import 'dart:convert';

import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/managers/api_manager.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/utils/log_util.dart';
import 'package:rxdart/rxdart.dart';

class NewsDetailRepository {
  final _apiManager = ApiManager();

  final newsDetailSubject = BehaviorSubject.seeded(Resource<NewsDetailModel>.empty());

  fetchNewsDetail(String newsId) {
    _apiManager
        .get(Api.newsDetail, para: newsId)
        .map((data) => NewsDetailModel.fromJson(jsonDecode(data.toString())))
        .listen((model) => newsDetailSubject.add(Resource.success(data: model)),
        onError: (error) => newsDetailSubject.add(Resource.error(e: error.toString())));
  }
}