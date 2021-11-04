
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/routes/system/system_navigation_page.dart';
import 'package:flutter_wanandroid/routes/system/system_system_page.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/widgets/system_appbar.dart';

class SystemRoute extends StatefulWidget {
  const SystemRoute({Key? key}) : super(key: key);

  @override
  _SystemRouteState createState() => _SystemRouteState();
}

class _SystemRouteState extends State<SystemRoute> with AutomaticKeepAliveClientMixin {

  //标题集合
  List<String> titles = [];
  //页面集合
  List<Widget> routes = [];
   //pageView的控制器
  late PageController _pageController;
 //当前选中的索引
 int  currentPage  = 0;

  @override
  void initState() {
    super.initState();
    routes.add(SystemListRoute());
    routes.add(NavigationListRoute());
    _pageController  = PageController(initialPage: currentPage,keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    titles.clear();
    titles.add(gm.system_title_system);
    titles.add(gm.system_title_navigation);

    return Scaffold(
      appBar: AppBar(
        title: SystemAppBar(currentPage,titles, _TitleChanged),
      ),
      body: PageView(
        children:routes ,
        controller: _pageController,
        onPageChanged: _onPageChange,
        pageSnapping:true,
      ),
    );
  }

  ///PageView滑动触发
  _onPageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

    ///接受子widget的回调函数
    void _TitleChanged(int index) {
    setState(() {
      currentPage  = index;
    });
      _pageController.jumpToPage(index);
    }

  ///保持当前页面状态
  @override
    bool get wantKeepAlive =>true;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }




  }




