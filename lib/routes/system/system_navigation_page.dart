

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/navigation_entity.dart';
import 'package:flutter_wanandroid/routes/webview_page.dart';
import 'package:flutter_wanandroid/utils/toast.dart';

class NavigationListRoute extends StatefulWidget {
  const NavigationListRoute({Key? key}) : super(key: key);

  @override
  _NavigationListState createState() => _NavigationListState();
}

class _NavigationListState extends State<NavigationListRoute> with AutomaticKeepAliveClientMixin{

    NavigationEntity? _navigationEntity;

   @override
  void initState() {
    super.initState();
   request();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16),
       child: SingleChildScrollView(
         child:Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children:  _buildContent(),
         ),
      ),
    );
  }

   List<Widget>  _buildContent(){
     List<Widget> widgetLists = [] ;
     if(_navigationEntity != null) {
       for (var item in _navigationEntity!.data!) {
         widgetLists.add(Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(item.name!,
                 style: TextStyle(color: Colors.black, fontSize: 16),),
               Wrap(
                 direction: Axis.horizontal,
                 spacing: 10,
                 runSpacing: 5,
                 children: item.articles!.map((e) =>
                     ElevatedButton(onPressed: () => _itemClick(e),
                       child: Text(e.title!),
                       style: ButtonStyle(
                           shape: MaterialStateProperty.all(
                               BeveledRectangleBorder(borderRadius: BorderRadius
                                   .circular(6))
                           )
                       ),)).toList(),
               ),
             ],
           ),
         ));
       }
     }
   return widgetLists;
  }

  void _itemClick(NavigationDataArticles item){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WebViewRoute(isCollect: item.collect!, title: item.title!, url: item.link!, id: item.id!,);
    }));
  }
  void request() async{
    var res  = await HttpManager.instance.get(Api.navigationList,isLoding: true);
    setState(() {
      _navigationEntity = NavigationEntity().fromJson(res);
    });

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
