import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/ui/home/home_carousel.dart';
import 'package:flutter_study/ui/home/home_view_model.dart';
import 'package:rxdart/rxdart.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key, required this.title, required this.day, required this.month})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String month;
  final String day;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _counter = 0;
  final _viewModel = HomeViewModel();

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
    _viewModel.todayNewsContent.listen((model) {
      print("teststrafasdfasdfadfadfa");
      print(model.stories.first.url);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.day),
              Text(
                widget.month,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
    return Center(
      child: RefreshIndicator(
        child: Column(
          children: [
            StreamBuilder<TodayNewsModel>(
                stream: _viewModel.todayNewsContent,
                builder: (BuildContext context,
                    AsyncSnapshot<TodayNewsModel> snapshot) {
                  return HomeCarousel(topNews: snapshot.data?.topStories ?? []);
                })
          ],
        ),
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 2000), () {
            //调用viewmodel获取数据
          });
        },
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

  Widget _emptyPage() {
    return Center(
      child: ElevatedButton(
        child: Text(
          '点击重试',
          style: Theme.of(context).textTheme.headline4,
        ),
        onPressed: () {},
      ),
    );
  }
}
