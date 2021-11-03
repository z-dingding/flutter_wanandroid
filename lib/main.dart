import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/routes/language_page.dart';
import 'package:flutter_wanandroid/routes/login_page.dart';
import 'package:flutter_wanandroid/routes/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_wanandroid/routes/setting_page.dart';
import 'package:flutter_wanandroid/routes/theme_page.dart';
import 'package:flutter_wanandroid/routes/webview_page.dart';
import 'package:flutter_wanandroid/states/locale.dart';
import 'package:flutter_wanandroid/states/theme.dart';
import 'package:flutter_wanandroid/states/user.dart';
import 'package:provider/provider.dart';
import 'common/global.dart';

void main() => Global.init().then((value) => runApp(MyApp()));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: ThemeState()),
      ChangeNotifierProvider.value(value: LocaleState()),
      ChangeNotifierProvider.value(value: UserState()),
    ],
      //Consumer 使用了 Builder模式，收到更新通知就会通过 builder 重新构建。Consumer<T> 代表了它要获取哪一个祖先中的 Model。
    child: Consumer2<ThemeState,LocaleState>(
      //Consumer 的 builder 实际上就是一个 Function，它接收三个参数 (BuildContext context, T model, Widget child)
    builder: (BuildContext context,theme,locale,Widget? child){
        return MaterialApp(
          title: GmLocalization.of(context).title,
          theme: ThemeData(
            primaryColor: theme.theme as MaterialColor,
          ),
          home: MainRoute(),
          routes: {
            "theme":(context) =>ThemeRoute(),
            "language":(context) =>LanguageRoute(),
            "login":(context) =>LoginRoute(),
            "setting":(context) =>SettingRoute(),
          },
          //用户设置的语言
          locale: locale.getLocal(),
          //支持的语言
          supportedLocales: [
            const Locale("en","US"),
            const Locale("zh","CN"),
          ],
          localizationsDelegates: [
            //本地化代理类
            //GlobalMaterialLocalizations.delegate 为Material 组件库提供的本地化的字符串和其他值
            GlobalMaterialLocalizations.delegate,
            //GlobalWidgetsLocalizations.delegate定义组件默认的文本方向，从左到右或从右到左
            GlobalWidgetsLocalizations.delegate,
            //注册我们自己的delegate
            GmLocalizationDelegate(),
          ],
          localeResolutionCallback: (Locale? _locale,Iterable<Locale>supportedLocales){
            if(locale.getLocal() != null){
              //如果已经选定语言，则不跟随系统
              return locale.getLocal();
            }else{
              //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
              //则默认使用美国英语
              if(supportedLocales.contains(_locale)){
                return _locale;
              }else{
                return Locale("en","US");
              }
            }
          },
        );
      },
    ),);



  }
}

