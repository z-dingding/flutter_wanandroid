
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/default.dart';
import 'package:flutter_wanandroid/common/global.dart';
import 'package:flutter_wanandroid/states/changenotifier.dart';

class ThemeState extends ChangeNotifierProvider{

  //如果没有匹配的主题,默认blue
  // ignore: unrelated_type_equality_checks
  ColorSwatch get theme => DefaultData.themes.firstWhere((element) => element.value == Global.profile.theme,orElse: () => Colors.blue);


   set theme(ColorSwatch color){
     Global.profile.theme = color[500]!.value;
     notifyListeners();
   }

}
