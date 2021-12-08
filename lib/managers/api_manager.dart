import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_study/common/global.dart';
import 'package:flutter_study/utils/log_util.dart';

enum Api {
  todayNews, // = "/news/latest";
  newsBeforeDate, // = "/news/before/" //拼接20140618 查询该日前一天的news
  newsDetail, //= "/news/" //拼接3977867 news id
}

class ApiManager {
  final _host = "http://news-at.zhihu.com/api/3";

  final _dio = Dio();

  static final ApiManager _apiManager = ApiManager._internal();

  factory ApiManager() => _apiManager;

  ApiManager._internal() {
    _dio.options = _dio.options.copyWith(
      baseUrl: _host,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    );
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) =>
                requestInterceptor(options, handler),
        onResponse: (Response response, ResponseInterceptorHandler handler) =>
            responseInterceptor(response, handler),
        onError: (DioError dioError, ErrorInterceptorHandler handler) =>
            errorInterceptor(dioError, handler)));
  }

  requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.get("token");

    //修改header
    // options.headers.addAll({"Token": "$token${DateTime.now()}"});
    LogUtil.v(options.toString());
    handler.next(options);
  }

  responseInterceptor(
      Response response, ResponseInterceptorHandler handler) {
    // LogUtil.d(response.toString());
    //logger 库不能打印超长string
    log(response.toString(), time: DateTime.now(), level: 1);
    handler.next(response);
  }

  errorInterceptor(DioError dioError, ErrorInterceptorHandler handler) {
    LogUtil.e(dioError.toString());
    handler.next(dioError);
  }

  Future get(Api api, {String para = ""}) async {
    return _dio.get(_apiPath(api) + para);
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
