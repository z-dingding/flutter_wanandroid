
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/common/global.dart';
import 'package:flutter_wanandroid/states/user.dart';
import 'package:provider/provider.dart';

class MyRoute extends StatefulWidget {
  const MyRoute({Key? key}) : super(key: key);

  @override
  _MyRouteState createState() => _MyRouteState();
}

class _MyRouteState extends State<MyRoute> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //隐藏底部阴影分割线
        elevation: 0,
        title:Text(gm.my),),
      //注意再Containner中设置color会作用于整个屏幕
      body:Container(
        width: double.infinity,
        child: Column(
          children: [
           _buildHeader(context),
           _buildBody(context,gm),
          ],
        ),
      ) ,
    );
  }

  ///头部信息构建
  Widget _buildHeader(BuildContext context){
    GmLocalization gm = GmLocalization.of(context);
    //注意:只需要一个参数的时候用的是Consumer,两个是Consumer2
    return Consumer<UserState>(builder: (BuildContext context,userState,Widget? child){
    return Container(
      width: double.infinity,
      height: 140,
      color: Theme
          .of(context)
          .primaryColor,
      child: Row(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
            child: ClipOval(
              child: Image.asset("assets/images/avatar.png"),
            ),),
          TextButton(onPressed: () =>{
            if(!userState.isLogin){
              Navigator.pushNamed(context, "login"),
            }
          }, child: Text(userState.isLogin ? Global.profile.user!.username!:gm.notlogin,),style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          )
        ],
      ),
    );
    });

  }

  ///主信息构建
  Widget _buildBody(BuildContext context,GmLocalization gm){
     return Expanded(child:  ListView(
       children: ListTile.divideTiles(
           context: context,
           color: Theme.of(context).primaryColor,
           tiles: [
         ListTile(
           leading: const Icon(Icons.color_lens),
           title: Text(gm.theme),
           trailing: const Icon(Icons.arrow_forward_ios),
           onTap: (){
             Navigator.pushNamed(context,"theme");
           },
         ),
         //Divider(height: 0,thickness:1.0,indent:10.0,endIndent:10.0,color: Colors.grey,),
         ListTile(
           leading: const Icon(Icons.language),
           title: Text(gm.languages),
           trailing: const Icon(Icons.arrow_forward_ios),
           onTap: (){
             Navigator.pushNamed(context,"language");
           },
         ),
         ListTile(
           leading: const Icon(Icons.settings),
           title: Text(gm.setting),
           trailing: const Icon(Icons.arrow_forward_ios),
           onTap: (){
             Navigator.pushNamed(context,"setting");
           },
         ),
       ]).toList(),
     ),);

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>  true; ///保持当前页面状态

}


