import 'package:flutter/cupertino.dart';
import 'package:flutter_study/main.dart';
import 'package:flutter_study/ui/daily_report/detail_page/detail_page.dart';
import 'package:flutter_study/ui/daily_report/home/home_page.dart';
import 'package:flutter_study/ui/plank/plank_home.dart';
import 'package:flutter_study/ui/wechat/wechat_main.dart';

class Routes {
  static final all = {
    Routes.dailyReportDetailPage: (context) => DetailPage(newsId: ModalRoute.of(context)?.settings.arguments as String),
    Routes.dailyReport: (context) => const DailyReportHomePage(),
    Routes.weChat: (context) => const WeChatHomePage(),
    Routes.plank: (context) => PlankHome(),
  };
  static const dailyReportDetailPage = 'detail_page';
  static const dailyReport = 'daily_report';
  static const weChat = 'weChat';
  static const plank = 'plank';
}