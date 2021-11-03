import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class UserEntity with JsonConvert<UserEntity> {
	late UserData data;
	late int errorCode;
	late String errorMsg;
}

class UserData with JsonConvert<UserData> {
	late bool admin;
	late List<dynamic> chapterTops;
	late int coinCount;
	late List<int> collectIds;
	late String email;
	late String icon;
	late int id;
	late String nickname;
	late String password;
	late  String publicName;
	late String token;
	late int type;
	late String username;
}
