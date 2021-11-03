import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

///首页轮播
class BannerEntity with JsonConvert<BannerEntity>  {
	late List<BannerData> data;
	late int errorCode;
	late String errorMsg;
}

class BannerData with JsonConvert<BannerData> {
	late String desc;
	late int id;
	late String imagePath;
	late int isVisible;
	late int order;
	late String title;
	late int type;
	late String url;
}
