
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
}