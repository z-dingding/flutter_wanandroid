

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/official_entity.dart';

import 'officiallist_page.dart';

class OfficialRoute extends StatefulWidget {
  const OfficialRoute({Key? key}) : super(key: key);

  @override
  _OfficialRouteState createState() => _OfficialRouteState();
}

class _OfficialRouteState extends State<OfficialRoute> with AutomaticKeepAliveClientMixin {

  ///公众号标题集合
  List<OfficialData>  tabTitles = [] ;

  @override
  void initState() {
    super.initState();
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    return DefaultTabController(
      length: tabTitles.length,
      child:  Scaffold(
        appBar: AppBar(title: Text(gm.official),
        bottom: TabBar(
          isScrollable: true,
          tabs: tabTitles.map((e) => Tab(text: e.name)).toList(),
        ),),
        body: TabBarView(
          //physics: NeverScrollableScrollPhysics(),
          //可滚动组件子项缓存 KeepAlive
             children: tabTitles.map((e) => KeepAlive(
              keepAlive: true,
              child: OfficialListRoute(chapterId: e.id!,),
          )
          ).toList(),
        ),
      ),
    );
  }

  @override
  ///保持当前页面状态
  bool get wantKeepAlive =>  true;

  void requestData() async{
   var res = await HttpManager.instance.get(Api.official_api,isLoding: true);
   OfficialEntity officialEntity = OfficialEntity().fromJson(res);
   setState(() {
     tabTitles.addAll(officialEntity.data!);
   });
  }
}
