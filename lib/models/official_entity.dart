import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class OfficialEntity with JsonConvert<OfficialEntity> {
	List<OfficialData>? data;
	int? errorCode;
	String? errorMsg;
}

class OfficialData with JsonConvert<OfficialData> {
	List<dynamic>? children;
	int? courseId;
	int? id;
	String? name;
	int? order;
	int? parentChapterId;
	bool? userControlSetTop;
	int? visible;
}
