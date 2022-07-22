import 'package:flutter_riverpod/flutter_riverpod.dart';

final wechatHomeDataProvider =
    StateNotifierProvider<WechatHomeViewModel, int>((ref) {
  return WechatHomeViewModel();
});

class WechatHomeViewModel extends StateNotifier<int> {
  WechatHomeViewModel() : super(0);
  void updateIndex(int index) {
    state = index;
  }
}
