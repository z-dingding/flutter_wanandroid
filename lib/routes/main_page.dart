import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/common/icondata.dart';
import 'package:flutter_wanandroid/routes/answer_page.dart';
import 'package:flutter_wanandroid/routes/home_page.dart';
import 'package:flutter_wanandroid/routes/my_page.dart';
import 'package:flutter_wanandroid/routes/official_page.dart';
import 'package:flutter_wanandroid/routes/system_page.dart';

class MainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainRouteState();
  }
}

class _MainRouteState extends State {
  //选中的tab索引
  int _currentTabIndex = 0;

  late List<Widget> pages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentTabIndex);
    pages = [
      HomeRoute(),
      AnswerRoute(),
      SystemRoute(),
      OfficialRoute(),
      MyRoute()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        //pageview禁止滑动
        //physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return pages[index];
        },
        onPageChanged: _onPageChange,
        //每次滑动是否强制切换整个页面，如果为false，则会根据实际的滑动距离显示页面
        pageSnapping: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          onTabTap(index);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(IconDatas.home),
              label: GmLocalization.of(context).home),
          BottomNavigationBarItem(
              icon: Icon(IconDatas.answer),
              label: GmLocalization.of(context).answer),
          BottomNavigationBarItem(
              icon: Icon(IconDatas.system),
              label: GmLocalization.of(context).system),
          BottomNavigationBarItem(
              icon: Icon(IconDatas.official),
              label: GmLocalization.of(context).official),
          BottomNavigationBarItem(
              icon: Icon(IconDatas.my), label: GmLocalization.of(context).my),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  ///底部导航点击函数
  onTabTap(int index) {
    if (_currentTabIndex != index) {
      setState(() {
        _currentTabIndex = index;
      });
      _pageController.jumpToPage(index);
    }
  }

  ///PageView滑动触发
  _onPageChange(int index) {
      setState(() {
        _currentTabIndex = index;
      });
  }
}
