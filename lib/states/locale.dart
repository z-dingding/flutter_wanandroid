
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/common/global.dart';
import 'changenotifier.dart';

class LocaleState extends ChangeNotifierProvider {

  ///获取配置的locale对象
  Locale? getLocal(){
    if( Global.profile.locale == null || Global.profile.locale!.isEmpty) return null ;
    var t = Global.profile.locale!.split("_");
    return Locale(t[0],t[1]);
  }

  ///本地locale的get函数
  String get locale => Global.profile.locale ;

  //set本地locale
  set locale(String locale){
    if(Global.profile.locale  !=locale ){
      Global.profile.locale = locale;
      notifyListeners();
    }

  }


}