
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/common/global.dart';


///定义网络接口缓存对象
class CacheObject{
  //注意此写法
  //now()命名构造，获取当前时间
  //millisecondsSinceEpoch()将DateTime转时间戳
  CacheObject(this.response) : timeStamp = DateTime.now().millisecondsSinceEpoch;

  late Response response;
  //记录缓存时间
  late int timeStamp;

  //在类体中声明（定义）需要重载的操作符，声明方式跟普通的成员函数一样，只不过操作符重载函数的名字是“关键字 operator +以及紧跟其后的一个 Dart 预定义的操作符”
  //操作符重载函数“operator==”是person类的一个成员函数，所以对象p1、p2都可以调用该函数
  //if (p1 == p2) 语句相当于对象p1调用函数“operator==”，把对象p2作为一个参数传递给该函数，从而实现了两个对象的比较。
 @override
  bool operator == (Object other) {
    // TODO: implement ==
    return response.hashCode == other.hashCode;
  }



  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCacheInterceptor extends Interceptor{
  //为了确保迭代器顺序与对象插入时间的顺序一致，我们再次使用LinkedHashMap
  var cache = LinkedHashMap<String,CacheObject>();

  @override
  Future onRequest(RequestOptions options) async {
    //如果不启用缓存
   if(!Global.profile.cache!.enable){
      return options;
   }
   //refresh标记是否下拉刷新
    bool refersh = options.extra["refresh"] == true ;
   //如果是下来刷新,则先删除相关缓存
    if(refersh){
      if(options.extra["list"] == true){
        //若是列表，则将url中包含当前path的缓存全部删除(因为列表存在分页,有多个url)
        cache.removeWhere((key,v) => key.contains(options.path) );
      }else{
        //如果不是列表，则只删除url相同的缓存
        delete(options.uri.toString());
      }
      return options;
    }
    //get请求且接口允许缓存如果缓存未过期,返回Response，否则重新请求
    if(options.extra["noCache"] != true && options.method.toLowerCase() == 'get') {
     String key = options.extra["cacheKey"] ?? options.uri.toString();
     var ob =cache[key];
     if(ob != null){
       //若缓存未过期，则返回缓存内容
       if((DateTime.now().millisecondsSinceEpoch - ob.timeStamp)/1000 < Global.profile.cache!.maxAge){
         return cache[key]!.response;
       }else{
         //若缓存过期则删除缓存，继续向服务器请求
         cache.remove(key);
       }
     }
    }
  }

  @override
  Future onError(DioError err) async{
    // TODO: implement onError
    //错误状态不缓存
  }

  @override
  Future onResponse(Response response) async {
   if(Global.profile.cache!.enable){
     _saveCache(response);
   }
  }

  _saveCache(Response object){
    RequestOptions options = object.request;
    if(options.extra["noCache"] != true && options.method.toLowerCase() == "get"){
      //如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if(cache.length == Global.profile.cache!.maxCount){
        cache.remove(cache[cache.keys.first]);
      }
      String key =options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }



  void delete(key){
    cache.remove(key);
  }
}


