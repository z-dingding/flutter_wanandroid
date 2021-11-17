import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:fluttertoast/fluttertoast.dart';


//适用于Flutter的Android和iOS的Toast库。
void showToast(
    String text, {
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
    }) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 1,
    backgroundColor: Colors.grey[600], // 灰色背景
    fontSize: 16.0,
  );
}

//一个加载中的动画，不传text时，默认显示文字Loading...
void showLoading(context, [String text = "Loading..."]) {
  text = text;
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

//带有确定取消按钮的提示框，content是提示框的内容文字，confirmCallback是点击确定按钮的回调
void showConfirmDialog(BuildContext context,String content,bool isShowCancel ,Function confirmCallback) {
 GmLocalization gm = GmLocalization.of(context);
  showDialog(
    //点击外部不消失
    //  barrierDismissible: false,
      context: context,
      builder: (context) {
        return new AlertDialog(
          title: new Text(gm.common_hint),
          content: new Text(content),

          actions: <Widget>[
            if(isShowCancel) FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(gm.common_cancel),
            ),
            new FlatButton(
              onPressed: () {
               Navigator.of(context).pop();
               confirmCallback();
              },
              child: new Text(gm.common_sure),
            ),
          ],
        );
      });
}
