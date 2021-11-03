import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/common/default.dart';
import 'package:flutter_wanandroid/states/theme.dart';
import 'package:provider/provider.dart';

class ThemeRoute extends StatelessWidget {
  const ThemeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalization gm = GmLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.theme),
      ),
      body: ListView(
        children: DefaultData.themes
            .map((e) => GestureDetector(
                  child: Padding(
                    padding:const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    child: Container(
                      height: 40,
                      color: e,
                    ),
                  ),
                  onTap: (){
                    //主题更新后，MaterialApp会重新构建
                    Provider.of<ThemeState>(context,listen: false).theme = e ;
                  },
                ))
            .toList(),
      ),
    );
  }


}
