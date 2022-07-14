import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/ui/plank/plank_record_chart.dart';
import 'package:flutter_study/ui/plank/plank_timer_view.dart';
import 'package:intl/intl.dart';

//TODO: 页面返回是 provider 没有释放，会继续计时， 还需要解决 set 最高记录或其他数据时 如何同时更新页面
class PlankHome extends StatelessWidget {
  const PlankHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text("Plank"),
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
        body: _buildScaffoldBody(context),
      );

  // final PageController _pageController = PageController(initialPage: 2);

  Widget _buildScaffoldBody(BuildContext context) => PageView(
        scrollDirection: Axis.horizontal,
        children: [PlankTimerView(), const PlankRecordChart()],
      );
}

extension FormatTime on int {
  String toMilliSecondString() {
    final time = this;
    final milliseconds = ((time % 1000) / 10).truncate();
    final second = (time / 1000).truncate() % 60;
    final min = (time / 1000 / 60).truncate();
    return '${min.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
  }

  String toSecondString() {
    final time = this;
    final second = (time / 1000).truncate() % 60;
    final min = (time / 1000 / 60).truncate();
    return '${min.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  String toDateDayString() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    if (dateTime.year == DateTime.now().year) {
      DateFormat dateFormat = DateFormat('MM-dd');
      return dateFormat.format(dateTime);
    } else {
      DateFormat dateFormat = DateFormat('yy-MM-dd');
      return dateFormat.format(dateTime);
    }

  }
}

extension DateCompare on int {
  bool isSameDayWith(int timeStamp) {
    final dateTimeA = DateTime.fromMillisecondsSinceEpoch(this);
    final dateTimeB = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return dateTimeA.year == dateTimeB.year &&
        dateTimeA.month == dateTimeB.month &&
        dateTimeA.day == dateTimeB.day;
  }
}
