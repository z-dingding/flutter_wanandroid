
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/common/global.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/states/user.dart';
import 'package:flutter_wanandroid/utils/packageinfo.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:provider/provider.dart';

class SettingRoute extends StatelessWidget {
  const SettingRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalization gm = GmLocalization.of(context);
    return Scaffold(
       appBar:AppBar(
         title: Text(gm.setting),
       ) ,
      body: Consumer<UserState>(
        builder: (BuildContext context,userState,Widget? child){
         return Container(
            width: double.infinity,
            child: Column(
              children: [
                ListTile(
                  title: Text(gm.setting_version),
                  //注意:在常量组件中不能使用任何变量值
                  trailing:  Text(PackageInfoUtil.getAppName(),),
                ),
                Divider(height: 0,thickness:1.0,indent:10.0,endIndent:10.0,color: Colors.grey,),
                if(Global.profile.user != null) Padding(padding: EdgeInsets.symmetric(vertical: 50,horizontal: 16),
                  child:ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55),
                    child: ElevatedButton(
                      onPressed:(){
                        _logoutFun(context,gm,userState);
                      },
                      child: Text(gm.setting_logout),
                      style: ButtonStyle(
                        //背景颜色
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                          //文字颜色
                          foregroundColor: MaterialStateProperty.all(Colors.white)
                      ),
                    ),
                  ) ,)
              ],
            ),
          );
        },
      )
    );
  }

  ///退出登录
  _logoutFun(BuildContext context,GmLocalization gm,UserState userState) {
    showConfirmDialog(context, gm.settting_logout_hint,true, () async {
      //点击确定按钮的回调
      var res = await HttpManager.instance.get(Api.logout_api);
      if(res["errorCode"] == 0){
        showToast(gm.common_success);
        userState.userData =null;
      }
    });

  }
}
