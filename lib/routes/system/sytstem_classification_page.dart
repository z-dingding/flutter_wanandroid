
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/systemclassification_entity.dart';

import '../webview_page.dart';

class ClassificationRoute extends StatefulWidget {

  final String title;
  final int id;

   ClassificationRoute({Key? key, required this.title, required this.id}) : super(key: key);

  @override
  _ClassificationRouteState createState() => _ClassificationRouteState();

}

class _ClassificationRouteState extends State<ClassificationRoute> {

  late SystemclassificationData _systemclassificationData;
  
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: _buildContent(),
      ),
    );
  }



  ///构建页面内容
 Widget _buildContent(){
    return InfiniteListView(
      onRetrieveData: (int pageNum,List<SystemclassificationDataDatas> datas,bool refersh) async{
        var res = await HttpManager.instance.get(Api.systemclassificationlist(pageNum -1,widget.id),isRefresh: refersh,isList:true ,isCache: true);
        _systemclassificationData =SystemclassificationEntity().fromJson(res).data!;
       if(refersh){
         datas.clear();
         datas.addAll(_systemclassificationData.datas!);
       }else{
         datas.addAll(_systemclassificationData.datas!);
       }
        return datas.length < _systemclassificationData.total!;
      },
      itemBuilder: ( List<SystemclassificationDataDatas>items,int index,BuildContext context){
        return _buildItems(items[index],context);
      },
    );
 }



 ///构建Item
 Widget _buildItems(SystemclassificationDataDatas item,BuildContext context){
  GmLocalization gm = GmLocalization.of(context);
    return GestureDetector(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 10),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(item.shareUser !=null && item.shareUser!.isNotEmpty ?item.shareUser! : item.author!,style: TextStyle(
                          color: Colors.grey
                      ),),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(gm.system_classification_new,style: TextStyle(
                            color: Theme.of(context).primaryColor
                        ),),
                      )
                    ],
                  ),
                  Text(item.niceShareDate !=null && item.niceShareDate!.isNotEmpty &&  item.niceShareDate != "未知时间"?item.niceShareDate! :item.niceDate!,style: TextStyle(
                      color: Colors.grey
                  ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: Text(item.title!,style: TextStyle(color: Colors.black),),
              ),
              Container(
                child:  Text(item.superChapterName!+"."+item.chapterName!,style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),),
              )
            ],
          ) ,
        ),
      ) ,
      onTap: () =>_itemClick(item.link!,item.id!,item.title!),
    );
 }

///列表项的点击
  _itemClick(String url,int id,String title){
    print(url);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WebViewRoute(url: url, id: id, title:title, isCollect: false);
    }));
  }
}



