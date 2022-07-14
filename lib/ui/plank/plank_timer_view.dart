import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/ui/plank/plank_home.dart';
import 'package:flutter_study/ui/plank/plank_view_model.dart';

//ignore: must_be_immutable
class PlankTimerView extends ConsumerWidget {
  PlankTimerView({Key? key}) : super(key: key);

  Timer? _timer;

  //是否开始计时
  bool _isTiming = false;

  void _startTiming(WidgetRef ref) {
    ref
        .read(plankDataProvider.notifier)
        .onTimingStart(DateTime.now().millisecondsSinceEpoch);
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      _timer = timer;
      ref.read(plankDataProvider.notifier).updateDuration();
    });
  }

  void _stopTiming(WidgetRef ref) {
    _timer?.cancel();
    _timer = null;
    ref.read(plankDataProvider.notifier).onTimingStop();
  }

  void _onTimeClicked(BuildContext context, WidgetRef ref) {
    _isTiming = !_isTiming;
    if (_isTiming) {
      _startTiming(ref);
    } else {
      final duration = ref.watch(plankDataProvider).duration;
      showDialog(
          context: context,
          builder: (ctx) =>
              _buildAlertDialog(context , duration));
      _stopTiming(ref);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PlankContent plankContent = ref.watch(plankDataProvider);
    return WillPopScope(
      onWillPop: () {
        _stopTiming(ref);
        return Future.value(true);
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: CircularProgressIndicator(
                  value: plankContent.progress,
                  backgroundColor: plankContent.backgroundColor,
                  valueColor:
                      AlwaysStoppedAnimation(plankContent.foregroundColor),
                  strokeWidth: 6,
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: Center(
                      child: Text(
                    '最高记录: ${plankContent.highestRecord.toSecondString()}',
                    style: const TextStyle(fontSize: 20, color: Colors.amber),
                  )),
                )),
            GestureDetector(
              onTap: () {
                _onTimeClicked(context, ref);
              },
              child: Text(
                plankContent.duration.toMilliSecondString(),
                style: const TextStyle(fontSize: 45),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAlertDialog(BuildContext context, int duration) => AlertDialog(
      title: const Text('恭喜!!!'),
  content: Text('本次平板支撑时间为: ${duration.toSecondString()}，向右滑动查看时间统计。'),
    actions: [ElevatedButton(onPressed: () {
      Navigator.pop(context);
    }, child: const Text('OK'))],
  );
}
