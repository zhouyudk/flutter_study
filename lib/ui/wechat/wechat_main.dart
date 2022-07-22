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

  final bottomTabs = const [
    WeChatHomeTabBarData(title: 'Chat',
      unselectedIcon: 'assets/images/2.0x/tabbar_mainframe.png',
      selectedIcon: 'assets/images/2.0x/tabbar_mainframeHL.png'),
    WeChatHomeTabBarData(title: 'Contact',
        unselectedIcon: 'assets/images/2.0x/tabbar_contacts.png',
        selectedIcon: 'assets/images/2.0x/tabbar_contactsHL.png'),
    WeChatHomeTabBarData(title: 'Discover',
        unselectedIcon: 'assets/images/2.0x/tabbar_discover.png',
        selectedIcon: 'assets/images/2.0x/tabbar_discoverHL.png'),
    WeChatHomeTabBarData(title: 'Me',
        unselectedIcon: 'assets/images/2.0x/tabbar_me.png',
        selectedIcon: 'assets/images/2.0x/tabbar_meHL.png')];

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
        items: bottomTabs
            .map((tab) => BottomNavigationBarItem(
                icon:  Image.asset(tab.unselectedIcon, height: 20,), label: tab.title, activeIcon: Image.asset(tab.selectedIcon, height: 20,)))
            .toList());
  }
}

class WeChatHomeTabBarData {
   final String title;
   final String unselectedIcon;
   final String selectedIcon;

   const WeChatHomeTabBarData({required this.title, required this.unselectedIcon, required this.selectedIcon});
}
