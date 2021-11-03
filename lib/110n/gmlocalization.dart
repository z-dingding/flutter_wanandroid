

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

///主要实现提供了本地化值,实例将会在Delegate类的load方法中创建
class GmLocalization {
  
  GmLocalization(this.isZh);
  
  //是否为中文
  bool isZh = false;

static GmLocalization of(BuildContext context){
  var localization = Localizations.of(context,GmLocalization);
  return localization == null ?  GmLocalization(false) :localization;
}

String get pleasewait => isZh? "敬请期待": "please wait";
String get title => isZh? "玩安卓": "WanAndroid";
String get home => isZh? "首页" : "Home";
String get answer => isZh? "问答" : "Answer";
String get system => isZh? "体系" : "System";
String get official => isZh? "公众号" : "Official";
String get my => isZh? "我的" : "My";
String get notlogin => isZh? "未登录" : "not login";

String get languages => isZh? "语言" : "languages";
String get theme => isZh? "主题" : "themes";
String get setting => isZh? "设置" : "setting";

String get zhName => isZh? "中文简体" : "Chinese simplified";
String get enName => isZh? "英语" : "English";
String get autoName => isZh? "自动" : "Auto";

String get login => isZh? "登录" : "Login";
String get account => isZh? "账号" : "Account";
String get account_hint => isZh? "请输入账号" : "please write account";
String get pwd => isZh? "密码" : "Pwd";
String get pwd_hint => isZh? "请输入密码" : "please write password";

  String get userNameRequired{
    return isZh ? "请输入用户名":"userNameRequired";
  }
  String get passwordRequired{
    return isZh ? "请输入密码":"passwordRequired";
  }

String get unknown => isZh? "未知" : "unknown";
String get no_revalentMessage => isZh? "暂无相关信息" :"No relevant information is available";

///设置页面相关
  String get setting_logout => isZh? "退出登录" : "loginOut";
  String get setting_version => isZh? "当前版本" : "version";
  String get settting_logout_hint => isZh? "确定退出?" : "Sure to quit?";
  ///公用的文字
  String get common_hint => isZh? "提示" : "Hint";
  String get common_sure => isZh? "确定" : "Sure";
  String get common_cancel => isZh? "取消" : "Cancel";
  String get common_success => isZh? "操作成功" : "successful";
  String get common_fail => isZh? "操作失败" : "failure";



}

///Delegate类的职责是在Locale改变时加载新的Locale资源
class GmLocalizationDelegate extends LocalizationsDelegate<GmLocalization>{

  const GmLocalizationDelegate();

  //是否支持该语言
  @override
  bool isSupported(Locale locale) {
  return ["en","zh"].contains( locale.languageCode);
  }

  //加载对应的locale资源
  @override
  Future<GmLocalization> load(Locale locale) {
        return SynchronousFuture(GmLocalization(locale.languageCode == "zh"));
  }

  //当localizations组件重新构建时，是否调用load方法重新加载locale资源
  @override
  bool shouldReload(covariant LocalizationsDelegate<GmLocalization> old) {
   return false ;
  }


}