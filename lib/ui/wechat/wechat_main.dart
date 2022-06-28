import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeChatHomePage extends StatelessWidget {
  const WeChatHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WeChat')),
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    return Center();
  }
}
