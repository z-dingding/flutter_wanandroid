/// 响应拦截器

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/common/const.dart';
import 'package:flutter_wanandroid/common/global.dart';
import 'package:flutter_wanandroid/utils/toast.dart';

///响应拦截器
class ResponseInterceptor extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    //处理cookie并存储到本地
    if (response.headers["Set-Cookie"] != null) {
      //拼接Cookie成字符串
      var cookies = "";
      //将集合转化为字符串
      for (var header in response.headers["Set-Cookie"]) {
        cookies += header;
        cookies += ";";
      }
      //存储cookie
      Global.sharePref.setString(Const.KEY_COOKIES, cookies);
    }
    //获取响应的数据,处理异常情况
    var map = new Map<String, dynamic>.from(response.data);
      var errorCode = map["errorCode"];
      var errorMsg = map["errorMsg"];
      //正常请求code为0
      if (errorCode != 0 && errorCode != -1001) {
        showToast(errorMsg);
      }
      return super.onResponse(response);
    }
  }