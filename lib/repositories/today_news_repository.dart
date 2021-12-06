
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:rxdart/rxdart.dart';


enum Api {
  todayNews,// = "/news/latest";
  newsBeforeDate,// = "/news/before/" //拼接20140618 查询该日前一天的news
  newsDetail, //= "/news/" //拼接3977867 news id
}
class TodayNewsRepository {
  final _host = "http://news-at.zhihu.com/api/3";

  static final TodayNewsRepository _todayNewsRepository = TodayNewsRepository._internal();
  factory TodayNewsRepository() => _todayNewsRepository;
  TodayNewsRepository._internal();

  final todayNewsSubject = BehaviorSubject<TodayNewsModel>();

  queryTodayNews() async{
      try {
        final todayNewsData = await Dio().get(_host+apiPath(Api.todayNews));
        print("testzyadjfalkdjlfkaj");
        print(todayNewsData);
        todayNewsSubject.add(TodayNewsModel.fromJson(jsonDecode(todayNewsData.toString())));
      } catch(e) {
          print(e);
      }
   }



  String apiPath(Api api) {
    switch(api) {
      case Api.todayNews:
        return "/news/latest";
      case Api.newsBeforeDate:
        return "/news/before/"; //拼接20140618 查询该日前一天的news
      case Api.newsDetail:
        return "/news/"; //拼接3977867 news id
    }
  }
}
