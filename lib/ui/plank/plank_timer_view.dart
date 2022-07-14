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
    ref.read(plankDataProvider.notifier).onTimingStart(DateTime.now().millisecondsSinceEpoch);
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

  void _onTimeClicked(WidgetRef ref) {
    _isTiming = !_isTiming;
    if (_isTiming) {
      _startTiming(ref);
    } else {
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
                _onTimeClicked(ref);
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
}
