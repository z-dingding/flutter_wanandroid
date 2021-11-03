


import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart' as Swiper;
import 'package:flutter_wanandroid/110n/gmlocalization.dart';
import 'package:flutter_wanandroid/common/icondata.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/http/api.dart';
import 'package:flutter_wanandroid/http/http_manager.dart';
import 'package:flutter_wanandroid/models/articlelist_entity.dart';
import 'package:flutter_wanandroid/models/banner_entity.dart';




class HomeRoute extends StatefulWidget {

  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with AutomaticKeepAliveClientMixin {
     //轮播对象
     BannerEntity? bannerModel ;
     //文章列表对象
     ArticlelistData? articlelistEntity;
     //总页数
     int total = 0  ;
     //列表数据原
     List<ArticlelistDataDatas> listDatas = [];

  @override
  void initState() {
      HttpManager.instance.get(Api.banner_api).then((value) => {
      setState(() {
      bannerModel = BannerEntity().fromJson(value);
      })
      });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalization gm = GmLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(gm.home),
          actions: [
            IconButton(icon: Icon(IconDatas.search), onPressed: () => searchFun()),
            IconButton(icon: Icon(IconDatas.qrcode), onPressed: ()=> qrCodeFun()),
          ],),
      body: Column(
         children: [
            //banner区域
            if(bannerModel != null)_buildBanner(context),
              _bulidListView(context)
         ],
      ),
    );
  }

  ///搜索
  void searchFun(){
    showToast("敬请期待");
  }
  ///扫一扫
  void qrCodeFun(){
    showToast("敬请期待");
  }

  ///轮播组件构造
 Widget _buildBanner(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Swiper.Swiper(
        scrollDirection: Axis.horizontal,
        autoplay: true,
        // 分页指示,指示器
        pagination:  Swiper.SwiperPagination(),
        onTap: (index){
          showToast("点击了$index");
        },
        itemBuilder: (BuildContext context, int index){
          return Image.network(
              bannerModel!.data[index].imagePath,
              fit: BoxFit.fill
          );
        },
        itemCount: bannerModel!.data.length,
      ) ,
    );
 }


 ///列表组件构造
 Widget _bulidListView(BuildContext context){
   return Expanded(
     //flutter RenderBox was not laid out
     //注意:InfiniteListView必须在宽高一定固定的容器组件中
     //必须通过设置父级宽高约束子组件
       child: InfiniteListView(
         onRetrieveData: (int page, List<ArticlelistDataDatas> items, bool refresh) async{
           //页码，拼接在连接中，从0开始。
           var res = await HttpManager.instance.get(Api.articlelist(page-1),isRefresh:page == 1,isList: true,isCache: true );
           articlelistEntity =   ArticlelistEntity().fromJson(res).data;
           items.addAll(articlelistEntity!.datas!);
           //每次都更新listDatas中的数据
           listDatas.clear();
           listDatas.addAll(items);
           //true加载更多，false没有更多数据了
           return items.length  <  articlelistEntity!.total!;
         },
         itemBuilder: (List<ArticlelistDataDatas> list, int index, BuildContext ctx){
           return articleItem(list[index], ctx, index);
         },
       ),);
 }


///列表项的构造
Widget articleItem(ArticlelistDataDatas item,BuildContext context,int index,){
  GmLocalization gm = GmLocalization.of(context);
  return ConstrainedBox(
    constraints: BoxConstraints(
    minWidth: double.infinity
  ) ,
    child:GestureDetector(
      //此处注意
      // onTap: _itemTap(index),
      onTap: () =>_itemTap(index),
      child: Container(
      margin: EdgeInsets.only(bottom: 6),
      padding:  EdgeInsets.all(10),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), //3像素圆角
        color:Colors.grey.shade200,
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0.0),
            leading: Text(item.author!.isNotEmpty? item.author! :   item.shareUser!),
            title: Text(item.superChapterName ?? item.tags![0].name),
            trailing: Text(item.niceShareDate!),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title ??gm.no_revalentMessage,style:TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
                if(item.desc != null)Text(item.desc ?? gm.no_revalentMessage,style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),)
              ],

            ),),
        ],
      ),
    )
    )
    );
}


///列表项的点击
_itemTap(index){
  showToast(listDatas[index].title!);
}

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>  true; ///保持当前页面状态


}