import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class AnswerEntity with JsonConvert<AnswerEntity> {
	AnswerData? data;
	int? errorCode;
	String? errorMsg;
}

class AnswerData with JsonConvert<AnswerData> {
	int? curPage;
	List<AnswerDataDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
}

class AnswerDataDatas with JsonConvert<AnswerDataDatas> {
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
	List<AnswerDataDatasTags>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;
}

class AnswerDataDatasTags with JsonConvert<AnswerDataDatasTags> {
	String? name;
	String? url;
}
