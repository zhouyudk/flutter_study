import 'package:flutter/material.dart';
import 'package:flutter_study/routes.dart';

import 'ui/daily_report/home/home_page.dart';
import 'utils/log_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              colorScheme: const ColorScheme.light())
          .copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: const MyHomePage(
        title: 'Demo',
      ),
      routes: Routes.all,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String _homeNavigationName(int index) {
    switch (HomeNavigation.values.elementAt(index)) {
      case HomeNavigation.dailyReport:
        return 'DailyReport';
      case HomeNavigation.weChat:
        return 'WeChat';
      case HomeNavigation.plank:
        return 'Plank';
    }
  }

  String _homeNavigationRoute(int index) {
    switch (HomeNavigation.values.elementAt(index)) {
      case HomeNavigation.dailyReport:
        return Routes.dailyReport;
      case HomeNavigation.weChat:
        return Routes.weChat;
      case HomeNavigation.plank:
        return Routes.plank;
    }
  }

  _navigateTo(String route) {
    LogUtil.v('navigate to $route');
    Navigator.of(context).pushNamed(route);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildNavigateHome(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildNavigateHome() {
    return ListView.separated(
        itemBuilder: (context, index) => SizedBox(
            height: 80,
            child: TextButton(
                onPressed: () => _navigateTo(_homeNavigationRoute(index)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue)),
                child: Text(
                  _homeNavigationName(index),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ))),
        separatorBuilder: (context, index) =>
            const Divider(thickness: 1, height: 1, color: Colors.black),
        itemCount: HomeNavigation.values.length);
  }
}

enum HomeNavigation { dailyReport, weChat, plank}