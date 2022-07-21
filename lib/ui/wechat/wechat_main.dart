import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/ui/wechat/chat/wechat_chat.dart';
import 'package:flutter_study/ui/wechat/contacts/wechat_contact.dart';
import 'package:flutter_study/ui/wechat/discover/wechat_discover.dart';
import 'package:flutter_study/ui/wechat/me/wechat_me.dart';
import 'package:flutter_study/ui/wechat/wechat_home_view_model.dart';

class WeChatHomePage extends ConsumerWidget {
  WeChatHomePage({Key? key}) : super(key: key);

  final tabBarTitles = [('Chat', 'assets/images/2.0x/tabbar_mainframe.png',), ('Contact'), ('Discover'), ('Me')];

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: const Text('WeChat')),
        body: _buildScaffoldBody(),
        bottomNavigationBar: _buildTabBar(ref),
      );

  Widget _buildScaffoldBody() => PageView(
        children: [ChatListPage(), ContactPage(), DiscoverPage(), MePage()],
      );

  Widget _buildTabBar(WidgetRef ref) {
    final newIndex = ref.watch(wechatHomeDataProvider);
    return CupertinoTabBar(
        currentIndex: newIndex,
        onTap: (index) {
          ref.read(wechatHomeDataProvider.notifier).updateIndex(index);
        },
        items: tabBarTitles
            .map((e) => BottomNavigationBarItem(
                icon: const Icon(Icons.wechat), label: e))
            .toList());
  }
}

class WeChatHomeTabbar
