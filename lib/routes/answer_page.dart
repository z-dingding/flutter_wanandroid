
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';

class AnswerRoute extends StatefulWidget {

  const AnswerRoute({Key? key}) : super(key: key);

  @override
  _AnswerRouteState createState() => _AnswerRouteState();
}

class _AnswerRouteState extends State<AnswerRoute> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title:Text(gm.answer),),
      body: Center(
        child: Text(gm.answer),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>  true; ///保持当前页面状态
}
