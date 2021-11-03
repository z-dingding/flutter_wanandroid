import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
import 'package:flutter_wanandroid/models/cacheconfig_entity.dart';
import 'package:flutter_wanandroid/models/user_entity.dart';

class ProfileEntity with JsonConvert<ProfileEntity> {

	UserData? user;
	String? cookies;
	int? theme;
	CacheconfigEntity? cache;
	String? lastLogin;
	//举例"zh_CN"
	String locale = "";
}
