import 'package:flutter/cupertino.dart';

mixin SetStateSafety<T extends StatefulWidget> on State<T> {
 /// safety call setState
  setStateSafety(VoidCallback f) {
    //判断当前页面是否已经销毁
    if (mounted) {
      setState(f);
    }
  }
}