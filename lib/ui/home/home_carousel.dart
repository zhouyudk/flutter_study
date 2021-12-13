import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/ui/home/home_carousel_tile.dart';
import 'package:flutter_study/utils/log_util.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key, required this.topNews, required this.onTileClicked}) : super(key: key);

  final List<TopNewsModel> topNews;
  final Function(String) onTileClicked;

  @override
  State<HomeCarousel> createState() => _HomeCarousel();
}

class _HomeCarousel extends State<HomeCarousel> with WidgetsBindingObserver {
  PageController _pageController = PageController();
  Timer? _timer;
  List<TopNewsModel> _dataList = [];

  @override
  void initState() {
    final newsListTmp = widget.topNews;
    if (newsListTmp.length > 1) {
      _dataList = [newsListTmp.last] + newsListTmp + [newsListTmp.first];
      _pageController = PageController(initialPage: 1);
    } else {
      _dataList = newsListTmp;
    }

    _pageController.addListener(() {
      // _pageController.position 类似offset
      if (_pageController.page == null && _dataList.length<2) { return; }
      if (_pageController.page! == (_dataList.length-1).toDouble()) {
          _pageController.jumpToPage(1);
      } else if (_pageController.page! == 0) {
        _pageController.jumpToPage(_dataList.length-2);
      }
      // LogUtil.v("currentPage: ${_pageController.page}");
    });

    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _cancelTimer();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: PageView(
          scrollDirection: Axis.horizontal,
          allowImplicitScrolling: true,
          controller: _pageController,
          onPageChanged: _onPageChanged,// 当页面滑动到一半便会调用
          children: [
            ..._dataList.map((model) => HomeCarouselTile(topNewsModel: model, onTileClicked: widget.onTileClicked,))
          ],
        ));
  }

  _onPageChanged(int page) {
    // LogUtil.v("_onPageChanged $page");
  }


  _startTimer() {
    if (_dataList.length <= 1) { return; }
    _cancelTimer();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _pageController.nextPage(duration: const Duration(milliseconds: 800), curve: Curves.ease);
    });
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state状态：$state');
    switch (state) {
      case AppLifecycleState.resumed: {
        break;
      }

      case AppLifecycleState.paused:{
        _cancelTimer();
        break;
      }
      case AppLifecycleState.inactive:{
        _cancelTimer();
        break;
      }
      case AppLifecycleState.detached:{
        _cancelTimer();
        break;
      }
    }
    super.didChangeAppLifecycleState(state);
  }
}
