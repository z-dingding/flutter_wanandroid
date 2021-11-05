
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/answer_entity.dart';
import 'package:flutter_wanandroid/routes/webview_page.dart';


class AnswerRoute extends StatefulWidget {

  const AnswerRoute({Key? key}) : super(key: key);

  @override
  _AnswerRouteState createState() => _AnswerRouteState();
}

class _AnswerRouteState extends State<AnswerRoute> with AutomaticKeepAliveClientMixin {

  late AnswerEntity answerEntity;
  //问答列表数据源
  List<AnswerDataDatas> items = [] ;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title:Text(gm.answer),),
      body: Container(
        width: double.infinity,
        child: Column(
           children: [
             _bulidListView(context),
           ],
        ),
      ),
    );
  }


  ///保持当前页面状态
  @override
  bool get wantKeepAlive =>  true;

///构建列表项
Widget _bulidListView(context){
  return Expanded(child: InfiniteListView(
    onRetrieveData: (int pageNum, List<AnswerDataDatas> list ,bool refersh) async{
      //页码，拼接在连接中，从0开始。
      var res = await HttpManager.instance.get(Api.answerList(pageNum-1),isRefresh:pageNum == 1,isList: true,isCache: true );
      answerEntity =   AnswerEntity().fromJson(res) ;
      items.addAll(answerEntity.data!.datas!);
      //每次都更新列表中的数据
      list.clear();
      list.addAll(items);
      //true加载更多，false没有更多数据了
      return items.length  <  answerEntity.data!.total!;
    },
    itemBuilder: ( List<AnswerDataDatas>items,int index,BuildContext context){
      return _buildItems(items[index],context);
    },
  ));
}


///构建列表项
Widget _buildItems(AnswerDataDatas item,BuildContext ctx){
  return ConstrainedBox(
    //先给子组件设置宽度
      constraints: BoxConstraints(
    minWidth: double.infinity
  ),child:GestureDetector(
    onTap: () => _itemClick(item),
    child: Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
         color: Colors.grey.shade200
      ),
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           ListTile(
             dense: true,
             contentPadding: EdgeInsets.all(0.0),
             leading: Text(item.author!),
             title: Text(item.chapterName ?? item.tags![0].name!),
             trailing:Text(item.shareDate!.toString()) ,
           ),
           Padding(
               padding: EdgeInsets.all(0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(item.title!,style: TextStyle(
                 color: Colors.black,
                 fontSize: 18
               ),overflow: TextOverflow.ellipsis,
                 maxLines: 2,),
               Text(item.desc!, overflow: TextOverflow.ellipsis,
                 maxLines: 1,)
             ],
           ),),
           ListTile(
             contentPadding: EdgeInsets.all(0.0),
             leading: Text(item.tags![0].name!+"."+item.tags![1].name!),
           )
         ],
      ),
    ) ,
  ),) ;
}

///列表项的点击事件
  _itemClick(AnswerDataDatas bean){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WebViewRoute(url: bean.link!, id: bean.id!, title: bean.title!, isCollect: bean.collect!);
    }));
}




}
