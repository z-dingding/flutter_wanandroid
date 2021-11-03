
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/states/locale.dart';
import 'package:flutter_wanandroid/states/theme.dart';
import 'package:provider/provider.dart';



class LanguageRoute extends StatelessWidget {
  const LanguageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GmLocalization gm = GmLocalization.of(context);
    LocaleState locale = Provider.of<LocaleState>(context,listen: false);
    ThemeState theme = Provider.of<ThemeState>(context,listen: false);

    ///构建列表项,注意,参数可以不写类型(省去了强转),也可以写类型
    Widget _buildListItem(String lan, value){
      return ListTile(
        //如果当前列表项是当前语言,则改变字体颜色
        title: Text(lan,style: TextStyle(
          color:  locale.locale == value? theme.theme  : null,
        ),),
        trailing: Icon(locale.locale == value? Icons.done  : null ),
        onTap: (){
          locale.locale = value;
        },
      );
    }
    //注意:return之后不能在获取类变量
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.languages),
      ),
      body: ListView(
        children: [
          _buildListItem(gm.zhName,"zh_CN"),
          _buildListItem(gm.enName,"en_US"),
          _buildListItem(gm.autoName,null),
        ],
      ),
    );
  }


}
