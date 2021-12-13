import 'package:flutter/cupertino.dart';
import 'package:flutter_study/ui/detail_page/detail_page.dart';

class Routes {
  static final all = {
    Routes.detailPage: (context) => DetailPage(newsId: ModalRoute.of(context)?.settings.arguments as String),
  };
  static const detailPage = "detail_page";
}