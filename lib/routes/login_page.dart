

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/common/global.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/user_entity.dart';
import 'package:flutter_wanandroid/states/user.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {

  const LoginRoute({Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}


class _LoginRouteState extends State<LoginRoute> {

  //用户名控制器
  TextEditingController accountController = TextEditingController();
  //密码控制器
  TextEditingController pwdController = TextEditingController();

  //设置Form的key,方便进行Form的状态验)
  GlobalKey _formKey = GlobalKey<FormState>();
  //用户名输入框是否自动获取焦点
  var accountAutoFocus  =true;

  //是否显示密码
  bool isShowPwd = false ;

  @override
  void initState() {
    //自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    accountController.text = Global.profile.user?.username != null ? Global.profile.user!.username : "";
    if (accountController.text.isNotEmpty) {
      accountAutoFocus = false;
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    GmLocalization gm = GmLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(padding: EdgeInsets.all(16),
        child: Form(
             //验证表单内容
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
          children: [
            TextFormField(
              //是否获取焦点
              autofocus: accountAutoFocus,
               controller: accountController,
              decoration: InputDecoration(
                labelText: gm.account,
                hintText: gm.account_hint,
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v){
                return v!.trim().isNotEmpty ? null : gm.userNameRequired;
              },
            ),
            TextFormField(
              autofocus: !accountAutoFocus,
              controller: pwdController,
              decoration: InputDecoration(
                labelText: gm.pwd,
                hintText: gm.pwd_hint,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        isShowPwd = !isShowPwd ;
                      });
                    },
                    icon:Icon(isShowPwd ? Icons.visibility_off:Icons.visibility)),
              ),
              //是否隐藏输入，true密码样式显示，false明文显示
              obscureText: !isShowPwd,
              validator: (v){
                return v!.trim().isNotEmpty ? null : gm.passwordRequired;
              },
            ),
            Padding(padding: const EdgeInsets.only(top: 25),
              child: ConstrainedBox(
                //BoxConstraints.expand()可以生成一个尽可能大的容器
                constraints: BoxConstraints.expand(height: 55),
                child: ElevatedButton(
                  onPressed: (){
                    _onLogin();
                  },
                  child:Text(gm.login),
                  style: ButtonStyle(
                    //设置按钮上字体与图标的颜色
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  ///登录事件
  void _onLogin() async{
    //提交之前，首先验证各个表单字段是否合法
    if((_formKey.currentState as FormState).validate()){
      //展示加载loading
      showLoading(context);
       UserData? user ;
      try{
        var parameter = {"username" : accountController.text,"password" : pwdController.text};
        var res =await HttpManager.instance.post(Api.login_api,queryParams: parameter);
        user = UserEntity().fromJson(res).data;
        //存储到本地

        //因为登录返回后，首页会被创建，所以我们传false,更新user后不会触发更新
        Provider.of<UserState>(context,listen: false).userData = user;
      }catch(e){
        //Null check operator used on a null value
        //如果登录失败则提示错误
        showToast(e.toString());
        print(e.toString());
      }finally{
        //注意
        //隐藏loading框
        Navigator.of(context).pop();
      }
      if(user != null){
        //返回
        Navigator.of(context).pop();
      }
    }
  }
}
