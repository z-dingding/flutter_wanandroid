import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class OfficialHistoryEntity with JsonConvert<OfficialHistoryEntity> {
	OfficialHistoryData? data;
	int? errorCode;
	String? errorMsg;
}

class OfficialHistoryData with JsonConvert<OfficialHistoryData> {
	int? curPage;
	List<OfficialHistoryDataDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
}

class OfficialHistoryDataDatas with JsonConvert<OfficialHistoryDataDatas> {
	bool? alreadyInHomePage;
	String? apkLink;
	int? audit;
	String? author;
	bool? canEdit;
	int? chapterId;
	String? chapterName;
	bool? collect;
	int? courseId;
	String? desc;
	String? descMd;
	String? envelopePic;
	bool? fresh;
	String? host;
	int? id;
	String? link;
	String? niceDate;
	String? niceShareDate;
	String? origin;
	String? prefix;
	String? projectLink;
	int? publishTime;
	int? realSuperChapterId;
	int? selfVisible;
	int? shareDate;
	String? shareUser;
	int? superChapterId;
	String? superChapterName;
	List<OfficialHistoryDataDatasTags>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;
}

class OfficialHistoryDataDatasTags with JsonConvert<OfficialHistoryDataDatasTags> {
	String? name;
	String? url;
}
