

import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/official_history_entity.dart';
import 'package:flutter_wanandroid/routes/webview_page.dart';

class OfficialListRoute extends StatefulWidget {

  const OfficialListRoute({Key? key,required this.chapterId}) : super(key: key);

  //公众号的id
  final int chapterId ;

  @override
  _OfficialListRouteState createState() => _OfficialListRouteState();
}

class _OfficialListRouteState extends State<OfficialListRoute> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 10),
      child:InfiniteListView(onRetrieveData: (int pageNum,List<OfficialHistoryDataDatas> items,bool refresh) async{
        var res = await HttpManager.instance.get(Api.officialHistoryList(widget.chapterId, pageNum -1 ));
        OfficialHistoryEntity officialHistoryEntity = OfficialHistoryEntity().fromJson(res);
         if(refresh){
           items.clear();
           items.addAll(officialHistoryEntity.data!.datas!);
         }else{
           items.addAll(officialHistoryEntity.data!.datas!);
         }
        return items.length < officialHistoryEntity.data!.total!;
      },itemBuilder: (List<OfficialHistoryDataDatas> list, int index, BuildContext ctx){
        return _buildItem(list[index]);
      },),
    );
  }





  Widget _buildItem(OfficialHistoryDataDatas bean){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(bean.chapterName!,style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                ),),
                Text(bean.niceShareDate!,style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                ),),
              ],
            ),
            Text(bean.title!,style: TextStyle(
                color: Colors.black,
                fontSize: 18
            ),),
            Text(bean.superChapterName!,style: TextStyle(
                color: Colors.grey,
                fontSize: 12
            ),)
          ],
        ),
        highlightColor: Colors.grey,
        onTap:() => _itemClick(bean),
      ),
    );
  }

  void _itemClick(OfficialHistoryDataDatas bean){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WebViewRoute(url: bean.link!, id: bean.id!, title: bean.title!, isCollect: bean.collect!);
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
