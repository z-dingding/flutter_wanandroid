//@dart=2.2

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/common/global.dart';
import 'package:flutter_wanandroid/http/responseinterceptor.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/common/const.dart';

import 'cacheintercept.dart';

class HttpManager {
  static const Base_Url = "https://www.wanandroid.com";
  static const Time_Out = 30000;

   Dio dio;

  static HttpManager _instance;

  static HttpManager get instance => _httpManager();

  ///私有化构造方法,通过._的方式
  HttpManager._() {
    BaseOptions options = BaseOptions(
        baseUrl: Base_Url,
        sendTimeout: Time_Out,
        receiveTimeout: Time_Out,
        connectTimeout: Time_Out,
        headers: {HttpHeaders.acceptHeader: "application/json"});
    dio = Dio(options)
    //添加响应拦截器
      ..interceptors.add(ResponseInterceptor())
      ..interceptors.add(NetCacheInterceptor());
    //如果是开发模式,就打印日志
    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(request: true, responseBody: true, error: true));
    }
  }

  ///对外提供实例化方法
  static HttpManager _httpManager() {
    //如果_instance为null,将右边的值赋给左边
    return _instance ??= HttpManager._();
  }

  ///get请求
  Future get(String url,{
    Map<String, dynamic> params,
    bool isList = false,
    bool isCache = false,
    bool isRefresh = false,
    String method = Method.GET,
    bool isLoding = false,
    BuildContext context,
  }) async{
     return request(url,context:context,params: params,isList: isList,isCache: isCache,isRefresh: isRefresh,method: method);
  }

  ///post请求
  Future post(String url, {
    Map<String, dynamic> queryParams,
    bool isList = false,
    bool isCache = false,
    bool isRefresh = false,
    String method = Method.POST,
    bool isLoding = false,
    BuildContext context,
  }) async {
    return request(url,context: context,queryParams: queryParams,isList: isList,isCache: isCache,isRefresh: isRefresh,method: method);
  }


  void request(String url,{
    //get请求参数
    Map<String, dynamic> params,
    //post请求参数
    Map<String, dynamic> queryParams,
    //是否是列表请求
    bool isList = false,
    //是否缓存
    bool isCache = false,
    //是否刷新
    bool isRefresh = false,
    String method = Method.GET,
    //是否显示加载框
    bool isLoding = false,
    BuildContext context,
    }) async {

    if(isLoding) showLoading(context);

     var cookies = Global.sharePref.getString(Const.KEY_COOKIES);

    Options options = Options(
      method: method,
      extra: {
        "list":isList,
        "noCache":!isCache,
        "refresh":isRefresh,
      },
      headers: {
        'Cookie':cookies,
      }
    );
    Response response;
    try{
       response = await dio.request(url,data:params ,queryParameters: queryParams,options: options);
    }on DioError catch(e){
      formatError(e);
    }
    //隐藏加载框
    if(isLoding)Navigator.pop(context);
    return response.data;
  }



  /// error统一处理
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      showToast("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      showToast("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      showToast("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      showToast("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      showToast("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      showToast("未知错误");
    }
  }

}


class Method {
  static const GET = "get";
  static const POST = "post";
}