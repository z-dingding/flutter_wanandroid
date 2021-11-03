
import 'package:flutter_wanandroid/common/global.dart';

class PackageInfoUtil {


  ///获取app的版本名称
  static  String getAppName(){
    return Global.packageInfo.version;
  }

}