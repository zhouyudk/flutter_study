import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

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

  void requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.get("token");

    //修改header
    // options.headers.addAll({"Token": "$token${DateTime.now()}"});
    debugPrint(options.toString());
    handler.next(options);
  }

  void responseInterceptor(
      Response response, ResponseInterceptorHandler handler) {
    debugPrint(response.toString());
    handler.next(response);
  }

  void errorInterceptor(DioError dioError, ErrorInterceptorHandler handler) {
    debugPrint(dioError.toString());
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
