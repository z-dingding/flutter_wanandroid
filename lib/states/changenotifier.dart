
import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid/common/global.dart';

class ChangeNotifierProvider extends ChangeNotifier{

@override
  void notifyListeners() {
  //保存最新的用户配置
    Global.saveProfile();
    super.notifyListeners();
  }
}