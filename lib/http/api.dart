
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
}