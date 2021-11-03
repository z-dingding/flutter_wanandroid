
import 'package:flutter_wanandroid/common/global.dart';
import 'package:flutter_wanandroid/models/user_entity.dart';

import 'changenotifier.dart';

class UserState extends  ChangeNotifierProvider{

  ///用户是否登录
  bool get isLogin => Global.profile.user == null ? false : true;

  UserData? get userData => Global.profile.user;

  set userData (UserData? user){
    Global.profile.user = user;
    notifyListeners();
  }


}