import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/routes.dart';
import 'package:flutter_study/ui/home/home_carousel.dart';
import 'package:flutter_study/ui/home/home_report_section.dart';
import 'package:flutter_study/ui/home/home_view_model.dart';
import 'package:flutter_study/utils/log_util.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
  final _day = DateFormat("dd").format(DateTime.now());
  final _month = DateFormat("MM月").format(DateTime.now());
  var _dataResult = Resource<HomeNewsContent>.empty();

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
      setState(() {
        _dataResult = result;
      });
    });

    _scrollController.addListener(() {
      LogUtil.v("${_scrollController.position.pixels}----${_scrollController.position.maxScrollExtent}");
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent-500) {
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
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
      body: _buildBody(),
      floatingActionButton: _buildFloatButton(),
    );
  }

  Widget _buildBody() {
    switch (_dataResult.status) {
      case Status.success:
        return _buildSuccessContent(_dataResult.data!);
      case Status.error:
        return _buildErrorContent();
      case Status.empty:
        return _buildPlaceholder();
      case Status.loading:
        return _buildSuccessContent(_dataResult.data!);
      default:
        return _buildErrorContent();
    }
  }

  Widget _buildSuccessContent(HomeNewsContent content) {
    //以scrollView 作为RefreshIndicator的子组件 才能触发刷新
    return RefreshIndicator(
      child: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          //today top
          content.todayNews?.topStories == null
              ? const SizedBox(height: 0)
              : HomeCarousel(
                  topNews: content.todayNews!.topStories,
                  onTileClicked: _onTileClicked,
                ),
          //today list
          HomeReportSection(
            dataList: content.todayNews!.stories,
            onTileClicked: _onTileClicked,
          ),
          // yesterday and other list
          ...content.dailyNews?.map((model) => HomeReportSection(
                    dataList: model.stories,
                    date: model.date,
                    isToday: false,
                    onTileClicked: _onTileClicked,
                  )) ??
              [],
          _dataResult.status == Status.loading
              ? const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "加载更多.......",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      onRefresh: _onRefresh,
    );
  }

  Widget _buildPlaceholder() {
    return Shimmer(
      gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Colors.black12,
            Colors.black12,
            Colors.white10,
            Colors.black12,
            Colors.black12
          ],
          stops: <double>[
            0.3,
            0.45,
            0.5,
            0.55,
            0.7
          ]),
      child: ListView(
        children: [
          const AspectRatio(
            aspectRatio: 1.3,
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
          ...List.generate(4, (index) => 0).map((e) => Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 24, right: 24),
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                              width: 200,
                              height: 30,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.black),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                              width: 150,
                              height: 25,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.black),
                              )),
                        ],
                      ),
                      const AspectRatio(
                        aspectRatio: 1,
                        child: SizedBox(
                          width: double.infinity,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildFloatButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  Widget _buildErrorContent() {
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
    Navigator.of(context).pushNamed(Routes.detailPage, arguments: newsId);
  }
}
