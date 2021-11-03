

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
import 'package:flutter_wanandroid/models/cacheconfig_entity.dart';
import 'package:flutter_wanandroid/models/profile_entity.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';

class Global {

  static ProfileEntity profile =  ProfileEntity();
  static late SharedPreferences sharePref;
  static late PackageInfo  packageInfo ;

///全局初始化
  static Future init() async{
    //解决Unhandled Exception: Null check operator used on a null value
    WidgetsFlutterBinding.ensureInitialized();
    //返回Future对象
    sharePref = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();

    var _profile = sharePref.getString(Const.KEY_PROFILE);
    if(_profile != null &&_profile.isNotEmpty){
      profile = JsonConvert.fromJsonAsT(jsonDecode(_profile));
    }

  //如果没有缓存策略,设置缓存策略
    profile.cache =  profile.cache ?? CacheconfigEntity()
      ..maxCount = 100
      ..maxAge = 3600
      ..enable = true;

  }


  ///保存用户配置信息
  static saveProfile(){
    sharePref.setString(Const.KEY_PROFILE, jsonEncode(profile));
}



}