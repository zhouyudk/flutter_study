import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/ui/plank/plank_view_model.dart';

//TODO: 页面返回是 provider 没有释放，会继续计时， 还需要解决 set 最高记录或其他数据时 如何同时更新页面
class PlankHome extends ConsumerWidget {
  const PlankHome({Key? key}) : super(key: key);

  String _formatTime(int time) {
    final milliseconds = ((time % 1000)/10).truncate();
    final second = (time / 1000).truncate() % 60;
    final min = (time / 1000 / 60).truncate();
    return '${min.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Plank"),
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
      body: _buildScaffoldBody(context, ref),
    );
  }

  Widget _buildScaffoldBody(BuildContext context, WidgetRef ref) {
    PlankContent plankContent = ref.watch(plankDataProvider);
    return Center(
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
                  '最高记录: ${_formatTime(plankContent.highestRecord)}',
                  style: const TextStyle(fontSize: 20, color: Colors.amber),
                )),
              )),
          GestureDetector(
            onTap: () {
              ref.read(plankDataProvider.notifier).onTimeClicked();
            },
            child: Text(
              _formatTime(plankContent.time),
              style: const TextStyle(fontSize: 45),
            ),
          )
        ],
      ),
    );
  }
}
