import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class SystemlistEntity with JsonConvert<SystemlistEntity> {
	List<SystemlistData>? data;
	int? errorCode;
	String? errorMsg;
}

class SystemlistData with JsonConvert<SystemlistData> {
	List<SystemlistDataChildren>? children;
	int? courseId;
	int? id;
	String? name;
	int? order;
	int? parentChapterId;
	bool? userControlSetTop;
	int? visible;
}

class SystemlistDataChildren with JsonConvert<SystemlistDataChildren> {
	List<dynamic>? children;
	int? courseId;
	int? id;
	String? name;
	int? order;
	int? parentChapterId;
	bool? userControlSetTop;
	int? visible;
}
