
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/articlelist_entity.dart';
import 'package:flutter_wanandroid/models/systemlist_entity.dart';
import 'package:flutter_wanandroid/utils/toast.dart';

class SystemListRoute extends StatefulWidget {
  const SystemListRoute({Key? key}) : super(key: key);

  @override
  _SystemListRouteState createState() => _SystemListRouteState();
}

class _SystemListRouteState extends State<SystemListRoute> with AutomaticKeepAliveClientMixin {
  SystemlistEntity? systemlistEntity;

  @override
  void initState() {
    super.initState();
    requestData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
         child: systemlistEntity != null ? _buildItem() : null,
    );
  }


  ///请求体系数据
 void requestData() async{
    var res = await HttpManager.instance.get(Api.system_api);
    setState(() {
      systemlistEntity = SystemlistEntity().fromJson(res);
    });

 }

///构建页面
Widget _buildItem(){
    return ListView(
      children: systemlistEntity!.data!.asMap().keys.map((index) =>
          Padding(
        padding: EdgeInsets.all(10),
          child:Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child:  Text(systemlistEntity!.data![index].name!,style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold
            ),),
          ),
          _buildChapterView(index),
        ],
      ) ,)).toList(),
    );
}

 Widget _buildChapterView(index){
    var childItem = systemlistEntity!.data![index].children;
    return Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.start, //沿主轴方向居左
      runAlignment:  WrapAlignment.start,
      children:childItem!.map((e) =>
         OutlinedButton(
          onPressed: () => chapterItemClick(e),
          child: Text(e.name!),
          style: ButtonStyle( shape:  MaterialStateProperty.all(
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(6))
          ),  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20)),
          ),),

      ).toList(),
    );
  }


  void chapterItemClick(SystemlistDataChildren e){
    showToast(e.name!);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
