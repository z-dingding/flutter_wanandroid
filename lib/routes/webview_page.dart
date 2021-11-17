

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/articlelist_entity.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewRoute extends StatefulWidget {
   WebViewRoute({Key? key,required this.url ,required this.id,required this.title,required this.isCollect}) : super(key: key);

  final String url;
  final String title;
  final int id;
  late bool isCollect;


  @override
  _WebViewRouteState createState() => _WebViewRouteState();
}

class _WebViewRouteState extends State<WebViewRoute> {

  var linearprogress = 0.0;


  @override
  Widget build(BuildContext context) {
    GmLocalization  gm = GmLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom:  linearprogress != 1 ? PreferredSize(
          child: _progressBar(linearprogress,context),
          preferredSize: Size.fromHeight(3.0),
        ) : null),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (url){
          print("onPageStarted==>"+url);
        },
        onPageFinished: (url){
          print("onPageFinished==>"+url);
        },
        onProgress: (progress){
           setState(() {
             linearprogress = progress/100;
           });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:FloatingActionButton(
        child: widget.isCollect ? Image.asset("assets/images/collection_sel.png",width: 45,height: 45,):Image.asset("assets/images/collection_nor.png",width: 45,height: 45),
        onPressed: () {
          if(widget.isCollect){
            //取消收藏
            _unCollection(context);
          }else{
            //收藏
            _collection(context);
          }
        },) ,
    );
  }


  ///取消收藏接口函数
  void _unCollection(BuildContext context) async{
    var res = await HttpManager.instance.post(Api.unCollectionFromSite(widget.id),isLoding: true,context: context);
     var code = res['errorCode'];
    if(code == 0){
      setState(() {
        widget.isCollect = false;
      });
    }
  }
  ///收藏函数
  void _collection(BuildContext context) async{
    var res = await HttpManager.instance.post(Api.collectionFromSite(widget.id),isLoding: true,context: context);
    var code = res['errorCode'];
    if(code == 0){
      setState(() {
        widget.isCollect = true;
      });
    }
  }
  ///更新加载进度
  Widget _progressBar(progress,context){
    return  LinearProgressIndicator(
      backgroundColor: Colors.white70,
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
    );
  }



}
