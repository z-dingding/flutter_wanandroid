

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/models/articlelist_entity.dart';
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
      appBar: AppBar(title: Text(widget.title),
      bottom:  PreferredSize(
      child: _progressBar(linearprogress,context),
      preferredSize: Size.fromHeight(3.0),
      )),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (url){
          print("onPageStarted"+url);
        },
        onPageFinished: (url){
          print("onPageFinished"+url);
        },
        onProgress: (progress){
           setState(() {
             linearprogress = progress/100;
           });
        },
      ),
    );
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
