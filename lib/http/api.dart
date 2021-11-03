
class Api{
  static const banner_api = "/banner/json";

  static const login_api ="/user/login" ;
  static String  articlelist (int pageNum){
    return "/article/list/$pageNum/json";
  }

  static const logout_api="/user/logout/json";
}