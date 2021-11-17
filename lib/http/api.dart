
class Api{
  static const banner_api = "/banner/json";

  static const login_api ="/user/login" ;

  ///首页文章列表
  static String  articlelist (int pageNum){
    return "/article/list/$pageNum/json";
  }

  static const logout_api="/user/logout/json";

  ///问答列表
  static String answerList(int pageNum){
    return "/wenda/list/$pageNum/json ";
  }

  ///体系列表
 static const system_api = "/tree/json";

  ///体系分类列表
static String systemclassificationlist(int pageNun,int cid){
  return "/article/list/$pageNun/json?cid=$cid";
}

///导航列表
static String navigationList ="/navi/json";


///公众号列表
static String official_api = "/wxarticle/chapters/json";

///公众号的历史数据
static String officialHistoryList(int id,int pageNum){
  return "/wxarticle/list/$id/$pageNum/json";
}


///收藏站内文章
static String collectionFromSite(int id){
  return "/lg/collect/$id/json";
}

///取消收藏站内文章
  static String unCollectionFromSite(int id){
    return "/lg/uncollect_originId/$id/json";
  }

}