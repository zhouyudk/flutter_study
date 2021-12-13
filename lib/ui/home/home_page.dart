import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/ui/home/home_carousel.dart';
import 'package:flutter_study/ui/home/home_report_section.dart';
import 'package:flutter_study/ui/home/home_report_tile.dart';
import 'package:flutter_study/ui/home/home_view_model.dart';
import 'package:flutter_study/utils/log_util.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _counter = 0;
  final _viewModel = HomeViewModel();
  HomeNewsContent? _homeNews;
  final _day = DateFormat("dd").format(DateTime.now());
  final _month = DateFormat("MM月").format(DateTime.now());

  final ScrollController _scrollController = ScrollController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    _viewModel.onRefresh();
  }

  @override
  void initState() {
    _viewModel.todayNewsContent.listen((result) {
      switch (result.status) {
        case Status.success:
          setState(() {
            _homeNews = result.data!;
          });
          break;
        case Status.error:
          // show some error
          break;
        default:
          break;
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LogUtil.v('滑动到了最底部');
        _viewModel.loadMore();
        // _getMore();
      }
    });

    _viewModel.onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo"),
        leading: SizedBox(
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_day,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text(
                    _month,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: SizedBox(
                  height: double.infinity,
                  width: 2,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white70)),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: _homeNews == null ? _emptyPage() : _buildBody(),
      floatingActionButton: _buildFloatButton(),
    );
  }

  Widget _buildBody() {
    //以scrollView 作为RefreshIndicator的子组件 才能触发刷新
    return RefreshIndicator(
      child: SingleChildScrollView(
        controller: _scrollController,
        //在Android上scrollView也能像iOS一样将offset滑动为负数
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            //today top
            _homeNews?.todayNews?.topStories == null
                ? const SizedBox(height: 0)
                : HomeCarousel(
                    topNews: _homeNews!.todayNews!.topStories,
                    onTileClicked: _onTileClicked,
                  ),
            //today list
            HomeReportSection(
              dataList: _homeNews!.todayNews!.stories,
              onTileClicked: _onTileClicked,
            ),
            // yesterday and other list
            ..._homeNews!.dailyNews?.map((model) => HomeReportSection(
                      dataList: model.stories,
                      date: model.date,
                      isToday: false,
                      onTileClicked: _onTileClicked,
                    )) ??
                []
          ],
        ),
      ),
      onRefresh: _onRefresh,
    );
  }

  Widget _buildFloatButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  Widget _emptyPage() {
    return Center(
      child: ElevatedButton(
        child: Text(
          '点击重试',
          style: Theme.of(context).textTheme.headline4,
        ),
        onPressed: () {
          _viewModel.onRefresh();
        },
      ),
    );
  }

  Future _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      LogUtil.v('home page refresh');
      _viewModel.onRefresh();
    });
  }

  _onTileClicked(String newsId) {
    LogUtil.v("点击了tile- ${newsId}");
  }
}
