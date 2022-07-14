import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/ui/wechat/chat/wechat_chat.dart';
import 'package:flutter_study/ui/wechat/contacts/wechat_contact.dart';
import 'package:flutter_study/ui/wechat/discover/wechat_discover.dart';
import 'package:flutter_study/ui/wechat/me/wechat_me.dart';

class WeChatHomePage extends StatelessWidget {
  WeChatHomePage({Key? key}) : super(key: key);

  final tabbarTitles = ['Chat', 'Contact', 'Discover', 'Me'];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('WeChat')),
        body: _buildScaffoldBody(),
        bottomNavigationBar: _buildTabbar(),
      );

  Widget _buildScaffoldBody() => PageView(
        children: [ChatListPage(), ContactPage(), DiscoverPage(), MePage()],
      );

  Widget _buildTabbar() => CupertinoTabBar(
      items: tabbarTitles
          .map((e) => BottomNavigationBarItem(
              icon: const Icon(Icons.access_alarm), label: e))
          .toList());
}
